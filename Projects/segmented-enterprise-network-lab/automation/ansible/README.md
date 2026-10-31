# Ansible Host Firewall Automation

The project's Ansible code lives in [`lab-config/`](lab-config/README.md). It manages host firewalls only; the routers are configured by hand.

| File | Purpose |
|---|---|
| `inventory.ini` | Hosts grouped by security zone (`infra`, `dmz`), plus the Windows hosts (`windows`, `clients`) |
| `group_vars/all/main.yml` | Shared values: admin and mgmt addresses, zone subnets, key service hosts, internet/NTP toggles |
| `group_vars/infra.yml`, `group_vars/dmz.yml` | Per-zone resolver and DMZ DHCP settings |
| `host_vars/*.yml` | Per-host inbound and outbound exceptions |
| `templates/nftables.conf.j2` | The single nftables template every Linux host is built from |
| `site.yml` | Deploys the Linux host firewalls |
| `windows.yml` | Domain controller firewall (Windows Defender Firewall over WinRM) |
| `clients.yml` | Admin workstation firewall |

## Linux workflow

1. Shared, zone, and host variables are merged for each host.
2. The template is rendered to `/etc/nftables.conf`. Ansible's `validate: nft -c -f %s` rejects the file if it fails the syntax check, so a broken ruleset is never written.
3. A handler reloads nftables only when the file changed.

```bash
ansible-playbook site.yml --check --diff   # preview changes
ansible-playbook site.yml                  # apply to all Linux hosts
ansible-playbook site.yml --limit file     # one host
ansible-playbook windows.yml --ask-vault-pass
```

Vault files and credentials are not included in this repository.
