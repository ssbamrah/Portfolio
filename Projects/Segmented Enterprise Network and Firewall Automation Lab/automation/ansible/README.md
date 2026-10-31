# Ansible Reference Examples

`lab-config/` contains the project Ansible playbooks, inventory, variables, and nftables template. The files at this directory level are smaller sanitized reference examples. Review lab-specific values and access before adapting any file.

Vault files and decrypted passwords are excluded. Router firewall policy is outside this automation set because the routers are hand-managed. The `public` host policy in `lab-config/` reflects the intended allowed HTTP/HTTPS access; the temporary deny used during the Ansible demonstration was removed.

## Linux host firewall flow

1. Select a host from the example inventory.
2. Load common defaults and that host's policy variables.
3. Render `templates/nftables.conf.j2` to a temporary path.
4. Validate the candidate using `nft -c -f` before installing it.
5. Apply the reviewed policy and confirm the active rules and expected network behavior.

Never run the examples against an unreviewed or production inventory. Keep secrets in Ansible Vault or an approved secrets manager; do not add secret material to this portfolio.
