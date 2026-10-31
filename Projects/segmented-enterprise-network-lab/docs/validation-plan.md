# Validation

| Area | Test | Expected result | Result |
|---|---|---|---|
| VLANs, routing, persistence | Inspect OVS tags and SVIs and OSPF neighbours; reboot both routers | VLANs and routes come back; OSPF reaches Full | Passed |
| DHCP | Renew leases on Users and DMZ clients; follow the relay path | Correct lease, gateway, and DNS server returned | Passed after correcting the relay reply rules |
| Private and public DNS | Forward, reverse, and AD SRV lookups; queries from unauthorized sources; recursion attempts on public DNS | Private DNS refuses untrusted sources; public DNS exposes only public names and limits recursion | Passed (BR-06 to BR-09) |
| Service access and zone boundaries | Public and internal websites, domain login, file share, external and DMZ ingress, SSH, ICMP, traceroute | Allowed services work; prohibited paths are dropped and logged | Passed (BR-10 to BR-17) |
| Linux host firewalls | Render with Ansible, validate with `nft -c`, apply, inspect rules and logs | Default-deny policy active; management access preserved | Passed; enforcement demonstrated with a temporary block rule |
| Windows host firewalls | Scoped RDP and WinRM on the domain controller and admin workstation; employee GPO | Management reachable only from the intended sources | Passed |
| Vulnerability assessment | Nessus internal and external, OWASP ZAP, WPScan | Findings prioritized and mapped to mitigations | Scans complete; write-up in progress |
