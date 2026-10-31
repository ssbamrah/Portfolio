# Validation Plan

This is a test plan, not a record that every test passed. Add date, test source/destination, expected result, actual result, and evidence link for each executed test.

| Area | Check | Expected result | Status |
|---|---|---|---|
| VLANs, routing, persistence | Inspect OVS tags/SVIs and OSPF; reboot both routers | VLANs/routes return and OSPF reaches Full | Context records complete with screenshots |
| DHCP | Renew leases on Users and DMZ clients; observe relay path | Correct lease, gateway, and DNS settings are returned | Context records complete; relay reply rules were corrected |
| Private/public DNS | Test forward, reverse, and AD SRV records; test unauthorized private queries and public recursion | Private DNS is restricted; public DNS exposes only public records and recursion is limited | Context records BR-06 through BR-09 complete with screenshots |
| Service access and zone boundaries | Test public/internal websites, domain login, file share, external/DMZ ingress, SSH, ICMP, and traceroute | Intended services work; prohibited paths are denied and logged | Context records BR-10 through BR-17 complete with screenshots |
| Linux host firewall automation | Validate rendered policy with `nft -c`, apply via Ansible, inspect rules/logs | Default-deny host policy is deployed and management access remains available | Context says applied and working; temporary deny used for demonstration |
| Windows host controls | Test AD/admin firewall rules, scoped WinRM/RDP, and employee GPO | Management paths are restricted to intended sources | Context says applied and working |
| Vulnerability assessment | Review Nessus internal/external, OWASP ZAP, and WPScan results | Findings are prioritized, assessed, and mapped to mitigations | Scans complete; written assessment remains pending in context |

## Evidence notes

The context reports screenshots for the functional tests, but they have not been copied into this portfolio. Use sanitized screenshots, command output, or short test records. Remove credentials, personal identifiers, internal hostnames, and unnecessary network details before publishing. Keep planned criteria separate from observed results.
