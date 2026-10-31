# Lab Ansible Configuration

These are the inventory, variables, template, and playbooks used to deploy the lab's host firewalls. See the [parent README](../README.md) for the file layout and workflow.

- Routers r1 and r2 are hand-managed and are not in this inventory.
- Ansible Vault files and passwords are excluded.
- Windows hosts are managed over WinRM on HTTP/5985 with NTLM and certificate validation disabled. This is acceptable only because the lab is isolated; use WinRM over HTTPS with trusted certificates anywhere else.
- `host_key_checking = False` in `ansible.cfg` is a lab convenience; enable it outside a lab.
