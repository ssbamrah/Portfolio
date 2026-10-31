# Router Firewall Policy

## Scope and ownership

The two router VMs use stateful nftables rulesets with default-deny behavior. These router firewalls were carried forward from Lab 2 and are managed by hand. Ansible automation applies to host firewalls; the routers are intentionally excluded.

## Policy summary

- Apply anti-spoofing checks and zone-specific forwarding rules.
- Prevent External and DMZ systems from initiating connections into Users or Infrastructure.
- Permit explicitly required services, including approved DNS, public web access, administration, and troubleshooting traffic.
- Limit SSH management access to the designated administrator and Ansible management host where applicable.
- Permit web/NTP egress and perform NAT only at the edge router.
- Log representative denied traffic.

## Lab 2 verification recorded in context

The context lists tests for access to private DNS, public DNS recursion, public and internal websites, domain and file services, external/DMZ ingress, SSH authorization, ICMP, traceroute, default-deny behavior, and reboot persistence. It reports functional tests with screenshots. The project validation page distinguishes those reported results from evidence currently present in the portfolio.

## Accepted risk

The context records a UDP traceroute range accepted early in both routers' forward chains. In its recorded position, it precedes zone and anti-spoofing rules, allowing that UDP range across otherwise restricted paths and bypassing source checks for those packets. This was retained for full traceroute visibility. The risk and rationale should remain visible in the final risk assessment.

## Cross-zone management exception

Lab 3 added a narrow router forwarding path so the management VM can reach the admin workstation over WinRM. Other Infrastructure-to-Users WinRM traffic remains denied. The context notes that management-to-domain-controller traffic is within one VLAN and therefore is enforced by host firewalls rather than the router's forwarding chain.

Actual rules, addresses, interface names, and logging prefixes are omitted from this portfolio summary.
