# 319. TCP Ports: The Key to Data Routing

## Why Do We Need Ports?

At Layer 3 (IP), packets can reach the correct computer.

Example:

```text
Your Laptop
IP: 192.168.1.100

Server
IP: 142.250.185.14
```

IP solves:

```text
Which machine should receive this packet?
```

But a machine can run many applications simultaneously:

```text
Chrome
Firefox
SSH Server
PostgreSQL
Spring Boot API
Docker Registry
```

Question:

> Which application should receive the packet?

IP cannot answer this.

TCP and UDP use **ports**.

---

# What Is a Port?

A port is simply:

```text
A logical communication endpoint
```

represented by a 16-bit number.

Range:

```text
0 - 65535
```

Because:

```text
2^16 = 65536
```

possible port numbers exist.

---

# Analogy: Apartment Building

Imagine:

```text
IP Address = Building Address

Port Number = Apartment Number
```

Example:

```text
Building:
192.168.1.100
```

contains:

```text
Apartment 22  → SSH
Apartment 80  → HTTP
Apartment 443 → HTTPS
Apartment 5432 → PostgreSQL
```

The packet reaches:

```text
192.168.1.100:5432
```

and Linux knows:

```text
Deliver this packet to PostgreSQL
```

---

# Port Categories

## 1. Well-Known Ports (0–1023)

Reserved for common Internet services.

Examples:

| Port  | Service |
| ----- | ------- |
| 20/21 | FTP     |
| 22    | SSH     |
| 25    | SMTP    |
| 53    | DNS     |
| 80    | HTTP    |
| 110   | POP3    |
| 143   | IMAP    |
| 443   | HTTPS   |

Examples:

```text
https://google.com
```

typically connects to:

```text
Port 443
```

---

## 2. Registered Ports (1024–49151)

Assigned by the organization:

Internet Assigned Numbers Authority

Examples:

| Port  | Application      |
| ----- | ---------------- |
| 3306  | MySQL            |
| 5432  | PostgreSQL       |
| 5900  | VNC              |
| 8080  | Alternative HTTP |
| 27017 | MongoDB          |

As a Spring Boot developer, you'll often use:

```text
8080
```

or

```text
8081
```

for local APIs.

---

## 3. Dynamic / Ephemeral Ports (49152–65535)

These are temporary client ports.

Used automatically by:

* browsers
* curl
* wget
* mobile apps
* Spring Boot clients

Example:

```text
Chrome → google.com
```

Linux may automatically choose:

```text
Source Port = 52741
```

for that connection.

---

# Source Port vs Destination Port

Every TCP packet contains:

```text
Source Port
Destination Port
```

Example:

```text
Laptop → Google HTTPS
```

Packet:

```text
Source IP:      192.168.1.100
Source Port:    52741

Destination IP: 142.250.185.14
Destination Port: 443
```

Meaning:

```text
My browser (52741)
wants to talk to
Google HTTPS service (443)
```

---

# Why Random Source Ports?

Suppose Chrome opens:

```text
google.com
youtube.com
github.com
chatgpt.com
```

simultaneously.

Linux might assign:

```text
52741
52742
52743
52744
```

Each connection gets its own temporary source port.

This allows thousands of simultaneous connections.

---

# The TCP Connection Identifier

A TCP connection is uniquely identified by:

```text
Source IP
Source Port
Destination IP
Destination Port
```

Example:

```text
192.168.1.100:52741
        ↓
142.250.185.14:443
```

This combination is called:

```text
Socket Pair (4-Tuple)
```

or

```text
TCP Connection Tuple
```

---

# Why Is This Important?

Suppose you open two browser tabs:

Tab 1:

```text
google.com
```

Tab 2:

```text
google.com
```

Connections:

```text
192.168.1.100:52741 → Google:443
192.168.1.100:52742 → Google:443
```

Same destination.

Different source ports.

Linux can distinguish them perfectly.

---

# How Linux Delivers Packets

When a packet arrives:

```text
Destination IP = Server
Destination Port = 5432
```

Kernel checks:

```text
Which process owns port 5432?
```

Result:

```text
PostgreSQL
```

Packet is delivered to PostgreSQL.

---

# Real Backend Examples

### Spring Boot

Default:

```properties
server.port=8080
```

Application listens on:

```text
0.0.0.0:8080
```

Requests arriving at:

```text
http://server:8080
```

go to your Spring Boot application.

---

### PostgreSQL

Default:

```text
5432
```

Connection:

```bash
psql -h localhost -p 5432
```

---

### SSH

Default:

```text
22
```

Connection:

```bash
ssh user@server
```

actually means:

```bash
ssh -p 22 user@server
```

---

# Wireshark Example

Your course suggests:

```bash
wget http://example.com
```

Capture packets.

Filter:

```text
tcp
```

Open any TCP packet.

You'll see:

```text
Transmission Control Protocol
```

Expand it.

Example:

```text
Source Port: 52741
Destination Port: 80
```

Interpretation:

```text
Browser/Client
      ↓
HTTP Server
```

---

# IP vs Port

Students often confuse these.

### IP Address

Identifies:

```text
Machine
```

Example:

```text
192.168.1.100
```

---

### Port Number

Identifies:

```text
Application
```

Example:

```text
5432
```

Together:

```text
192.168.1.100:5432
```

means:

```text
PostgreSQL running on this machine
```

---

# Useful Linux Commands

## Show Listening Ports

```bash
ss -tuln
```

Example:

```text
LISTEN 0 128 0.0.0.0:22
LISTEN 0 128 0.0.0.0:5432
LISTEN 0 128 0.0.0.0:8080
```

---

## Show Process Using Port

```bash
sudo ss -tulpn
```

Example:

```text
tcp LISTEN 0 128 0.0.0.0:5432 users:(("postgres",pid=1111))
```

---

## Find Specific Port

```bash
sudo ss -tulpn | grep 8080
```

Useful when debugging Spring Boot deployments.

---

# Interview Questions

### Q1: What is a TCP port?

**Answer:** A logical endpoint used by TCP/UDP to identify the application that should receive network traffic.

---

### Q2: What is the range of TCP ports?

**Answer:** 0–65535.

---

### Q3: What is the default SSH port?

**Answer:** 22.

---

### Q4: What is the default HTTPS port?

**Answer:** 443.

---

### Q5: What is the default PostgreSQL port?

**Answer:** 5432.

---

### Q6: What uniquely identifies a TCP connection?

**Answer:**

```text
Source IP
Source Port
Destination IP
Destination Port
```

(the TCP 4-tuple).

---

# Linux Administrator Insight

When debugging servers, one of the first checks is:

```bash
ss -tulpn
```

Questions you often ask:

* Is the application listening?
* Which port is it using?
* Is another service already using that port?
* Is the firewall blocking that port?

As a Spring Boot and PostgreSQL developer, ports **22, 80, 443, 5432, 8080, and 8081** will become some of the most important port numbers you work with regularly.
