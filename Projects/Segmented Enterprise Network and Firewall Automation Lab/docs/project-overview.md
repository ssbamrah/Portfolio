# Project Overview

## Context

This four-person academic team project models an enterprise network in an isolated VMware Workstation environment. Lab 2 builds the network and services; Lab 3 adds host firewall controls and automation.

## Problem and objective

An enterprise network needs to separate user systems from infrastructure and public services, allow required business traffic, and limit unnecessary paths. The project implements these ideas in a virtual topology and adds host-level filtering so that controls exist both at network boundaries and on individual servers.

## Main capabilities

- Open vSwitch VLAN segmentation for Users (VLAN 10), Infrastructure (VLAN 20), DMZ (VLAN 30), and router transit (VLAN 99).
- FRRouting with OSPF and MD5 authentication between the routers.
- Split DNS and DHCP services, including relay behavior where required by the design.
- Directory, file, intranet, and public web service roles.
- Stateful nftables filtering at router and Linux-host layers.
- Ansible-managed Linux host firewall configuration using Jinja2 templates and host/group variables.
- Windows Defender Firewall policy for the domain controller and admin workstation; employee endpoints are managed through an AD Group Policy Object.
- Validation and connectivity/security test plans.

## Work phases

1. **Network foundation:** virtual switching, VLANs, routing, addressing, and shared services.
2. **Service deployment:** directory, DNS, DHCP, file, intranet, and public application roles.
3. **Layered controls:** router firewalls followed by host firewall policy.
4. **Automation and validation:** Ansible templates, variables, deployment playbooks, and documented tests.
5. **Assessment and reporting:** vulnerability-scan interpretation and final findings. This reporting work remains in progress.

## Current status

The context records Lab 2 functional tests and scans as completed, with the scan analysis/write-up still pending. It records Lab 3 host firewalls as applied and working across Linux and selected Windows systems. Router firewalls remain hand-managed. A temporary deny rule was used to demonstrate Ansible enforcement and removed afterward; the intended policy allows that service traffic. Confirm the status of the remaining reports and whether an IDS was later added.

## Team attribution

The course project was assigned to a four-person group; the author reports completing the project work independently.
