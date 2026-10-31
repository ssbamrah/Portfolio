# Design Decisions and Trade-offs

## VLAN-based segmentation

Separate VLANs represent user, infrastructure, DMZ, and transit networks. This makes trust boundaries visible and gives routing/firewall policy clear points to control inter-zone traffic. VLANs alone do not enforce access policy; routing and filtering must be configured and tested as well.

## Dynamic routing with OSPF

FRRouting and OSPF provide routed connectivity between the lab segments. This gives the team practice with a common routing protocol and avoids relying on a collection of manually maintained static routes. Routing reachability is not equivalent to authorization, so firewall policy remains necessary.

## Split DNS and service roles

Separate internal and public DNS roles model the different answers and exposure requirements for internal clients and external-facing services. DHCP relay supports clients whose DHCP service is located outside their local broadcast segment.

## Layered firewall controls

The design combines router-level nftables rules with host-level Linux nftables and Windows Defender Firewall controls. Network controls can constrain paths between zones; host controls can narrow access to a particular service even when a route exists. This increases policy coverage but also requires consistent rule ownership and testing at both layers.

## Ansible templates and variables

Linux firewall configuration is generated from a shared Jinja2 template with group and host variables. This reduces duplicated policy and makes host-specific exceptions explicit. The rendered configuration should be syntax-checked before applying it, and changes should be verified through both rule inspection and connection tests.

## Management channel limitation

The project materials describe WinRM over HTTP with NTLM and certificate validation disabled. This choice simplifies the isolated lab setup, but weakens server identity assurance. Document it as a limitation and use WinRM over HTTPS with trusted certificates for a stronger design.

## Scope and evidence discipline

This portfolio write-up distinguishes design intent, planned tests, and observed outcomes. A test should be called successful only when its result is supported by retained evidence. Vulnerability scan findings should include context, limitations, and remediation rather than raw scanner output alone.
