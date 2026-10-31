# Sanitized Configuration Notes

These files summarize the configuration recorded in the project context. They are design references, not copy-paste-ready deployment files. The original lab uses private addresses, internal hostnames, and shared credentials; those values are not reproduced here. The Ansible source archive is an older snapshot, so its automation examples should not be treated as the final deployed state without review.

## Contents

- [VLAN and routing design](routers/vlan-routing-design.md)
- [Router firewall policy](routers/firewall-policy.md)
- [DNS and DHCP design](services/dns-dhcp-design.md)

The context records that router firewalls are hand-managed, while Ansible applies host firewall policy. Router policy is intentionally not included in Ansible.
