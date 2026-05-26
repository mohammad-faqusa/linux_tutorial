# 323. Scan Types in Nmap

Nmap supports many scan techniques, but the three most important are:

```text
-sS  TCP SYN Scan
-sT  TCP Connect Scan
-sU  UDP Scan
```

---

# 1. TCP SYN Scan (`-sS`)

Often called:

```text
Half-Open Scan
Stealth Scan
```

This is Nmap's preferred scan type when it has sufficient privileges (typically root/sudo on Linux).

Example:

```bash
sudo nmap -sS localhost
```

---

## How It Works

Suppose Nmap wants to test:

```text
Port 22
```

Nmap sends:

```text
SYN
```

just like the first step of a normal TCP handshake.

---

### If Port Is Open

Target responds:

```text
SYN-ACK
```

Nmap immediately knows:

```text
Port is OPEN
```

Instead of completing the handshake:

```text
SYN
SYN-ACK
ACK
```

Nmap sends:

```text
RST
```

to terminate the attempt.

---

### Packet Flow

```text
Nmap                     Server

SYN
----------------------->

               SYN-ACK
<-----------------------

RST
----------------------->
```

Connection never becomes established.

---

## Why Is It Fast?

Because:

* No complete connection setup
* Nmap crafts packets directly
* Less operating system overhead

Therefore:

```text
Fast
Efficient
Most commonly used
```

---

## Detecting Port States

### Open Port

Response:

```text
SYN-ACK
```

Result:

```text
OPEN
```

---

### Closed Port

Response:

```text
RST
```

Result:

```text
CLOSED
```

---

### Filtered Port

Response:

```text
No response
```

or firewall blocks packets.

Result:

```text
FILTERED
```

---

# Example

SSH running:

```bash
sudo nmap -sS localhost -p 22
```

Output:

```text
22/tcp open ssh
```

because SSH responds:

```text
SYN-ACK
```

---

# Why Is It Called Half-Open?

Because only half the handshake occurs:

```text
SYN
SYN-ACK
```

The final:

```text
ACK
```

never happens.

---

# 2. TCP Connect Scan (`-sT`)

Example:

```bash
nmap -sT localhost
```

Used when SYN scan isn't possible.

Examples:

* normal user privileges
* some IPv6 situations
* operating system limitations

---

## How It Works

Nmap asks the operating system:

> "Please connect to this port."

The OS performs a normal TCP connection.

---

### Open Port

Full handshake occurs:

```text
SYN
SYN-ACK
ACK
```

Connection established.

Then Nmap closes it immediately.

---

### Packet Flow

```text
Nmap                     Server

SYN
----------------------->

               SYN-ACK
<-----------------------

ACK
----------------------->

Connection Established

RST or FIN
----------------------->
```

---

# Why Is It Slower?

Because:

```text
Complete TCP handshake
Connection setup
Connection teardown
```

must happen for every tested port.

More work.

More packets.

More waiting.

---

# Why Can It Appear in Logs?

Since the connection is fully established:

The remote service may record:

```text
Connection accepted
```

Example:

SSH logs:

```text
Connection from 192.168.1.100
```

Web server logs:

```text
Client connected
```

Database logs:

```text
New connection established
```

This makes `-sT` easier to detect.

---

# SYN Scan vs Connect Scan

## SYN Scan

```text
SYN
SYN-ACK
RST
```

Connection never established.

---

## Connect Scan

```text
SYN
SYN-ACK
ACK
```

Connection established.

Then closed.

---

# Comparison

| Feature                          | SYN Scan (`-sS`) | Connect Scan (`-sT`) |
| -------------------------------- | ---------------- | -------------------- |
| Needs elevated privileges        | Usually yes      | No                   |
| Faster                           | ✅                | ❌                    |
| Completes handshake              | ❌                | ✅                    |
| More visible in logs             | ❌                | ✅                    |
| Default when sudo/root available | ✅                | ❌                    |

---

# 3. UDP Scan (`-sU`)

Example:

```bash
sudo nmap -sU localhost
```

Used to discover UDP services such as:

```text
53 DNS
67 DHCP
68 DHCP
123 NTP
161 SNMP
```

---

# Why Is UDP Different?

Recall:

TCP:

```text
SYN
SYN-ACK
ACK
```

Easy to identify open ports.

UDP:

```text
No handshake
```

Much harder.

---

# Open UDP Port

Nmap sends a UDP packet.

Example:

```text
DNS Query
```

Target replies:

```text
DNS Response
```

Nmap concludes:

```text
OPEN
```

---

# Closed UDP Port

Nmap sends UDP packet.

Target responds:

```text
ICMP Port Unreachable
```

Nmap concludes:

```text
CLOSED
```

---

# No Response

Nmap sends:

```text
UDP packet
```

Nothing comes back.

Possibilities:

```text
Open port ignored packet
Firewall dropped packet
Packet lost
```

Nmap cannot know.

Result:

```text
open|filtered
```

---

# Why Is UDP Scanning Slow?

Unlike TCP:

```text
No handshake
No reliable replies
No acknowledgments
```

Nmap often must:

* retry packets
* wait for timeouts
* send multiple probes

Therefore:

```text
UDP scans are MUCH slower
```

than TCP scans.

---

# Example UDP Scan

```bash
sudo nmap -sU localhost
```

Output:

```text
53/udp   open          domain
123/udp  open          ntp
161/udp  open|filtered snmp
```

---

# Practical Wireshark Exercise

Run:

```bash
sudo nmap -sS localhost
```

Capture packets.

Filter:

```text
tcp
```

Observe:

```text
SYN
SYN-ACK
RST
```

No complete handshake.

---

Now run:

```bash
nmap -sT localhost
```

Observe:

```text
SYN
SYN-ACK
ACK
```

followed by:

```text
FIN
```

or

```text
RST
```

Connection was fully established.

---

# Common Interview Questions

### Q1: What is a SYN Scan?

**Answer:**

A TCP scan that sends a SYN packet and determines port status without completing the TCP handshake.

---

### Q2: What response indicates an open port during a SYN scan?

**Answer:**

```text
SYN-ACK
```

---

### Q3: What response indicates a closed port?

**Answer:**

```text
RST
```

---

### Q4: Why is a SYN scan faster than a Connect scan?

**Answer:**

Because it does not establish a full TCP connection.

---

### Q5: Why are UDP scans slower?

**Answer:**

Because UDP has no handshake or guaranteed response, so Nmap must wait for timeouts and retry packets.

---

# Linux Administrator Insight

In real environments:

```bash
sudo nmap -sS localhost
```

is commonly used to verify:

* SSH exposure (22)
* HTTP/HTTPS exposure (80/443)
* PostgreSQL exposure (5432)
* Spring Boot exposure (8080)

Meanwhile:

```bash
sudo ss -tulpn
```

shows what Linux believes is listening.

Comparing both outputs is an excellent way to diagnose:

* firewall problems
* accidental public exposure
* Docker networking issues
* service binding mistakes (`127.0.0.1` vs `0.0.0.0`)
