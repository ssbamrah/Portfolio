# Lab Ansible Configuration Files

These are the actual Ansible configuration files supplied for the lab, copied into the portfolio from the shared archive. The user's clarification has been applied: the temporary public-web deny used for the professor demonstration is removed, and the intended public HTTP/HTTPS allow rule remains. Router firewalls are not in this Ansible project; r1 and r2 are hand-managed.

Ansible Vault files and passwords are deliberately excluded. The WinRM configuration in this lab uses HTTP/5985 with NTLM and disabled certificate validation; this is an isolated lab setup and should be documented as a security limitation. Review every file before publishing, especially internal addresses, hostnames, account names, and comments.