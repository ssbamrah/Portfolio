# Host Firewall Policy Matrix

This matrix summarizes the host firewall rules recorded in the project context. It is a sanitized design summary, not a replacement for the original Ansible source or Windows policy exports.

## Linux hosts managed with Ansible

The shared nftables template uses default-deny input, forwarding, and output policies. It permits loopback and established/related connections, drops invalid input, rate-limits ICMP troubleshooting traffic, allows SSH only from the admin workstation and management node, applies optional host-specific logged deny rules before service allows, and adds host-specific inbound/outbound service rules. The playbook validates a candidate ruleset with `nft -c` before applying it.

| Host role | Inbound policy | Outbound exceptions |
|---|---|---|
| Private DNS/DHCP | DNS from Users and Infrastructure; DHCP requests/relay traffic from Users and DMZ | DNS to public DNS; DHCP replies to client and relay paths; a logged SSH deny from admin was used so management remained through the control node |
| Public DNS | TCP/UDP DNS queries from any endpoint | Recursive DNS to the configured upstream resolvers |
| File server | SMB and NetBIOS from Users | Common resolver, NTP, and update allowances |
| Internal web | HTTP/HTTPS from Users only | Common resolver, NTP, and update allowances |
| Corporate web and e-commerce | Rate-limited HTTP/HTTPS from any endpoint | Common resolver, NTP, and update allowances |
| Management node | No application service inbound beyond common management/troubleshooting policy | SSH to Infrastructure and DMZ; WinRM to the domain controller and admin workstation |

## Windows hosts

| Host role | Recorded policy |
|---|---|
| Domain controller | Firewall enabled on all profiles; built-in AD DS, DNS, and file/printer-sharing groups retained; RDP limited to admin; WinRM limited to management; default any-source WinRM rule disabled |
| Admin workstation | Firewall enabled on all profiles; WinRM limited to management; inbound ICMP allowed for troubleshooting; default any-source WinRM rule disabled |
| Employee endpoints | Firewall policy applied through the AD GPO named `Employee Workstation Firewall` |

## Demonstration rule

The author clarifies that a temporary block of TCP 80/443 from the admin workstation to the public web host was used during the lab demonstration to show that Ansible could block the ports. The block was removed afterward. The intended service policy allows the traffic. Document the demo as a deliberate enforcement test and do not describe it as the final access policy.

## Security note

The context describes WinRM over HTTP with NTLM and server certificate validation disabled for the isolated lab. This lacks server authentication; the context lists HTTPS WinRM as the stronger treatment. The actual credentials are stored in Ansible Vault and are not included here.
