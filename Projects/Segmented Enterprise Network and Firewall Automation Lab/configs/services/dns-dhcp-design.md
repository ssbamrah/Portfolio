# DNS and DHCP Design

## Split-horizon DNS

Two BIND DNS servers are authoritative for the lab domain but publish different views:

- **Private DNS:** serves Users and Infrastructure with internal host records, reverse zones, and Active Directory service records. Queries and recursion are restricted to trusted lab networks. Unresolved names are forwarded to the public DNS role.
- **Public DNS:** serves only public-facing names. Any endpoint can query it, but recursive resolution is limited to the intended lab clients and DMZ. Upstream resolvers are configured as a set in the host firewall policy.

The context records fixes to DHCP-provided DNS search settings, Active Directory SRV records, reverse-zone formatting, stale PTR records, and public resolver restrictions. It also records the `.local` namespace as a limitation because some Linux clients may try multicast DNS first.

## DHCP and relays

ISC DHCP runs on the private DNS/DHCP server. It serves a dynamic pool for Users, reservations/static assignments for Infrastructure, and reserved DMZ addresses through a relay on the edge router. The internal router relays Users DHCP traffic. The host firewall allows the necessary DHCP request/reply paths, including replies to both router relays and Users clients.

The current design gives DMZ systems addresses through DHCP relayed by the edge router. The author may change the DMZ to static addressing later; until then, DHCP relay is the deployed design.

## Validation recorded

The context reports successful lease renewal for Users and DMZ clients, DNS forward/reverse/SRV lookup checks, private DNS access restrictions, and public DNS split-horizon/recursion tests. Screenshot evidence is reported in the context but has not been added to this portfolio folder.

## Sanitization

This summary omits real hostnames, domain names, IP addresses, MAC addresses, DNS zone contents, and service credentials. Store only reviewed examples in the public portfolio.
