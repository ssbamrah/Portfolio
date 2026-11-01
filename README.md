<div align="center">

# Sukhmandeep Bamrah

**Cybersecurity & Infrastructure · Seneca Polytechnic**

*Hands-on in network security, enterprise infrastructure, SIEM monitoring, vulnerability assessment, and virtualization.*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-sukhmanbamrah-0A66C2?style=for-the-badge)](https://linkedin.com/in/sukhmanbamrah/)
[![GitHub](https://img.shields.io/badge/GitHub-ssbamrah-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ssbamrah)
![Status](https://img.shields.io/badge/Status-Open_to_Opportunities-22c55e?style=for-the-badge)

[Featured Project](#-featured-project) · [Skills](#-technical-skills) · [Homelab](#-homelab) · [Education](#-education) · [Contact](#-contact)

</div>

---

## 👋 About Me

I'm an Honours Bachelor of Information Technology – Cybersecurity student at Seneca Polytechnic. I learn by building: segmented enterprise networks, layered firewalls, automated host hardening, and a self-hosted Proxmox homelab. This repository is my central portfolio — a living record of projects, labs, and security-focused technical work from coursework, homelab experimentation, and independent learning.

| 🎯 Focus | 🎓 Education | 🧰 Currently Building |
|---|---|---|
| Network security · Enterprise infrastructure · Security automation | HBIT – Cybersecurity, Seneca Polytechnic (2028) | Detection engineering · SIEM & log correlation · AD security |

---

## 🧪 Featured Project

<h3><a href="Projects/segmented-enterprise-network-lab/">Segmented Enterprise Network and Firewall Automation Lab</a></h3>

Designed and built a segmented enterprise network with four security zones, OSPF routing between two Ubuntu routers, core enterprise services, and **two layers of firewalling**: hand-written router policies plus host firewalls deployed with Ansible.

[![Network topology of the segmented enterprise lab](Projects/segmented-enterprise-network-lab/diagrams/network-topology.jpg)](Projects/segmented-enterprise-network-lab/)

<table>
<tr>
<td width="50%" valign="top">

**🌐 Network & Services**
- VLAN segmentation with Open vSwitch: Users, Infrastructure, DMZ, transit
- Multi-area OSPF (FRRouting) with MD5 authentication
- Split-horizon BIND DNS and centralized ISC DHCP with relays
- Active Directory, file sharing, internal and public web services

</td>
<td width="50%" valign="top">

**🛡️ Security & Automation**
- Default-deny nftables router firewalls with anti-spoofing, NAT, and drop logging
- Host firewalls on every Linux server from one Jinja2 template, deployed with Ansible and validated with `nft -c`
- Windows Defender Firewall over WinRM; employee workstations through Group Policy
- Vulnerability scanning with Nessus, OWASP ZAP, and WPScan

</td>
</tr>
</table>

<p>
<img src="https://img.shields.io/badge/Open_vSwitch-1f6feb?style=flat-square" alt="Open vSwitch">
<img src="https://img.shields.io/badge/OSPF-FRRouting-1f6feb?style=flat-square" alt="OSPF FRRouting">
<img src="https://img.shields.io/badge/nftables-dc2626?style=flat-square" alt="nftables">
<img src="https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white" alt="Ansible">
<img src="https://img.shields.io/badge/Ubuntu_Server-E95420?style=flat-square&logo=ubuntu&logoColor=white" alt="Ubuntu Server">
<img src="https://img.shields.io/badge/Windows_Server-0078D6?style=flat-square" alt="Windows Server">
<img src="https://img.shields.io/badge/Active_Directory-0078D6?style=flat-square" alt="Active Directory">
<img src="https://img.shields.io/badge/BIND_DNS-4b5563?style=flat-square" alt="BIND DNS">
<img src="https://img.shields.io/badge/Nessus-00C176?style=flat-square" alt="Nessus">
<img src="https://img.shields.io/badge/OWASP_ZAP-00549E?style=flat-square" alt="OWASP ZAP">
</p>

**[→ Read the full project write-up](Projects/segmented-enterprise-network-lab/)**

---

## 🛠 Technical Skills

**Security & Monitoring**

![Splunk](https://img.shields.io/badge/Splunk-000000?style=for-the-badge&logo=splunk&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-005571?style=for-the-badge&logo=elasticsearch&logoColor=white)
![Logstash](https://img.shields.io/badge/Logstash-005571?style=for-the-badge&logo=logstash&logoColor=white)
![Kibana](https://img.shields.io/badge/Kibana-005571?style=for-the-badge&logo=kibana&logoColor=white)
![Snort](https://img.shields.io/badge/Snort_IDS%2FIPS-dc2626?style=for-the-badge)
![Sysmon](https://img.shields.io/badge/Sysmon-0078D6?style=for-the-badge)
![Wireshark](https://img.shields.io/badge/Wireshark-1679A7?style=for-the-badge&logo=wireshark&logoColor=white)
![Nessus](https://img.shields.io/badge/Nessus-00C176?style=for-the-badge)
![OWASP ZAP](https://img.shields.io/badge/OWASP_ZAP-00549E?style=for-the-badge&logo=owasp&logoColor=white)
![WPScan](https://img.shields.io/badge/WPScan-21759B?style=for-the-badge&logo=wordpress&logoColor=white)

**Networking & Infrastructure**

![TCP/IP](https://img.shields.io/badge/TCP%2FIP-4b5563?style=for-the-badge)
![VLANs](https://img.shields.io/badge/VLAN_Segmentation-1f6feb?style=for-the-badge)
![Open vSwitch](https://img.shields.io/badge/Open_vSwitch-1f6feb?style=for-the-badge)
![OSPF](https://img.shields.io/badge/OSPF_(FRRouting)-1f6feb?style=for-the-badge)
![nftables](https://img.shields.io/badge/nftables-dc2626?style=for-the-badge)
![DNS](https://img.shields.io/badge/DNS_(BIND)-4b5563?style=for-the-badge)
![DHCP](https://img.shields.io/badge/DHCP-4b5563?style=for-the-badge)
![VPN](https://img.shields.io/badge/VPN_(TUN%2FTAP)-4b5563?style=for-the-badge)
![SSH](https://img.shields.io/badge/SSH-4b5563?style=for-the-badge)
![Cloudflare Tunnel](https://img.shields.io/badge/Cloudflare_Tunnel-F38020?style=for-the-badge&logo=cloudflare&logoColor=white)
![Tailscale](https://img.shields.io/badge/Tailscale-242424?style=for-the-badge&logo=tailscale&logoColor=white)
![Nginx Proxy Manager](https://img.shields.io/badge/Nginx_Proxy_Manager-F15833?style=for-the-badge&logo=nginxproxymanager&logoColor=white)

**Systems Administration & Virtualization**

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Windows Administration](https://img.shields.io/badge/Windows_Administration-0078D6?style=for-the-badge)
![Active Directory](https://img.shields.io/badge/Active_Directory-0078D6?style=for-the-badge)
![Group Policy](https://img.shields.io/badge/Group_Policy-0078D6?style=for-the-badge)
![System Hardening](https://img.shields.io/badge/System_Hardening-dc2626?style=for-the-badge)
![VMware](https://img.shields.io/badge/VMware-607078?style=for-the-badge&logo=vmware&logoColor=white)
![Proxmox](https://img.shields.io/badge/Proxmox-E57000?style=for-the-badge&logo=proxmox&logoColor=white)
![Hyper-V](https://img.shields.io/badge/Hyper--V-0078D6?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

**Automation, Programming & Scripting**

![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![Jinja2](https://img.shields.io/badge/Jinja2-B41717?style=for-the-badge&logo=jinja&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![OpenSSL](https://img.shields.io/badge/OpenSSL_%2F_PKI-721412?style=for-the-badge&logo=openssl&logoColor=white)

---

## 🖥 Homelab

### Proxmox Virtualization Environment

Self-hosted Proxmox environment running multiple virtual machines and production-grade security services.

| Service | Purpose |
|---|---|
| ☁️ **Cloudflare Tunnel** | Secure public exposure without port forwarding |
| 🔐 **Authelia MFA** | Multi-factor authentication gateway |
| 🔀 **Nginx Proxy Manager** | Reverse proxy with SSL termination |
| 🌐 **Tailscale** | Zero-config remote access VPN |
| 🪟 **Windows Server** | AD, DNS, DHCP lab environment |
| 🐉 **Kali Linux** | Offensive security and penetration testing |
| 🐧 **Ubuntu Server** | General-purpose Linux services |

---

## 🎓 Education

**Honours Bachelor of Information Technology – Cybersecurity (IFS)**  
**Seneca Polytechnic** · Toronto, Ontario · *Expected Graduation: 2028*

<details>
<summary><strong>Relevant Coursework</strong></summary>
<br>

| Domain | Courses |
|---|---|
| Security | Vulnerability & Threat Analysis · Endpoint Security · Network Security · Digital Forensics & Incident Response |
| Infrastructure | Infrastructure Administration · Enterprise Infrastructure & Security · Building Networks |
| Data | Data Services & Management · Digital Data Analytics |

</details>

---

## 🔐 Interests & Learning Focus

<table>
<tr>
<td width="50%" valign="top">

**Areas of Interest**
- Cybersecurity Operations
- Enterprise Infrastructure Security
- Threat Detection & Monitoring
- SIEM & Log Analysis
- Network Security
- Virtualization & Homelabs
- Vulnerability Assessment
- Linux Administration
- Security Automation

</td>
<td width="50%" valign="top">

**Current Learning Focus**
- Security Monitoring & Detection Engineering
- Active Directory Security
- SIEM & Log Correlation
- Infrastructure Hardening
- Threat Analysis
- Security Automation & Scripting

</td>
</tr>
</table>

---

## 📫 Contact

<div align="center">

[![LinkedIn](https://img.shields.io/badge/Connect_on_LinkedIn-0A66C2?style=for-the-badge)](https://linkedin.com/in/sukhmanbamrah/)
[![GitHub](https://img.shields.io/badge/Follow_on_GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ssbamrah)

</div>

---

<sub>**Disclaimer:** All projects and labs in this repository are intended for educational and defensive security purposes only. Vulnerability testing and security tooling were performed exclusively within authorized lab and virtualized environments.</sub>
