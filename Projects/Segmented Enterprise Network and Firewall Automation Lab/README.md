# Segmented Enterprise Network and Firewall Automation Lab

## Project summary

A four-person team project for Seneca's SPR500 course. Lab 2 establishes a segmented virtual enterprise network and services; Lab 3 adds host firewall controls and Ansible automation. Router firewalls remain hand-managed.

The environment is a controlled academic lab. All addresses, names, and examples in this portfolio version are sanitized. This page describes the project design; evidence and test results will be added as they are reviewed.

## Goals

- Segment user, infrastructure, DMZ, and transit traffic.
- Route between network segments and provide essential DNS and DHCP services.
- Expose selected DMZ services while restricting access to internal systems.
- Add host-based firewall policy as a second control layer.
- Automate Linux firewall deployment with Ansible and validate generated rules before applying them.
- Assess the design with documented connectivity, firewall, and vulnerability testing.

## Architecture at a glance

The environment uses VMware Workstation and Open vSwitch VLANs for Users (10), Infrastructure (20), DMZ (30), and router transit (99). FRRouting runs OSPF with MD5 authentication. Services include split-horizon DNS, DHCP with relays, Active Directory, file and intranet services, and two public web applications. Router nftables enforces network boundaries; Linux nftables and Windows Defender Firewall provide host controls.

See [architecture](docs/architecture.md), [design decisions](docs/design-decisions.md), and the [host firewall policy matrix](docs/host-firewall-matrix.md).

## Automation

The `automation/ansible` directory contains sanitized reference examples based on the project approach. They are not a turnkey deployment bundle. Replace the example inventory and variables with reviewed lab values before use. Secrets and vault data are intentionally excluded.

## Status and evidence

The context record says Lab 2 implementation, 17 functional requirements, screenshots, and scans using Nessus, OWASP ZAP, and WPScan are complete. Lab 3 host firewalls are recorded as applied and working on Linux hosts, the management VM, the domain controller, and admin workstation; employee endpoints use an AD Group Policy Object. A temporary deny rule demonstrated Ansible enforcement and was removed afterward; the intended policy allows that service traffic.

The context lists the vulnerability-scan assessment and final-report scan summary/conclusion as outstanding for Lab 2. Lab 3 migration/report materials and TVRA were also listed as unfinished. Confirm their current status before publication. The logbook is complete and is being added to the portfolio. The DMZ currently receives addresses by DHCP through the edge-router relay; static addressing is a possible future change.

## Team project and individual contribution

Although the course project was assigned to a four-person group, the author reports completing the project work independently.

## Ethical scope

All security testing was intended for the team's isolated virtual lab and course-approved targets. No real organization or public system is in scope.
