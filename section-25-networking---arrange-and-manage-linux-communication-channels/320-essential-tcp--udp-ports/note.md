# 320. Essential TCP & UDP Ports

## Why Are Ports Important?

Recall from the previous lecture:

```text
IP Address → identifies the machine
Port Number → identifies the application
```

Example:

```text
142.250.185.14:443
```

means:

```text
Google server
HTTPS application
```

When a packet arrives:

```text
Destination IP = Server
Destination Port = 443
```

Linux knows:

```text
Deliver this packet to the HTTPS service
```

---

# Most Common TCP Ports

TCP is used when:

* reliability matters
* data must arrive correctly
* packet ordering is important

Examples:

* websites
* SSH
* databases
* email

---

## Port 80 — HTTP

### Protocol

```text
HTTP
HyperText Transfer Protocol
```

### Purpose

Web communication without encryption.

Example:

```text
http://example.com
```

Browser usually connects to:

```text
example.com:80
```

---

## Port 443 — HTTPS

### Protocol

```text
HTTPS
HTTP Secure
```

### Purpose

Encrypted web communication using TLS/SSL.

Example:

```text
https://google.com
```

Actually means:

```text
google.com:443
```

---

### Interesting Experiment

Try:

```text
https://google.com:80
```

or

```text
https://example.com:80
```

Usually:

* connection fails
* TLS handshake fails
* server refuses the connection

Why?

Because:

```text
HTTPS expects TLS
Port 80 usually expects plain HTTP
```

The protocols do not match.

---

## Port 21 — FTP Control

### Protocol

```text
FTP
File Transfer Protocol
```

Used for:

```text
Uploading files
Downloading files
Managing files
```

---

## Port 20 — FTP Data

FTP traditionally uses:

```text
21 → commands
20 → file data
```

---

## Port 22 — SSH

### Protocol

```text
SSH
Secure Shell
```

Used for:

* remote Linux administration
* secure command execution
* SCP
* SFTP
* Git over SSH

Example:

```bash
ssh user@server
```

Actually connects to:

```text
server:22
```

This is one of the most important ports for Linux engineers.

---

## Port 23 — Telnet

### Protocol

```text
Telnet
```

Used historically for remote terminals.

Problem:

```text
No encryption
```

Passwords travel in plain text.

Nowadays:

```text
SSH replaces Telnet
```

almost everywhere.

---

## Port 25 — SMTP

### Protocol

```text
Simple Mail Transfer Protocol
```

Used for:

```text
Sending emails
```

Mail servers communicate using SMTP.

Example:

```text
Gmail Server
↓
Outlook Server
```

SMTP transfers the email.

---

## Port 110 — POP3

### Protocol

```text
Post Office Protocol v3
```

Purpose:

Download emails from server.

Traditional behavior:

```text
Download email
Remove from server
```

Used less frequently today.

---

## Port 143 — IMAP

### Protocol

```text
Internet Message Access Protocol
```

Purpose:

Access email while keeping messages on the server.

Benefits:

* synchronize multiple devices
* folders remain consistent
* emails stay stored centrally

Modern email clients mostly use IMAP.

---

# Most Common UDP Ports

UDP is used when:

```text
Speed > Reliability
```

No retransmissions.

No acknowledgments.

No guaranteed delivery.

---

## Port 53 — DNS

### Protocol

```text
Domain Name System
```

Purpose:

Convert:

```text
google.com
```

into:

```text
142.250.x.x
```

Most DNS queries use UDP because:

* requests are small
* responses are small
* speed matters

---

## Ports 67 & 68 — DHCP

### Protocol

```text
Dynamic Host Configuration Protocol
```

Purpose:

Automatically assign:

* IP address
* gateway
* subnet mask
* DNS server

---

Typical communication:

```text
Client → UDP 68
Server → UDP 67
```

---

## Port 69 — TFTP

### Protocol

```text
Trivial File Transfer Protocol
```

Lightweight file transfer.

Common uses:

* routers
* switches
* embedded systems
* PXE network booting

Unlike FTP:

```text
No authentication
No encryption
Very simple
```

---

## Port 123 — NTP

### Protocol

```text
Network Time Protocol
```

Purpose:

Synchronize system clocks.

Example:

```bash
timedatectl
```

Your machine may contact:

```text
pool.ntp.org
```

over UDP 123.

---

Why is this important?

Correct time is required for:

* TLS certificates
* logs
* authentication systems
* distributed applications

---

## Ports 161 & 162 — SNMP

### Protocol

```text
Simple Network Management Protocol
```

Used by:

* routers
* switches
* firewalls
* monitoring systems

Examples:

* bandwidth monitoring
* CPU usage monitoring
* interface statistics

---

### Port Usage

```text
161 → queries
162 → traps/notifications
```

---

## Ports 5004 / 5005 — RTP

### Protocol

```text
Real-time Transport Protocol
```

Used for:

* voice calls
* video calls
* conferencing
* streaming

Examples:

* VoIP
* video meetings
* multimedia systems

Usually built on top of UDP.

---

# Linux Commands to Observe Ports

## Show Listening Ports

```bash
ss -tuln
```

Example:

```text
tcp LISTEN 0 128 0.0.0.0:22
tcp LISTEN 0 128 0.0.0.0:5432
udp UNCONN 0 0 0.0.0.0:123
```

---

## Show Processes

```bash
sudo ss -tulpn
```

Example:

```text
tcp LISTEN 0 128 0.0.0.0:22
users:(("sshd",pid=123))
```

---

## Check Open SSH Port

```bash
sudo ss -tulpn | grep :22
```

---

# Ports You Should Memorize

For Linux, DevOps, Spring Boot, and interviews:

| Port  | Protocol         | Purpose               |
| ----- | ---------------- | --------------------- |
| 22    | SSH              | Remote administration |
| 53    | DNS              | Name resolution       |
| 67/68 | DHCP             | IP assignment         |
| 80    | HTTP             | Websites              |
| 123   | NTP              | Time synchronization  |
| 143   | IMAP             | Email access          |
| 443   | HTTPS            | Secure websites       |
| 5432  | PostgreSQL       | Database              |
| 3306  | MySQL            | Database              |
| 8080  | HTTP alternative | Spring Boot           |
| 27017 | MongoDB          | Database              |

---

# Interview Questions

### Q1: Which port does HTTPS use?

**Answer:** 443.

---

### Q2: Which port does SSH use?

**Answer:** 22.

---

### Q3: Which protocol typically uses port 53?

**Answer:** DNS.

---

### Q4: Which ports are used by DHCP?

**Answer:** UDP 67 and UDP 68.

---

### Q5: Which port does PostgreSQL use by default?

**Answer:** 5432.

---

### Q6: Which port does Spring Boot commonly use during development?

**Answer:** 8080.

---

### Linux Administrator Insight

For someone following your path (Linux → Docker → Deployments → Spring Boot → Full Stack), the ports you will encounter almost daily are:

```text
22     SSH
80     HTTP
443    HTTPS
5432   PostgreSQL
8080   Spring Boot
3306   MySQL
53     DNS
```

If you can immediately recognize these ports in logs, firewall rules, Docker mappings, `ss -tulpn` output, and Wireshark captures, you'll already be ahead of many junior developers and system administrators.
