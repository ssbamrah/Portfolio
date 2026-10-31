# Ansible Reference Examples

These sanitized examples describe the project's automation pattern. They are portfolio references, not a ready-to-run copy of the live lab. The example inventory uses documentation-only addresses and placeholder credentials. Review the target OS, interfaces, variable values, and management access before adapting them.

The examples intentionally contain no Vault files, passwords, private keys, actual addresses, or real hostnames. Router firewall policy is outside this automation set. Windows and client automation are summarized in the project docs; use reviewed project playbooks only after sanitizing them.

## Linux host firewall flow

1. Select a host from the example inventory.
2. Load common defaults and that host's policy variables.
3. Render `templates/nftables.conf.j2` to a temporary path.
4. Validate the candidate using `nft -c -f` before installing it.
5. Apply the reviewed policy and confirm the active rules and expected network behavior.

Never run the examples against an unreviewed or production inventory. Keep secrets in Ansible Vault or an approved secrets manager; do not add secret material to this portfolio.
