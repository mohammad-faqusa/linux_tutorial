# 322. Port Scanning with Nmap

## What is a Port Scanner?

A port scanner is a tool that checks:

> Which TCP or UDP ports on a machine are accepting connections?

Example:

A server may have:

```text
22    SSH
80    HTTP
443   HTTPS
5432  PostgreSQL
```

A port scanner probes those ports and determines:

```text
Open
Closed
Filtered
```

---

# Why Is This Useful?

Suppose you deploy a Spring Boot application:

```text
Server: 192.168.1.50
Port: 8080
```

You try:

```bash
curl http://192.168.1.50:8080
```

and it fails.

Questions:

* Is Spring Boot running?
* Is port 8080 listening?
* Is the firewall blocking it?
* Did I configure the wrong port?

Nmap helps answer these questions.

---

# How Does Nmap Work?

Basic idea:

Nmap attempts to communicate with ports.

Example:

```text
Target: 192.168.1.100
```

Try:

```text
22
23
25
80
443
5432
...
```

If a service responds:

```text
Port = Open
```

If no service exists:

```text
Port = Closed
```

If a firewall blocks the traffic:

```text
Port = Filtered
```

---

# Legal and Ethical Considerations

Your course correctly mentions this.

Port scanning is used by:

### Security professionals

* penetration testers
* security auditors
* administrators
* DevOps engineers

to identify exposed services.

### Attackers

also use port scanning to discover targets.

Therefore:

✅ Scan systems you own

✅ Scan systems you have permission to test

❌ Do not scan random public systems without authorization

---

# Installing Nmap

## Ubuntu / Debian

```bash
sudo apt install nmap
```

---

## Rocky Linux / RHEL / Fedora

```bash
sudo dnf install nmap
```

---

## Verify Installation

```bash
nmap --version
```

Example:

```text
Nmap version 7.95
```

---

# Basic Host Scan

Scan a host:

```bash
nmap 192.168.1.10
```

or

```bash
nmap localhost
```

Example output:

```text
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
5432/tcp open  postgresql
```

Meaning:

* SSH available
* Web server available
* PostgreSQL available

---

# Scanning a Specific Port

Example:

```bash
nmap -p 22 localhost
```

Output:

```text
22/tcp open ssh
```

Only port 22 was tested.

---

# Scan Multiple Ports

```bash
nmap -p 22,80,443 localhost
```

Example:

```text
22/tcp open ssh
80/tcp closed http
443/tcp closed https
```

---

# Scan a Range of Ports

Example:

```bash
nmap -p 1-100 localhost
```

Tests:

```text
1
2
3
...
100
```

---

# Scan All TCP Ports

Your notes show:

```bash
nmap -p- localhost
```

Notice there is **no space** after `-p`.

Correct:

```bash
nmap -p- localhost
```

This scans:

```text
1 → 65535
```

all TCP ports.

This can take some time.

---

# Scan Multiple Hosts

Example:

```bash
nmap 192.168.1.1-100
```

Scans:

```text
192.168.1.1
192.168.1.2
192.168.1.3
...
192.168.1.100
```

Useful for discovering devices on a LAN.

---

# Understanding Nmap States

## Open

Example:

```text
22/tcp open ssh
```

Meaning:

```text
Service listening
Connection accepted
```

---

## Closed

Example:

```text
80/tcp closed http
```

Meaning:

```text
Host reachable
No application listening
```

---

## Filtered

Example:

```text
443/tcp filtered https
```

Meaning:

```text
Firewall blocked the probe
```

Nmap cannot determine if a service exists.

---

# Practical Example: PostgreSQL

Suppose PostgreSQL is running:

```bash
sudo systemctl status postgresql
```

Listening:

```text
5432/tcp
```

Nmap:

```bash
nmap -p 5432 localhost
```

Output:

```text
5432/tcp open postgresql
```

---

Now stop PostgreSQL:

```bash
sudo systemctl stop postgresql
```

Run again:

```bash
nmap -p 5432 localhost
```

Output:

```text
5432/tcp closed postgresql
```

Exactly what your course demonstrates.

---

# Compare with Linux Tools

## What ports are listening?

```bash
ss -tulpn
```

Example:

```text
tcp LISTEN 0 128 0.0.0.0:22
tcp LISTEN 0 128 0.0.0.0:5432
```

Shows local listening ports.

---

## What does Nmap show?

```bash
nmap localhost
```

Shows what an external machine could potentially reach.

This distinction is important.

---

# Service Detection

Nmap can identify services:

```bash
nmap -sV localhost
```

Example:

```text
22/tcp open ssh OpenSSH 9.6
5432/tcp open PostgreSQL 16
```

Very useful during troubleshooting.

---

# Typical Ports You'll Encounter

Since you work with Spring Boot and PostgreSQL:

| Port  | Service     |
| ----- | ----------- |
| 22    | SSH         |
| 80    | HTTP        |
| 443   | HTTPS       |
| 5432  | PostgreSQL  |
| 3306  | MySQL       |
| 8080  | Spring Boot |
| 27017 | MongoDB     |

Example:

```bash
nmap -p 22,80,443,5432,8080 localhost
```

---

# Practical Exercises

### Exercise 1

Check your machine:

```bash
nmap localhost
```

Compare with:

```bash
ss -tulpn
```

---

### Exercise 2

Check only SSH:

```bash
nmap -p 22 localhost
```

---

### Exercise 3

If PostgreSQL is installed:

```bash
nmap -p 5432 localhost
```

Then stop PostgreSQL:

```bash
sudo systemctl stop postgresql
```

Scan again and observe the difference.

---

# Interview Questions

### Q1: What is Nmap?

**Answer:** An open-source network discovery and security auditing tool used to detect hosts, open ports, and services.

---

### Q2: What does an open port mean?

**Answer:** A service is listening and accepting connections on that port.

---

### Q3: What does a closed port mean?

**Answer:** The host is reachable, but no application is listening on that port.

---

### Q4: What does a filtered port mean?

**Answer:** A firewall or filtering device is blocking the probe.

---

### Q5: How do you scan all TCP ports?

**Answer:**

```bash
nmap -p- <host>
```

---

### Linux Administrator Insight

When deploying your Spring Boot applications on Linux, one of the first troubleshooting commands is often:

```bash
ss -tulpn
```

followed by:

```bash
nmap localhost
```

If Spring Boot should be listening on:

```text
8080
```

but Nmap does not show:

```text
8080/tcp open
```

then either:

* the application isn't running,
* it's listening on a different port,
* or a firewall/network rule is blocking access.

This is exactly the type of troubleshooting commonly encountered in DevOps, SRE, and backend engineering roles.
