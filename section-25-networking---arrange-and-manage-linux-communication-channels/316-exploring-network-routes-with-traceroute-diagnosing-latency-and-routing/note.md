

# 316. Exploring Network Routes with `traceroute`

## Why Do We Need Traceroute?

Suppose:

```bash
ping google.com
```

returns:

```text
time=250ms
```

You know the connection is slow, but:

❌ You don't know where the delay occurs.

Questions:

* Is my router causing the problem?
* Is my ISP causing the problem?
* Is there congestion somewhere on the Internet?
* Is the destination server far away?

To answer these questions we use:

```bash
traceroute
```

---

# What Is Traceroute?

Traceroute is a network diagnostic tool that:

* Shows the path packets take
* Lists intermediate routers
* Measures latency at each hop
* Helps locate routing problems
* Helps detect network congestion

---

# Basic Usage

```bash
traceroute google.com
```

Example:

```text
1  192.168.1.1      1.2 ms   1.4 ms   1.1 ms
2  10.20.0.1        8.5 ms   9.0 ms   8.7 ms
3  172.16.50.1      12 ms    11 ms    13 ms
4  72.14.220.1      25 ms    24 ms    25 ms
5  google.com       30 ms    31 ms    29 ms
```

This means:

```text
Your PC
   ↓
Router #1
   ↓
ISP Router
   ↓
Backbone Router
   ↓
Google Router
   ↓
Destination
```

---

# What Is a Hop?

A **hop** is one router that forwards your packet.

Example:

```text
PC → Router → ISP → Google
```

contains:

```text
3 hops
```

Each router counts as one hop.

---

# Understanding the Output

Example:

```text
3  172.16.50.1   12 ms   11 ms   13 ms
```

### Hop Number

```text
3
```

This is the third router encountered.

---

### Router IP Address

```text
172.16.50.1
```

The router that handled the packet.

Sometimes a hostname is shown:

```text
core-router.example.net
```

instead of an IP.

---

### RTT Values

```text
12 ms 11 ms 13 ms
```

Traceroute usually sends three probes.

Each value shows:

```text
Round Trip Time
```

for one probe.

Lower values are generally better.

---

# How Does Traceroute Work?

This is one of the most common interview questions.

Traceroute uses:

```text
TTL (Time To Live)
```

field in IP packets.

Recall from ping:

Every router decreases TTL by 1.

When TTL reaches 0:

```text
Router discards packet
```

and sends back an ICMP message:

```text
Time Exceeded
```

---

## Step 1

Traceroute sends a packet with:

```text
TTL = 1
```

First router receives it:

```text
TTL becomes 0
```

Router responds:

```text
ICMP Time Exceeded
```

Traceroute records:

```text
Hop 1
```

---

## Step 2

Traceroute sends:

```text
TTL = 2
```

Packet passes router #1.

Router #2 decreases TTL to 0.

Router #2 responds.

Traceroute records:

```text
Hop 2
```

---

## Step 3

Traceroute sends:

```text
TTL = 3
```

and so on.

Eventually the destination responds and the route is complete.

---

# Limiting Maximum Hops

Your course example:

```bash
traceroute -m 50 sydney.edu.au
```

### What does `-m` mean?

```text
Maximum TTL
```

or maximum number of hops.

Default is often:

```text
30 hops
```

You can increase it:

```bash
traceroute -m 50 google.com
```

Useful for very distant destinations.

---

# Installing Traceroute

Ubuntu:

```bash
sudo apt install traceroute
```

Fedora/RHEL/Rocky:

```bash
sudo dnf install traceroute
```

Verify:

```bash
which traceroute
```

---

# Understanding Asterisks (*)

Example:

```text
7 * * *
```

This means:

The router didn't reply.

Possible reasons:

### ICMP blocked

Many routers intentionally ignore traceroute requests.

---

### Firewall

Firewall blocks responses.

---

### Rate limiting

Router is busy and ignores diagnostic traffic.

---

### Packet loss

Actual network problem.

---

Important:

A single `*` does **not necessarily mean failure**.

If later hops continue responding:

```text
7 * * *
8 203.0.113.1  25 ms
9 google.com   30 ms
```

the route is still working.

---

# Detecting High Latency

Example:

```text
1 192.168.1.1      1 ms
2 10.20.0.1        5 ms
3 172.16.50.1      8 ms
4 203.0.113.1    250 ms
5 google.com     255 ms
```

Notice:

```text
8 ms → 250 ms
```

Huge increase.

Possible causes:

* Congestion
* Slow ISP link
* International connection
* Overloaded router

This identifies where latency begins.

---

# Detecting Routing Loops

Example:

```text
5 10.0.0.1
6 10.0.0.2
7 10.0.0.1
8 10.0.0.2
9 10.0.0.1
```

Same routers appear repeatedly.

This suggests:

```text
Routing Loop
```

Packets are bouncing between routers instead of reaching the destination.

This is a network misconfiguration.

---

# Traceroute vs Ping

| Feature                    | Ping | Traceroute |
| -------------------------- | ---- | ---------- |
| Checks reachability        | ✅    | ✅          |
| Measures latency           | ✅    | ✅          |
| Shows intermediate routers | ❌    | ✅          |
| Detects routing problems   | ❌    | ✅          |
| Simple connectivity test   | ✅    | ❌          |
| Path analysis              | ❌    | ✅          |

---

# Modern Alternative: tracepath

Many Linux systems include:

```bash
tracepath google.com
```

Advantages:

* Usually installed by default
* Doesn't require root privileges
* Easier output

Example:

```bash
tracepath google.com
```

Try it on Ubuntu if `traceroute` isn't installed.

---

# Practical Exercise

Run:

```bash
traceroute google.com
```

or

```bash
tracepath google.com
```

Observe:

1. Number of hops
2. First hop (your router)
3. ISP routers
4. RTT increases
5. Any `*` responses

Then compare with:

```bash
ping google.com
```

You'll see that:

* `ping` tells **how fast the destination responds**
* `traceroute` tells **where the delay occurs**

---

# Interview Questions

### Q1: What does traceroute do?

**Answer:** It shows the path packets take from source to destination and measures latency at each hop.

---

### Q2: How does traceroute discover routers?

**Answer:** By sending packets with increasing TTL values and receiving ICMP "Time Exceeded" responses from routers.

---

### Q3: What is a hop?

**Answer:** A router that forwards a packet toward its destination.

---

### Q4: What do `* * *` entries mean?

**Answer:** The router did not respond to traceroute probes, often due to ICMP filtering, firewalls, rate limiting, or packet loss.

---

### Q5: When would you use traceroute instead of ping?

**Answer:** When connectivity is slow or failing and you need to identify which router or network segment is causing the problem.
