

# 315. The Program `ping`: Inspecting Network Connectivity Using ICMP

## What is Ping?

Sometimes we want to answer a simple question:

> "Can my computer reach another device on the network?"

For this purpose, we use:

```bash
ping <destination>
```

Example:

```bash
ping 8.8.8.8
```

`8.8.8.8` is Google's public DNS server.

---

# Which Layer Does Ping Work On?

Ping works at:

### Layer 3 (Network Layer)

of the TCP/IP model.

Protocols involved:

* IP (Internet Protocol)
* ICMP (Internet Control Message Protocol)

Unlike:

* HTTP → uses TCP
* SSH → uses TCP
* DNS → uses UDP/TCP

Ping uses **ICMP directly**.

---

# How Ping Works

Suppose you run:

```bash
ping 8.8.8.8
```

### Step 1

Your computer sends:

```text
ICMP Echo Request
```

to 8.8.8.8

Think of it as:

> "Hello, are you there?"

---

### Step 2

The destination receives the request.

If ICMP is allowed:

```text
ICMP Echo Reply
```

is returned.

Equivalent to:

> "Yes, I'm here."

---

### Step 3

Ping calculates:

```text
Round Trip Time (RTT)
```

The time required for:

```text
Request → Destination → Reply → Back
```

---

# Example Output

```bash
ping 8.8.8.8
```

Output:

```text
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.

64 bytes from 8.8.8.8:
icmp_seq=1 ttl=118 time=32.4 ms

64 bytes from 8.8.8.8:
icmp_seq=2 ttl=118 time=30.8 ms

64 bytes from 8.8.8.8:
icmp_seq=3 ttl=118 time=31.7 ms
```

---

# Understanding Each Field

### icmp_seq

```text
icmp_seq=1
icmp_seq=2
icmp_seq=3
```

Sequence number.

Each request increments by 1.

Useful for detecting packet loss.

---

### ttl

```text
ttl=118
```

TTL = Time To Live

Maximum number of routers the packet can cross.

Every router decreases TTL by 1.

If TTL reaches:

```text
0
```

packet is discarded.

Purpose:

Prevent packets from looping forever.

---

### time

```text
time=31.7 ms
```

Round-trip latency.

Means:

Request + Reply took 31.7 milliseconds.

---

# Stopping Ping

Linux ping runs forever.

Stop it with:

```bash
Ctrl + C
```

Example:

```text
--- 8.8.8.8 ping statistics ---

5 packets transmitted
5 received
0% packet loss

rtt min/avg/max/mdev =
29.8/31.4/33.2/1.1 ms
```

---

# Sending a Fixed Number of Pings

Instead of running forever:

```bash
ping -c 4 8.8.8.8
```

Output:

```text
4 packets transmitted
4 received
```

Useful in scripts and troubleshooting.

---

# Testing Connectivity Step by Step

When internet is not working:

## Test Localhost

```bash
ping 127.0.0.1
```

or

```bash
ping localhost
```

Expected:

```text
64 bytes from 127.0.0.1
```

Verifies:

* TCP/IP stack works

---

## Test Router

Example:

```bash
ping 192.168.1.1
```

Verifies:

* Local network connectivity

---

## Test Public IP

```bash
ping 8.8.8.8
```

Verifies:

* Internet connectivity

---

## Test Domain Name

```bash
ping google.com
```

Verifies:

* Internet connectivity
* DNS resolution

---

# Diagnosing Problems

### Case 1: Router Reachable, Internet Not Reachable

```bash
ping 192.168.1.1
```

Works.

```bash
ping 8.8.8.8
```

Fails.

Possible issues:

* ISP outage
* Gateway problem
* Routing issue

---

### Case 2: Public IP Works, Domain Fails

```bash
ping 8.8.8.8
```

Works.

```bash
ping google.com
```

Fails.

Likely:

```text
DNS problem
```

---

### Case 3: Everything Fails

```bash
ping 192.168.1.1
```

Fails.

Possible issues:

* Wi-Fi disconnected
* Ethernet unplugged
* Wrong IP configuration
* DHCP failure

---

# Viewing ICMP Traffic in Wireshark

Your course suggests:

> Filter by ICMP.

### Steps

1. Open Wireshark.
2. Select your network interface.
3. Start capture.
4. Run:

```bash
ping 8.8.8.8
```

5. In Wireshark filter:

```text
icmp
```

You'll see:

```text
Echo Request
Echo Reply
Echo Request
Echo Reply
```

---

# What Information Appears in Wireshark?

For every packet:

### Source IP

Example:

```text
192.168.1.100
```

---

### Destination IP

```text
8.8.8.8
```

---

### ICMP Type

Request:

```text
Type 8
Echo Request
```

Reply:

```text
Type 0
Echo Reply
```

---

### Sequence Number

```text
Sequence = 1
Sequence = 2
```

Matches the `icmp_seq` field shown by ping.

---

# Common Interview Questions

### Q1: Which protocol does ping use?

**Answer:**

ICMP (Internet Control Message Protocol).

---

### Q2: Does ping use TCP or UDP?

**Answer:**

Neither.

It uses ICMP directly over IP.

---

### Q3: What does ping test?

**Answer:**

Network reachability and latency between two hosts.

---

### Q4: What does RTT mean?

**Answer:**

Round Trip Time — the time required for a packet to travel to the destination and back.

---

# Commands to Remember

```bash
ping 8.8.8.8
```

Test connectivity.

```bash
ping google.com
```

Test connectivity and DNS.

```bash
ping localhost
```

Test local TCP/IP stack.

```bash
ping -c 4 8.8.8.8
```

Send exactly 4 requests.

```bash
ping 192.168.1.1
```

Test connection to the router.

```bash
wireshark
```

Capture packets and filter with:

```text
icmp
```

to inspect Echo Requests and Echo Replies visually.

---

### Practical Exercise (for your Ubuntu laptop)

Run these commands and compare the results:

```bash
ping -c 4 localhost
ping -c 4 $(ip route | grep default | awk '{print $3}')
ping -c 4 8.8.8.8
ping -c 4 google.com
```

This tests the entire path:

**Your machine → Router → Internet → DNS**.
