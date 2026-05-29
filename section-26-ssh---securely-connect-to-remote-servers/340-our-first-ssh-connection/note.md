## 340. Our First SSH Connection

# Installing an SSH Server

## Why Do We Need an SSH Server?

SSH communication requires two components:

* SSH Client
* SSH Server

The SSH server must be installed on the computer we want to control remotely.

Without an SSH server:

```text
Client ──X──► Server
```

No SSH connection can be established.

---

# Installing OpenSSH Server

## Ubuntu / Debian

```bash
sudo apt update
sudo apt install openssh-server
```

---

## CentOS / Rocky Linux / RHEL

```bash
sudo dnf install openssh-server
```

---

# Verify Installation

After installation, check the service status:

```bash
systemctl status ssh
```

or on some distributions:

```bash
systemctl status sshd
```

---

## Expected Result

```text
active (running)
```

This means the SSH server is running and accepting connections.

---

# Verify SSH Is Listening

SSH typically listens on:

```text
TCP Port 22
```

Check using:

```bash
ss -tulpn | grep ssh
```

Example output:

```text
LISTEN 0 128 *:22
```

This indicates that the SSH server is listening for incoming connections.

---

# Creating an SSH Connection

## General Syntax

```bash
ssh username@server
```

Where:

* `ssh` → SSH client program
* `username` → user account on the remote machine
* `server` → hostname or IP address of the remote machine

---

# Connection Examples

## Connect to the Local Machine

```bash
ssh jack@localhost
```

### Explanation

```text
localhost
↓
127.0.0.1
↓
Current Machine
```

This is useful for testing SSH locally.

---

## Connect Using an IP Address

```bash
ssh jack@192.168.1.15
```

### Explanation

The SSH client connects directly to the machine with IP:

```text
192.168.1.15
```

This is the most common method in local networks.

---

## Connect Using mDNS

```bash
ssh jack@ubuntu1.local
```

### Explanation

If mDNS (Avahi/Bonjour) is configured correctly:

```text
ubuntu1.local
↓
192.168.1.15
```

The hostname is automatically resolved to an IP address.

---

## Connect Using a Domain Name

```bash
ssh jack@example.com
```

### Explanation

DNS resolves:

```text
example.com
↓
Public IP Address
```

The SSH client then connects to the remote server.

This is common when connecting to:

* Cloud servers
* VPS instances
* Production environments

---

# Example SSH Session

## Command

```bash
ssh mohammad@192.168.1.15
```

---

## Password Prompt

```text
mohammad@192.168.1.15's password:
```

Enter the user's password.

---

## Successful Login

```text
Welcome to Ubuntu

mohammad@ubuntu:~$
```

You are now controlling the remote machine.

---

# First Connection Warning

When connecting to a server for the first time, you may see:

```text
The authenticity of host '192.168.1.15' can't be established.
ED25519 key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxxxxxx

Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

---

# Why Does This Warning Appear?

SSH uses cryptographic keys to identify servers.

The client has never seen this server before, so it cannot verify its identity.

SSH therefore asks:

```text
"Do you trust this server?"
```

---

# What Should We Do?

For a server that you expect to connect to:

```text
yes
```

Type:

```text
yes
```

and press Enter.

---

# What Happens Next?

SSH stores the server's fingerprint in:

```bash
~/.ssh/known_hosts
```

This file contains trusted server identities.

---

# Future Connections

On future connections:

```bash
ssh mohammad@192.168.1.15
```

SSH verifies:

* Stored fingerprint
* Current server fingerprint

If they match:

```text
Connection proceeds normally.
```

---

# Security Benefit

This mechanism helps protect against:

* Man-in-the-middle attacks
* Server impersonation
* Fake SSH servers

---

# Warning About Changed Fingerprints

Sometimes SSH may display:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```

Possible reasons:

### Legitimate Reasons

* Server reinstallation
* SSH server reconfiguration
* New virtual machine

### Potential Security Issue

* Someone may be impersonating the server.

Never ignore this warning without understanding why it occurred.

---

# Testing SSH in Your Lab

## Example Setup

### VM1

```text
Hostname: ubuntu1
IP: 10.0.2.4
```

### VM2

```text
Hostname: ubuntu2
IP: 10.0.2.5
```

---

## Install OpenSSH Server on VM1

```bash
sudo apt install openssh-server
```

---

## Connect from VM2

```bash
ssh mohammad@10.0.2.4
```

or:

```bash
ssh mohammad@ubuntu1.local
```

---

# Useful Commands

## Check Service Status

```bash
systemctl status ssh
```

---

## Check Listening Ports

```bash
ss -tulpn | grep :22
```

---

## Check SSH Version

```bash
ssh -V
```

---

# Real-World Usage

SSH is used daily to connect to:

* Linux servers
* Cloud instances (AWS, Azure, GCP)
* Docker hosts
* Kubernetes nodes
* Raspberry Pi devices
* Network appliances

Example:

```bash
ssh ubuntu@ec2-public-ip
```

This is exactly how administrators manage remote Linux servers in production.

---

# Important Takeaway

To establish an SSH connection:

1. Install an SSH server on the target machine.
2. Ensure the SSH service is running.
3. Connect using:

```bash
ssh username@server
```

4. Accept the fingerprint warning on the first connection.
5. Authenticate using a password or SSH key.

Once connected, you can securely control the remote machine through the terminal as if you were physically sitting in front of it.
