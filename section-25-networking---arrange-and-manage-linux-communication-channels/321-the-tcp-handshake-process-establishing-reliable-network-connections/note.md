# 321. The TCP Handshake Process

## Why Do We Need a Handshake?

Before two computers exchange data, they must verify:

### 1. The other side is reachable

Example:

```text
Client → Server
```

The client must know:

> "Is the server alive?"

The server must know:

> "Is the client reachable?"

---

### 2. Initial Sequence Numbers

TCP tracks every byte sent.

To do this, both sides maintain:

```text
Sequence Numbers
```

These allow TCP to:

* detect lost packets
* detect duplicate packets
* reorder packets
* acknowledge received data

Before communication starts, both sides exchange their starting sequence numbers.

---

# The Three-Way Handshake

The process consists of:

```text
1. SYN
2. SYN-ACK
3. ACK
```

After that:

```text
TCP connection established
```

---

# Step 1 — SYN

Client sends:

```text
SYN
Sequence Number = 1000
```

Meaning:

> "I want to establish a TCP connection."

> "My starting sequence number is 1000."

---

Visual:

```text
Client                          Server

SYN
Seq=1000
------------------------------>
```

---

# Step 2 — SYN-ACK

Server receives SYN.

Server responds:

```text
SYN + ACK
Sequence Number = 5000
Acknowledgment = 1001
```

Meaning:

> "I received your sequence number 1000."

> "I expect your next byte to be 1001."

> "My starting sequence number is 5000."

---

Visual:

```text
Client                          Server

SYN
Seq=1000
------------------------------>

                SYN-ACK
                Seq=5000
                Ack=1001
<------------------------------
```

---

# Why ACK = 1001?

The SYN flag consumes one sequence number.

Client started with:

```text
1000
```

Server acknowledges:

```text
1001
```

Meaning:

```text
I successfully received your SYN
```

---

# Step 3 — ACK

Client now acknowledges the server's sequence number.

Client sends:

```text
ACK
Sequence Number = 1001
Acknowledgment = 5001
```

Meaning:

> "I received your sequence number 5000."

> "I expect your next byte to be 5001."

---

Visual:

```text
Client                          Server

SYN
Seq=1000
------------------------------>

                SYN-ACK
                Seq=5000
                Ack=1001
<------------------------------

ACK
Seq=1001
Ack=5001
------------------------------>
```

---

# Connection Established

After the third packet:

```text
TCP State = ESTABLISHED
```

Both sides know:

✅ The other side is reachable

✅ Initial sequence numbers

✅ Both directions work

Now data transfer can begin.

---

# What Happens Next?

Normal TCP traffic starts:

```text
HTTP Request
HTTPS Request
SSH Session
Database Query
File Transfer
```

Example:

```text
GET /index.html HTTP/1.1
```

or:

```text
SELECT * FROM users;
```

TCP now manages:

* reliability
* retransmissions
* ordering
* acknowledgments

---

# Why Not Just Two Packets?

Students often ask:

> Why not SYN → SYN-ACK and stop?

Because the server still doesn't know whether the client received the SYN-ACK.

The third ACK confirms:

```text
Client received server response
```

Only then is the connection fully established.

---

# Sequence Numbers

Every TCP connection uses sequence numbers.

Example:

```text
Seq = 1001
```

Think of it as:

```text
Byte Counter
```

TCP counts bytes, not packets.

Example:

```text
Packet contains 500 bytes
```

Current sequence:

```text
1001
```

Next packet starts at:

```text
1501
```

because:

```text
1001 + 500
```

---

# Acknowledgments

Suppose receiver successfully gets bytes:

```text
1001 → 1500
```

Receiver replies:

```text
ACK = 1501
```

Meaning:

```text
Everything up to 1500 arrived successfully.
Send me byte 1501 next.
```

---

# What If a Packet Is Lost?

Example:

```text
Packet 1 ✓
Packet 2 ✗
Packet 3 ✓
```

Receiver notices missing data.

It keeps acknowledging:

```text
ACK = expected byte
```

Sender eventually retransmits the missing packet.

This is how TCP achieves reliability.

---

# Wireshark Practice

Your course suggests:

```bash
wget https://google.com
```

while Wireshark is capturing.

Then filter:

```text
tcp
```

or:

```text
tcp.port == 443
```

for HTTPS traffic.

---

# First Packet

Open the first packet.

You'll see:

```text
Transmission Control Protocol
```

Expanded fields:

```text
Source Port: 53214
Destination Port: 443
Sequence Number: 0
Flags: SYN
```

Important:

```text
SYN = Set
```

Meaning:

```text
Connection request
```

---

# Second Packet

Server response:

```text
Source Port: 443
Destination Port: 53214
Flags: SYN, ACK
```

Meaning:

```text
Connection accepted
```

---

# Third Packet

Client response:

```text
Flags: ACK
```

Meaning:

```text
Handshake completed
```

---

# Common TCP Flags

| Flag | Meaning                          |
| ---- | -------------------------------- |
| SYN  | Start connection                 |
| ACK  | Acknowledge received data        |
| FIN  | Gracefully close connection      |
| RST  | Immediately terminate connection |
| PSH  | Deliver data immediately         |
| URG  | Urgent data                      |

For the handshake:

```text
SYN
SYN-ACK
ACK
```

are the important ones.

---

# TCP States

During the handshake:

```text
CLOSED
   ↓
SYN_SENT
   ↓
SYN_RECEIVED
   ↓
ESTABLISHED
```

You can observe active TCP connections using:

```bash
ss -tan
```

Example:

```text
ESTAB
192.168.1.100:53321
142.250.185.14:443
```

Meaning:

```text
TCP connection established
```

---

# Real-World Examples

### Opening a Website

```text
Browser
   ↓
TCP Handshake
   ↓
TLS Handshake
   ↓
HTTP Request
```

---

### SSH Login

```bash
ssh user@server
```

Process:

```text
TCP Handshake
SSH Authentication
Interactive Shell
```

---

### PostgreSQL Connection

```bash
psql -h server
```

Process:

```text
TCP Handshake
Database Authentication
SQL Queries
```

---

# Interview Questions

### Q1: What is the TCP Three-Way Handshake?

**Answer:** The process used to establish a TCP connection:

```text
SYN
SYN-ACK
ACK
```

---

### Q2: Why is the handshake needed?

**Answer:** To verify connectivity in both directions and exchange initial sequence numbers.

---

### Q3: Which TCP flag starts a connection?

**Answer:** SYN.

---

### Q4: What does ACK mean?

**Answer:** Acknowledgment of received data.

---

### Q5: What TCP state indicates a successful connection?

**Answer:** ESTABLISHED.

---

# Linux Administrator Insight

When troubleshooting network services (SSH, Nginx, Spring Boot, PostgreSQL), one of the first things to verify is:

```bash
sudo tcpdump -i any tcp
```

or Wireshark.

If you see:

```text
SYN
SYN-ACK
ACK
```

the TCP connection is healthy.

If you only see:

```text
SYN
SYN
SYN
SYN
```

the remote side is not responding (firewall, server down, routing issue, etc.).

Understanding the TCP three-way handshake is fundamental because nearly every reliable network application you use—Spring Boot APIs, PostgreSQL, SSH, Git, Docker registries, HTTPS websites—depends on it.
