# Ansible Host Firewall Automation

This folder holds the Ansible project that deploys the **host-based firewalls** in the lab. The firewalls are the second layer of defense, behind the router firewalls on r1 and r2. Every Linux server gets an nftables ruleset generated from one template, and the domain controller and admin workstation get scoped Windows Defender Firewall rules. The routers are configured by hand and are deliberately not managed here.

All code is in [`lab-config/`](lab-config/). For where each host sits in the network, see the [network topology diagram](../../diagrams/network-topology.jpg).

## How it works

```
mgmt (10.10.10.14) - Ansible control node
 ├── SSH ───▶ Linux hosts (infra + dmz)  ──▶ site.yml     ──▶ nftables from one Jinja2 template
 └── WinRM ─▶ ad (10.10.10.10)           ──▶ windows.yml  ──▶ Windows Defender Firewall
             admin (172.16.0.2)          ──▶ clients.yml  ──▶ Windows Defender Firewall
```

Employee workstations aren't managed by Ansible. Their firewall policy comes from the Active Directory GPO `Employee Workstation Firewall`.

## Files

| File | What it does |
|---|---|
| [`ansible.cfg`](lab-config/ansible.cfg) | Points at `inventory.ini`, uses sudo for privilege escalation, and sets YAML output |
| [`inventory.ini`](lab-config/inventory.ini) | Hosts grouped by security zone and connection type |
| [`group_vars/all/main.yml`](lab-config/group_vars/all/main.yml) | Values shared by every host: management sources, zone subnets, key servers, global toggles |
| [`group_vars/infra.yml`](lab-config/group_vars/infra.yml) | Infrastructure zone: use the private DNS resolver |
| [`group_vars/dmz.yml`](lab-config/group_vars/dmz.yml) | DMZ zone: use the public DNS resolver; allow the DHCP lease path to the private DHCP server |
| [`host_vars/*.yml`](lab-config/host_vars/) | Each host's own inbound services and extra outbound needs |
| [`templates/nftables.conf.j2`](lab-config/templates/nftables.conf.j2) | The one nftables template every Linux host is built from |
| [`site.yml`](lab-config/site.yml) | Installs nftables, renders and validates the ruleset, and reloads the firewall |
| [`windows.yml`](lab-config/windows.yml) | Domain controller firewall |
| [`clients.yml`](lab-config/clients.yml) | Admin workstation firewall |

## Inventory

| Group | Hosts | Connection |
|---|---|---|
| `infra` (VLAN 20) | dns-dhcp `.11`, file `.12`, internal `.13`, mgmt `.14` | SSH as `ubuntu` (mgmt runs locally) |
| `dmz` (VLAN 30) | public `.10`, shop `.11`, dns-public `.12` | SSH as `ubuntu` |
| `linux` | Parent group of `infra` and `dmz` | Target of `site.yml` |
| `windows` | ad `10.10.10.10` | WinRM |
| `clients` | admin `172.16.0.2` | WinRM |

## Variable layers

Policy is split into three layers, so each rule is written only once:

1. **All hosts** (`group_vars/all`):
   - `admin_ip` and `mgmt_ip`: the only allowed SSH sources.
   - `users_net`, `infra_net`, `dmz_net`, `transit_net`: zone subnets.
   - `dns_private`, `dns_public`, `ad_host`: key service hosts.
   - `upstream_dns`: Internet resolvers (1.1.1.1, 8.8.8.8).
   - `allow_internet`, `allow_ntp`: global toggles for update and time traffic.
2. **Zone** (`group_vars/infra.yml`, `group_vars/dmz.yml`): which resolver the zone uses (split-horizon DNS), and whether the DMZ DHCP path is open.
3. **Host** (`host_vars/<host>.yml`):
   - `inbound_rules`: the services this host offers, and to whom.
   - `extra_outbound`: anything else this host needs to reach.
   - `drop_rules` (optional): explicit logged blocks.

Any toggle can be overridden per host, for example `allow_internet: false` to cut a server off from the Internet.

## The nftables template

Every Linux host gets `flush ruleset` followed by one `inet filter` table, with all three chains set to **policy drop**.

**Input** (evaluated top to bottom):
1. Accept loopback, accept established/related traffic, drop invalid packets.
2. Optional `drop_rules`: logged blocks evaluated before any allow. This hook is how I demonstrated enforcement (see below).
3. ICMP troubleshooting types, rate-limited to 10/s.
4. SSH only from the admin workstation and the mgmt node.
5. The host's `inbound_rules`. A rule can be open to `any` source or restricted to a subnet or host, with an optional rate limit.
6. Log whatever is left (rate-limited to 5/s). The policy then drops it.

**Forward:** drop everything. Hosts are endpoints, not routers.

**Output:**
1. Accept loopback and established/related traffic.
2. DNS only to the zone's resolver.
3. NTP and HTTP/HTTPS updates, if the toggles allow them.
4. DMZ only: the DHCP lease and renewal path to dns-dhcp.
5. The host's `extra_outbound` rules. A list of destinations is rendered as an nftables set.
6. ICMP; then log whatever is left, which the policy drops.

Default-deny on **outbound** traffic as well as inbound means a compromised server can't freely reach other hosts or the Internet.

## Per-host policy

| Host | Inbound allowed (in addition to SSH from admin/mgmt and ICMP) | Extra outbound |
|---|---|---|
| **dns-dhcp** | DNS 53 TCP/UDP from Users and Infrastructure; DHCP 67 from Users, the DMZ, and the r1 relay | DNS forwarding to dns-public; DHCP replies to Users clients and both relays |
| **dns-public** | DNS 53 TCP/UDP from any source | Recursive DNS to 1.1.1.1 and 8.8.8.8. It's the only host allowed to query Internet resolvers |
| **file** | SMB 139/445 and NetBIOS 137/138 from Users | None |
| **internal** | HTTP/HTTPS from Users only | None |
| **public** | HTTP/HTTPS from any source, rate-limited to 25/s | None |
| **shop** | HTTP/HTTPS from any source, rate-limited to 25/s | None |
| **mgmt** | None | SSH to Infrastructure and the DMZ; WinRM 5985 to ad and admin |

## Windows hosts

**Domain controller (`windows.yml`)**
- Firewall enabled on the Domain, Private, and Public profiles.
- Built-in Active Directory Domain Services, DNS Service, and File and Printer Sharing rule groups kept enabled, so AD keeps working.
- The default Remote Desktop rules are disabled and replaced with **RDP 3389 from the admin workstation only**.
- **WinRM 5985 from mgmt only**; the default any-source WinRM rule is disabled.

**Admin workstation (`clients.yml`)**
- Firewall enabled on all profiles.
- **WinRM 5985 from mgmt only**; the default any-source WinRM rule is disabled.
- Inbound ICMPv4 allowed for troubleshooting.
- Outbound is left at the Windows default, because the admin workstation is the jump box that SSHes out to every VM.

## Safety features

- **Validation before deployment:** the template task uses `validate: nft -c -f %s`. If the rendered ruleset fails nftables' syntax check, Ansible refuses to write it, so a typo can't lock a host out.
- **Management access is built into the template:** SSH from admin and mgmt is part of the base policy, so no host-specific change can remove it by accident.
- **Reload only on change:** a handler reloads nftables only when the file actually changed.
- **Dry runs:** `--check --diff` shows exactly which rules would change before anything is applied.
- **Logging:** every dropped packet is logged with a per-host prefix (for example `dns-dhcp-IN-DROP`), which makes testing and troubleshooting straightforward.

## Running it

```bash
cd lab-config
ansible-playbook site.yml --check --diff        # preview changes on all Linux hosts
ansible-playbook site.yml                       # apply to all Linux hosts
ansible-playbook site.yml --limit file          # apply to one host
ansible-playbook windows.yml --ask-vault-pass   # domain controller
ansible-playbook clients.yml --ask-vault-pass   # admin workstation
```

Windows credentials are stored in Ansible Vault. The vault files are not included in this repository.

## Enforcement demonstration

To prove that Ansible changes were really enforced, I added a temporary `drop_rules` entry blocking TCP 80/443 from the admin workstation to the public web server. I pushed it, confirmed the block, then removed the rule. The configuration in this folder is the final policy.

## Limitations

- **WinRM** runs over HTTP (5985) with NTLM and certificate validation disabled. That's acceptable only in an isolated lab; the stronger setup is WinRM over HTTPS (5986) with certificates from a trusted CA.
- **`host_key_checking = False`** in `ansible.cfg` is a lab convenience and should be enabled anywhere else.
- **The routers aren't automated.** Their nftables policies are in [`configs/routers`](../../configs/routers/) and are maintained by hand.
