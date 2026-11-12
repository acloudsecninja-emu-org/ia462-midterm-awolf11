# Midterm

## What this repo is

This repository contains a security hardening lab demonstrating defensive practices across Linux, Windows, and Docker. It includes host hardening configurations, Windows security baselines, Windows event log analysis, a hardened Flask container, vulnerability scans, dependency pinning, and a CI/CD pipeline that builds and scans the Docker image. Deliverables are organized in their respective section folders.

## Cross-platform hardening comparison

| Area | Linux host | Windows host | Docker container |
|---|---|---|---|
| Kernel model | Monolithic, open-source kernel | Hybrid Kernel (Uses monolithic and microkernel architecture) | Containers share the host kernel. Namespaces and cgroups isolate processes and resources but not a separate kernel. |
| Access control | Users and groups, file permissions, sudo policy, PAM, and SELinux or AppArmor. | User accounts, groups, access-control lists, policy settings, and security subsystem. | Non-root user, dropped capabilities, read only filesystem, restricted Docker daemon settings. |
| Auditing | Terminal transcript, SUID and world writable file list, systemd services, and Lynis audit reports. | PowerShell transcript, Security event log, PowerShell script logging, and Sysmon. | Build and runtime monitoring, Trivy and Grype scans, Syft SBOM, and Docker Security Bench report. |
| Hardening standard | Lynis suggestions, only install needed software, firewall rules (UFW), and SElinux or AppArmor. | Enable Windows Defender, use a firewall, disable legacy protocols like SMBv1, and audit policies. | Start with a minimal base image, image scanning with a CI/CD pipeline, pin image versions with a hash, and runtime restrictions. |
| Common attack surface | Misconfigured privileges, exposed and unused services, and SSH misconfiguration. | Exposed services or protocols, malicious scripts, Active Directory, and Kerberos. | Vulnerable image packages or dependencies, excessive container privileges, root user, and unscanned images. |

Linux and Windows hardening focuses on host accounts, services, policies, and auditing. Docker shares the hosts kernel so those steps still apply. Additional Docker hardening restricts allowed kernel calls and uses image scanning.

## Supply-chain threat model

An attacker targeting the repository might introduce vulnerable or malicious dependencies, exploit a vulnerable base image, tamper with CI/CD actions, or take advantage of unnessisary container privileges at runtime. The repository's controls are intended to reduce these risks.

| Attacker attempt | Control in place | Slide reference |
|---|---|---|
| Add vulnerable Python package or downgrade a dependency to a vulnerable version | dependency pins, a hash locked requirements file, and Dependency Review configured to fail on high severity | Week 8 - Dependency Management & Version Control for Github |
| Use a vulnerable or changing base image | pinned base image and Trivy image scanning |  Week 6 - Docker Containers & Virtualization |
| Compromise the CI/CD pipeline through third party action reference | Pin third party actions to full commit SHAs |  Week 10 - Automation & Pipeline Security & Supply Chain Security |
| Escape or gain more privilege inside the container | Run as a non-root user, drop all capabilities, use a read-only filesystem, and apply a custom seccomp profile | Week 7 - Enterprise Policy Management for Docker, Windows & Linux |
| Exploit a misconfigured host or exposed service | Linux service and SSH hardening, Windows firewall, and Windows Defender | Week 4 - System Administration & Policy for Docker , Windows & Linux |


## Which section proves which learning objective

- Section 1 — Linux Host Hardening + Lynis: matches “Implement Windows and Linux best practices to protect against Supply Chain Attacks”
- Section 2 — Windows Baseline + Event Log Analysis: matches “Utilize Supply Chain Security Techniques across Windows, Linux, and Docker container environments”
- Section 3 — Docker Hardened Build + Runtime Controls: matches “Apply enterprise patch and policy management for Docker Containers, including container hardening”
- Section 4 — Trivy + Syft + Grype Scan Report: matches “Understand and integrate Software Bill of Materials (SBOM) into Docker Container workflows”
- Section 5 — Policy Enforcement: matches “Apply enterprise patch and policy management for Docker Containers, including container hardening”
- Section 6 — Dependency Pinning + Dependabot + Dependency Review Gate: matches “Apply Dependency Pinning, Version Control, and Hashing to reduce surprise supply chain attacks”, “Configure and manage third party security scanners within a GitHub CI/CD pipeline”, and “Perform Vulnerability Management: scan, patch, and retest continuously using CI/CD techniques in GitHub” 
