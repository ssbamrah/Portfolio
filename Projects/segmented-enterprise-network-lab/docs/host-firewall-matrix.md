# Host Firewall Policy Matrix

This matrix summarizes the host firewall policy. The source of truth is the Ansible code in [`automation/ansible/lab-config`](../automation/ansible/lab-config/).

## Linux hosts (nftables, deployed by Ansible)

Every Linux host gets the same base policy from the shared template:

- Default-deny on input, output, and forward.
- Allow loopback and established/related traffic; drop invalid packets.
- Rate-limited ICMP for troubleshooting.
- SSH only from the admin workstation (172.16.0.2) and the Ansible node (10.10.10.14).
- Outbound DNS to the host's zone resolver, plus NTP and HTTP/HTTPS for updates.
- Rate-limited logging of everything dropped.

Host-specific rules on top of the base:

| Host | Inbound allowed | Extra outbound |
|---|---|---|
| dns-dhcp (private DNS + DHCP) | DNS from Users and Infrastructure; DHCP from Users, the DMZ, and the r1 relay | DNS forwarding to dns-public; DHCP replies to clients and both relays |
| dns-public | DNS (TCP/UDP) from any source | Recursive DNS to the upstream resolvers (1.1.1.1, 8.8.8.8); only this host may query them |
| file | SMB (139/445) and NetBIOS (137/138) from Users | None |
| internal (intranet) | HTTP/HTTPS from Users only | None |
| public, shop (DMZ web) | HTTP/HTTPS from any source, rate-limited to 25/s | DHCP renewal to dns-dhcp |
| mgmt (Ansible node) | Base policy only | SSH to Infrastructure and DMZ; WinRM to the domain controller and admin workstation |

## Windows hosts

| Host | Policy |
|---|---|
| Domain controller | Firewall on for all profiles; built-in AD DS, DNS, and File and Printer Sharing rules kept; default RDP rules disabled and replaced with RDP from admin only; WinRM from mgmt only; default any-source WinRM rule disabled |
| Admin workstation | Firewall on for all profiles; WinRM from mgmt only; inbound ICMP allowed; default any-source WinRM rule disabled |
| Employee workstations | Policy applied through the `Employee Workstation Firewall` Group Policy Object |

## Enforcement demonstration

To show that policy changes in Ansible are actually enforced, I pushed a temporary rule blocking TCP 80/443 from the admin workstation to the public web server, confirmed the block, and then removed it. The published configuration reflects the final policy, which allows that traffic.
