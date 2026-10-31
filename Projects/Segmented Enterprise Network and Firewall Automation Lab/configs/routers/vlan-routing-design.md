# VLAN and Routing Design

## Platform

The lab runs in VMware Workstation. Open vSwitch is installed on two Ubuntu router VMs, which also perform Layer 3 routing. Each router uses an OVS bridge with access ports and internal VLAN interfaces (SVIs).

| Segment | VLAN | Purpose |
|---|---:|---|
| Users | 10 | Admin and employee workstations |
| Infrastructure | 20 | Directory, DNS/DHCP, file, intranet, and management systems |
| DMZ | 30 | Public DNS and public web services |
| Transit | 99 | Inter-router routing link |

The edge router's external interface is outside the OVS bridge and OSPF. VLAN 40 was dropped from the design.

## Routing

FRRouting provides OSPF between the edge and internal routers. The context records interface-based areas for transit, Users, Infrastructure, and DMZ; MD5 authentication on the transit SVI; point-to-point operation on the transit link; and origination of the default route by the edge router.

An 802.1Q trunk was tested on the transit link, but the VMware virtual network corrupted tagged frames. The deployed design uses access ports in VLAN 99 on both routers instead.

## Persistence

Switch-port NICs have no IP address; gateway addresses live on the VLAN interfaces. A systemd service recreates the OVS bridge/SVIs at boot, and FRR plus DHCP relay services start after the OVS network is available. The context records the reboot-persistence test as passed.

## Publication note

This summary omits actual addresses, router IDs, authentication keys, MAC addresses, interface-to-VMnet mappings, and shell scripts. Add reviewed sanitized config excerpts only if they help explain a specific design decision.
