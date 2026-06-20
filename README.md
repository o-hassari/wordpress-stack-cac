# 🚀 Wordpress Stack CaC - Deployment Guide

Welcome to the documentation for the application deployment stack. This guide details the necessary steps for setting up our complete environment, including a MariaDB Galera Cluster, WordPress CMS, and Active-Passive Load Balancing.

---

## 📋 Table of Contents
1. [⚙️ Technical Prerequisites](#technical-prerequisites)
2. [💾 Deployment Phases (Installation Steps)](#deployment-phases-installation-steps)
3. [🧩 Component Configuration Details](#component-configuration-details)
4. [⚠️ Critical Notes & Networking](#critical-notes--networking)

---

## ⚙️ Technical Prerequisites
Before beginning the installation, ensure that the following software is installed on your host machine:

*   **Virtualization:** VirtualBox
*   **Cloud Provisioning:** Vagrant
*   **Automation/Orchestration:** Ansible (Ensure necessary modules are available).

### VM Specifications
You must provision at least **two virtual machines** for the cluster. Each VM must meet these minimum specifications:
*   💾 RAM: 512 MB minimum
*   ⚙️ CPU: 2 cores minimum

---

## 💾 Deployment Phases (Installation Steps)

The deployment process is sequential and must follow these three phases to guarantee stable cluster initialization.

### Phase I: Machine Provisioning (Vagrant)
Deploy the complete set of virtual machines using the designated Vagrant files.

```bash
vagrant up
```

### Phase II: Galera Cluster Setup (DB Layer)
Access the machines using the SSH keys located in the `/sshkey` directory. Run the primary playbook responsible for initializing the MariaDB cluster structure.

```bash
# Initialize the core Galera cluster
ansible-playbook -i inventory playbook-galera.yaml
```

### Phase III: Load Balancing Installation (Application Layer)
Once the database cluster is stable and operational, execute the second playbook to install the Active-Passive load balancing layer in front of the application.

```bash
# Deploy the load balancer and associated services
ansible-playbook -i inventory playbook.yaml
```

## 🧩 Component Configuration Details

### 🔑 WordPress Customization
The default variables for WordPress configuration are located in vars/main.yaml. If you need to override or adapt these settings (e.g., API keys, custom names), please use the values found in this file as a structural reference template.

### 💾 Database Configuration (MariaDB Galera)
The main.yaml playbook handles several core tasks:

- Dependency Installation: Installs all necessary packages for stable MariaDB cluster operation.
- Configuration File: Creates a secure configuration file (.my.cnf) defining database access parameters.
- Initialization: Creates the primary database and sets up initial users.

### 🗑️ Backup Management
A dedicated network share is mounted to store all backups (/mnt/backup). An automated cron job has been successfully configured on the source server to deposit regular database dumps, ensuring continuous data backup coverage.

### ⚠️ Critical Notes & Networking

#### 🔴 Keepalived Warning (Virtual IPs)
The Keepalived role, essential for managing Virtual IP addresses, is implemented within the roles but is currently commented out/disabled (#). Please ensure these sections are uncommented during final production deployment to activate reliable floating IPs.

#### 🌐 DNS / Hosts File Configuration
To guarantee correct and reliable resolution of your project domain name across all environments, please add the following entries to your local hosts file or designated DNS server:

```ìni
# Subdomain Entries for monblog.projet.local
192.168.20.100   monblog.projet.local
192.168.20.101   monblog.projet.local

# Other designated service hosts
192.168.20.12    monblog-admin.projet.local
192.168.20.13    monblog-staging.projet.local
```
