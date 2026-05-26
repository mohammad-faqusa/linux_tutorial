# 318. OSI Layer 4: The Transport Layer (TCP & UDP)

## Why Do We Need Layer 4?

At Layer 3 (IP):

* Packets can be lost
* Packets can arrive out of order
* Packets can be duplicated
* Routers may drop packets when overloaded
* No guarantee that data reaches the destination

IP only tries its best to deliver packets:

```text
Best Effort Delivery
```

It does **not** guarantee success.

Example:

```text
Packet 1 → arrives
Packet 2 → lost
Packet 3 → arrives
```

IP considers its job done.

The application must decide what to do.

This is where the **Transport Layer** comes in.

---

# Two Main Solutions

Layer 4 mainly provides two protocols:

## UDP

User Datagram Protocol

## TCP

Transmission Control Protocol

---

# UDP (User Datagram Protocol)

UDP is:

```text
Connectionless
Fast
Lightweight
No guarantees
```

UDP simply sends data.

Example:

```text
Sender
  ↓
Packet 1
Packet 2
Packet 3
```

If Packet 2 disappears:

```text
Packet 1 ✓
Packet 2 ✗
Packet 3 ✓
```

UDP does nothing.

No retransmission.

No ordering.

No acknowledgment.

---

## Why Would Anyone Use UDP?

Because sometimes speed matters more than reliability.

Imagine a video call:

```text
You: Hello
```

One packet gets lost.

Would you prefer:

### Option A

Continue immediately.

Small glitch.

### Option B

Wait several seconds for retransmission.

Conversation freezes.

Most people prefer Option A.

Therefore:

```text
Video Calls
VoIP
Online Gaming
Live Streaming
DNS
DHCP
```

often use UDP.

---

# TCP (Transmission Control Protocol)

TCP is:

```text
Connection-Oriented
Reliable
Ordered
Error-Checked
```

It provides a reliable stream of data.

Applications can think:

```text
I am reading a file
```

instead of:

```text
I am receiving thousands of network packets
```

TCP hides the complexity.

---

# What TCP Solves

Suppose packets are sent:

```text
1
2
3
4
5
```

Network delivers:

```text
1
3
5
2
4
```

TCP reorders them:

```text
1
2
3
4
5
```

before giving them to the application.

---

# Retransmission

Suppose:

```text
1 ✓
2 ✗
3 ✓
```

Packet 2 is lost.

TCP detects the loss and retransmits:

```text
Resend Packet 2
```

The receiver eventually gets:

```text
1
2
3
```

in the correct order.

---

# Acknowledgments (ACK)

TCP uses acknowledgments.

Example:

Sender:

```text
Packet #1
```

Receiver:

```text
ACK #1
```

meaning:

```text
I successfully received packet #1
```

If ACK never arrives:

TCP assumes loss and retransmits.

---

# TCP Provides a Data Stream

Applications see:

```text
Hello World
```

not:

```text
Packet A
Packet B
Packet C
```

TCP assembles packets into one continuous stream.

This makes programming much easier.

For example:

* HTTP
* HTTPS
* SSH
* FTP
* Git
* Database connections

all commonly use TCP.

---

# Flow Control

Your course mentions:

```text
Flow Control
```

Question:

What if the sender is faster than the receiver?

Example:

```text
Sender: 1 Gbps
Receiver: 10 Mbps
```

Without control:

```text
Receiver buffer fills up
```

Data gets lost.

TCP prevents this.

Receiver tells sender:

```text
Slow down
```

or

```text
You may send more
```

using the TCP Window mechanism.

---

# Congestion Control

Flow control protects:

```text
Receiver
```

Congestion control protects:

```text
Network
```

Example:

A router becomes overloaded.

Without congestion control:

```text
More packets
More packets
More packets
```

Network collapses.

TCP detects congestion and reduces its sending rate.

Then gradually increases it again.

This is why TCP behaves politely on the Internet.

---

# TCP vs UDP

| Feature            | TCP | UDP |
| ------------------ | --- | --- |
| Reliable delivery  | ✅   | ❌   |
| Packet ordering    | ✅   | ❌   |
| Retransmission     | ✅   | ❌   |
| Acknowledgments    | ✅   | ❌   |
| Flow control       | ✅   | ❌   |
| Congestion control | ✅   | ❌   |
| Faster             | ❌   | ✅   |
| Lower overhead     | ❌   | ✅   |

---

# Real Examples

### TCP

Used when every byte matters:

* HTTP
* HTTPS
* SSH
* Git
* Email
* PostgreSQL
* MySQL

Example:

When cloning your Spring Boot project:

```bash
git clone repository
```

you cannot lose code.

TCP is required.

---

### UDP

Used when speed matters:

* Video calls
* Voice calls
* Online gaming
* DNS queries
* DHCP

Example:

During a Zoom meeting:

```text
Packet lost
```

A tiny audio glitch occurs.

Conversation continues.

---

# Wireshark Practice

Your course suggests:

Start Wireshark.

Capture traffic.

Generate TCP traffic:

```bash
wget www.google.com
```

or:

```bash
curl https://google.com
```

---

Stop the capture.

Filter:

```text
tcp
```

You'll see TCP packets.

---

# Inspecting a TCP Packet

Expand:

```text
Transmission Control Protocol
```

You will see fields like:

```text
Source Port
Destination Port
Sequence Number
Acknowledgment Number
Window Size
Flags
```

---

# Common TCP Flags

### SYN

Start connection.

### ACK

Acknowledge received data.

### FIN

Close connection.

### RST

Forcefully terminate connection.

---

# TCP Three-Way Handshake

Before data transfer:

Client:

```text
SYN
```

Server:

```text
SYN + ACK
```

Client:

```text
ACK
```

Connection established.

This is called:

```text
Three-Way Handshake
```

You will study it in more detail soon.

---

# Correction to the Course Note

Your note says:

```text
ping is udp
```

This is **incorrect**.

Ping uses:

```text
ICMP
```

not UDP and not TCP.

Protocol stack:

```text
Application: ping
Transport: none
Network: ICMP/IP
```

Therefore:

```text
ping ≠ UDP
ping ≠ TCP
ping = ICMP
```

---

# Commands to Remember

Generate TCP traffic:

```bash
wget www.google.com
```

or:

```bash
curl https://google.com
```

Capture with Wireshark.

Filter:

```text
tcp
```

Inspect:

```text
Transmission Control Protocol
```

section.

---

# Interview Questions

### Q1: Why do we need TCP?

**Answer:** Because IP does not guarantee delivery, ordering, or reliability. TCP provides reliable and ordered data transmission.

---

### Q2: What is the difference between TCP and UDP?

**Answer:** TCP guarantees delivery and ordering through acknowledgments and retransmissions, while UDP sends data without guarantees and with lower overhead.

---

### Q3: Which protocol is used by SSH?

**Answer:** TCP.

---

### Q4: Which protocol is commonly used by DNS?

**Answer:** Usually UDP (though TCP can also be used in some situations).

---

### Q5: Does ping use TCP or UDP?

**Answer:** Neither. Ping uses ICMP.

---

### Linux Administrator Insight

For a Linux administrator or backend engineer, the most important takeaway is:

* **TCP** = reliability (web servers, databases, SSH, APIs, Git)
* **UDP** = speed (DNS, DHCP, voice, video, gaming)

Most backend technologies you use—Spring Boot APIs, PostgreSQL, GitHub, SSH, Docker registries—communicate over **TCP**, which is why understanding TCP deeply is essential for backend, DevOps, and SRE roles.
