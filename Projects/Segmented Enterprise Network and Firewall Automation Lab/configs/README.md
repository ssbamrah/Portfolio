# Configuration Files

This directory contains the actual configuration files recorded in the project context, including OVS, netplan, FRR/OSPF, DHCP relay, router nftables, DHCP server, and private/public BIND DNS files. The files under `routers/` and `services/` were extracted from the context document's configuration record.

The Ansible host-firewall project files are under [`../automation/ansible/lab-config`](../automation/ansible/lab-config/README.md). Router firewalls are manually managed and are not part of Ansible automation.

## Publication and use notes

- These are lab configurations, not production templates. Review before applying them.
- The private lab addresses, hostnames, MAC addresses, and DNS domain are retained because they are part of the actual configuration. Remove or replace them if you prefer not to publish lab topology details.
- The OSPF MD5 key is replaced with `REPLACE_WITH_OSPF_MD5_KEY`; restore the secret only in the private lab.
- Ansible Vault files and decrypted passwords are excluded.
- In the Ansible `public` host policy, the temporary deny used for demonstration is removed; the intended HTTP/HTTPS allow rule remains.
- Confirm that these context-file versions match the final live lab before treating them as current deployment backups.
