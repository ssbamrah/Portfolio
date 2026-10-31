# Project Overview

## Objective

An enterprise network has to keep user systems, internal infrastructure, and public-facing services apart, while still allowing the traffic the business actually needs. I built that in an isolated VMware Workstation lab, then added host-level filtering, so that controls exist both at network boundaries and on each individual server.

## Phases

1. **Network foundation:** Open vSwitch VLANs, Layer 3 SVIs, OSPF routing, and addressing.
2. **Core services:** Active Directory, split-horizon DNS, DHCP with relays, file sharing, and internal and public web servers.
3. **Router firewalls:** default-deny nftables policy on both routers, with anti-spoofing and zone-boundary rules.
4. **Host firewalls and automation:** Ansible-generated nftables on every Linux server, Windows Defender Firewall on the domain controller and admin workstation, and Group Policy for employee workstations.
5. **Testing and assessment:** functional testing of every requirement, plus vulnerability scanning with Nessus, OWASP ZAP, and WPScan.

## Capabilities

- VLAN segmentation for Users (10), Infrastructure (20), DMZ (30), and router transit (99).
- Multi-area OSPF (FRRouting) with MD5 authentication on the backbone.
- Split-horizon BIND DNS and centralised ISC DHCP with relays on both routers.
- Stateful nftables filtering at both the router and host layers.
- Ansible-managed host firewalls built from a single validated Jinja2 template.
- Scoped management access: SSH, RDP, and WinRM only from the admin workstation and the management node.

## Status

| Area | Status |
|---|---|
| Network, services, router firewalls | Complete; 17 functional requirements tested |
| Host firewalls and Ansible automation | Complete; applied and working on all Linux hosts, the domain controller, and the admin workstation |
| Vulnerability scans | Complete (Nessus internal/external, OWASP ZAP, WPScan) |
| Vulnerability assessment write-up | In progress |
