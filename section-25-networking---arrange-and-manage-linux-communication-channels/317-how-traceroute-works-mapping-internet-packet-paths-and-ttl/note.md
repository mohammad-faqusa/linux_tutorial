

# 317. How `traceroute` Works: TTL and ICMP Time Exceeded

## The Main Idea

`traceroute` discovers every router between you and a destination by **intentionally causing routers to discard packets**.

It achieves this using the IP header field:

```text
TTL (Time To Live)
```

---

# What is TTL?

TTL is an 8-bit field in every IP packet.

Example:

```text
Source IP
Destination IP
TTL = 64
Protocol
Payload
```

Its purpose is to prevent packets from looping forever on the Internet.

---

## What Happens at Each Router?

Whenever a router forwards a packet:

```text
TTL = TTL - 1
```

Example:

```text
Packet leaves PC:
TTL = 5
```

Router 1:

```text
TTL = 4
```

Router 2:

```text
TTL = 3
```

Router 3:

```text
TTL = 2
```

Router 4:

```text
TTL = 1
```

Router 5:

```text
TTL = 0
```

At TTL = 0:

```text
Packet is discarded
```

and the router sends back:

```text
ICMP Time Exceeded
```

---

# Step 1: Discovering Hop #1

Traceroute sends a packet with:

```text
TTL = 1
```

Destination:

```text
sydney.edu.au
```

---

## What Happens?

Your first router receives:

```text
TTL = 1
```

It decrements it:

```text
TTL = 0
```

Now the router must:

1. Drop the packet
2. Generate an ICMP error

Example:

```text
ICMP Time Exceeded
Source: Router
Destination: Your PC
```

Traceroute receives this reply and learns:

```text
Hop #1 = Router IP
```

Example:

```text
192.168.1.1
```

---

# Step 2: Discovering Hop #2

Traceroute sends another packet:

```text
TTL = 2
```

---

## Router 1

Receives:

```text
TTL = 2
```

Decrements:

```text
TTL = 1
```

Forwards packet.

---

## Router 2

Receives:

```text
TTL = 1
```

Decrements:

```text
TTL = 0
```

Drops packet.

Returns:

```text
ICMP Time Exceeded
```

Traceroute now learns:

```text
Hop #2
```

---

# Step 3: Discovering Hop #3

Traceroute sends:

```text
TTL = 3
```

---

Router 1:

```text
3 → 2
```

Router 2:

```text
2 → 1
```

Router 3:

```text
1 → 0
```

Drops packet and returns:

```text
ICMP Time Exceeded
```

Traceroute learns:

```text
Hop #3
```

---

# Repeat Until Destination

Traceroute keeps increasing TTL:

```text
TTL = 1
TTL = 2
TTL = 3
TTL = 4
...
TTL = 50
```

until one packet finally reaches the destination.

At that point:

```text
Destination responds
```

and traceroute knows:

```text
Route completed
```

---

# Visual Example

Suppose the route is:

```text
PC
 ↓
Router A
 ↓
Router B
 ↓
Router C
 ↓
Google
```

### Packet 1

```text
TTL = 1
```

Result:

```text
Router A
ICMP Time Exceeded
```

---

### Packet 2

```text
TTL = 2
```

Result:

```text
Router B
ICMP Time Exceeded
```

---

### Packet 3

```text
TTL = 3
```

Result:

```text
Router C
ICMP Time Exceeded
```

---

### Packet 4

```text
TTL = 4
```

Result:

```text
Destination reached
```

---

# What You See in Wireshark

Your course suggests:

1. Start Wireshark
2. Run:

```bash
traceroute -m 50 sydney.edu.au
```

3. Stop capture
4. Inspect packets

---

## Filter Packets

You can filter by destination IP:

```text
ip.dst == 20.248.131.216
```

(or whatever destination IP Wireshark shows)

---

## Open a Packet

Expand:

```text
Internet Protocol Version 4
```

You'll see:

```text
Time to Live: 1
```

for the first packet.

Later packets:

```text
Time to Live: 2
Time to Live: 3
Time to Live: 4
...
```

Exactly matching the traceroute algorithm.

---

# Example ICMP Response

Router sends:

```text
Internet Control Message Protocol
Type: 11
Code: 0
Time Exceeded
```

Meaning:

```text
TTL expired in transit
```

This is the packet traceroute relies on.

---

# Why Three RTT Values?

Typical output:

```text
5  72.14.220.1
   21 ms
   22 ms
   20 ms
```

Traceroute usually sends **three probes per hop**.

This helps detect:

* packet loss
* congestion
* unstable latency

If one packet takes longer:

```text
20 ms
21 ms
150 ms
```

there may be congestion.

---

# Maximum Hop Count

Your course example:

```bash
traceroute -m 50 sydney.edu.au
```

means:

```text
Maximum TTL = 50
```

Traceroute will stop after:

```text
50 hops
```

even if the destination is not reached.

Default is often:

```text
30 hops
```

---

# Common Interview Questions

### Q1: How does traceroute discover routers?

**Answer:**

By sending packets with increasing TTL values and receiving ICMP "Time Exceeded" messages from routers whose TTL reaches zero.

---

### Q2: Why does a router send ICMP Time Exceeded?

**Answer:**

Because the packet's TTL reached zero, so the router discarded it and informed the sender.

---

### Q3: What field does traceroute manipulate?

**Answer:**

The IP header's TTL (Time To Live) field.

---

### Q4: Why is TTL necessary?

**Answer:**

To prevent packets from looping indefinitely in the network.

---

### Q5: What ICMP message is used by traceroute?

**Answer:**

ICMP Type 11 — Time Exceeded.

---

# Commands to Remember

```bash
traceroute google.com
```

Trace the route to a destination.

```bash
traceroute -m 50 sydney.edu.au
```

Allow up to 50 hops.

```bash
tracepath google.com
```

Alternative traceroute implementation.

```text
Wireshark filter:
icmp
```

Show ICMP Time Exceeded packets.

```text
Wireshark filter:
ip.dst == <destination-ip>
```

Show packets sent toward the destination.

---

### Linux Administrator Insight

When a user says:

> "The website is very slow."

A professional troubleshooter often checks:

```bash
ping website.com
traceroute website.com
```

because:

* `ping` shows **whether the destination responds and the overall latency**
* `traceroute` shows **where along the route the delay begins**

This makes traceroute one of the most valuable network diagnostics tools in Linux and real-world operations.
