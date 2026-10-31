# Design Decisions and Trade-offs

## VLAN-based segmentation

I split the network into Users, Infrastructure, DMZ, and a dedicated router transit VLAN. Each trust boundary then becomes a routed hop where policy can be enforced. VLANs alone don't enforce access, though, so every boundary is backed by router firewall rules.

## Two routers instead of one

r1 is the edge router: it owns the WAN, NAT, and the DMZ. r2 is the internal router: it owns Users and Infrastructure. Because of this split, the DMZ and the Internet sit on the same side of r2, and r2 treats everything arriving from the transit link as untrusted. A compromised DMZ server still has to cross r2's policy to reach internal systems.

## OSPF with authentication

FRRouting OSPF replaces a set of hand-maintained static routes. Each segment is its own area, with passive interfaces, so adjacencies form only on the transit link. MD5 authentication on area 0 stops a rogue device from injecting routes. Routing reachability is still not authorization, so firewall policy stays necessary.

## Split-horizon DNS

Internal clients need internal records and AD SRV records. External clients should only ever see the public names. Two BIND servers give each audience a different view of the same domain. The private server only accepts queries from trusted internal ranges, and the public server limits recursion so it can't be used as an open resolver.

## Centralised DHCP with relays

A single DHCP server in Infrastructure keeps addressing in one place, and the routers relay for the other segments. The trade-off is a small, explicitly allowed DHCP path from the DMZ to Infrastructure. Moving the DMZ to static addressing would remove that path.

## Layered firewalls

Router rules control traffic between zones. Host rules narrow access to each individual service and cover traffic that stays inside one VLAN. Running both layers means managing two rule sets and testing both, which I accepted for the defense-in-depth benefit.

## Ansible templates instead of per-host rule files

One Jinja2 template, combined with shared, per-zone, and per-host variables, generates every Linux host firewall. Common rules (loopback, established traffic, management SSH, ICMP, logging) are defined once, and each host file lists only its exceptions. The template is validated with `nft -c` before it's written, so a syntax error can't lock a host out.

## Routers kept out of Ansible

The routers carry OSPF, NAT, and the zone-boundary policy. A bad automated push there could cut off the management node itself. I kept them hand-managed for this lab, and bringing them under automation is listed as a next step.

## WinRM over HTTP (accepted limitation)

WinRM uses HTTP with NTLM and certificate validation disabled. This kept the isolated lab simple, but the server's identity isn't verified. The stronger design is WinRM over HTTPS with certificates from a trusted CA.
