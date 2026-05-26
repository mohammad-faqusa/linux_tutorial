# 324. Network Address Translation (NAT)

## The Problem NAT Solves

Suppose your home network contains:

```text
Laptop      192.168.1.3
Phone       192.168.1.4
TV          192.168.1.5
Router      192.168.1.1
```

Notice:

```text
192.168.x.x
```

These are **private IP addresses**.

Private IP ranges:

```text
10.0.0.0/8
172.16.0.0 - 172.31.255.255
192.168.0.0/16
```

These addresses are **not routable on the public Internet**.

For example:

```text
192.168.1.3
```

cannot be reached directly from Google.

---

# Public vs Private IP

Your ISP gives your router a public IP:

Example:

```text
Public IP = 84.15.220.45
```

Internet sees:

```text
84.15.220.45
```

not:

```text
192.168.1.3
```

---

# How NAT Works

Suppose your laptop wants to access:

```text
8.8.8.8:80
```

Packet before reaching the router:

```text
Source IP:      192.168.1.3
Source Port:    49003

Destination IP: 8.8.8.8
Destination Port: 80
```

---

# Router Performs NAT

Router changes the packet:

Example:

```text
Source IP:      84.15.220.45
Source Port:    62000

Destination IP: 8.8.8.8
Destination Port: 80
```

Notice:

```text
192.168.1.3
```

became:

```text
84.15.220.45
```

The router may also change the source port.

This specific form is often called:

```text
PAT
Port Address Translation
```

or

```text
NAPT
Network Address Port Translation
```

---

# NAT Table

Router keeps a mapping:

```text
62000 ↔ 192.168.1.3:49003
```

Internally:

| External | Internal          |
| -------- | ----------------- |
| 62000    | 192.168.1.3:49003 |

---

# Server Reply

Google responds:

```text
Source IP:      8.8.8.8
Source Port:    80

Destination IP: 84.15.220.45
Destination Port: 62000
```

Router receives this packet.

Looks at its NAT table:

```text
62000 → 192.168.1.3:49003
```

and rewrites it:

```text
Destination IP: 192.168.1.3
Destination Port: 49003
```

Then sends it to your laptop.

Your laptop never knows NAT happened.

---

# Visual Example

```text
Laptop
192.168.1.3:49003
       │
       ▼
Router NAT
84.15.220.45:62000
       │
       ▼
Google
8.8.8.8:80
```

Reply:

```text
Google
8.8.8.8:80
       │
       ▼
Router NAT
84.15.220.45:62000
       │
       ▼
Laptop
192.168.1.3:49003
```

---

# Why Is NAT Important?

Because NAT allows:

```text
Hundreds of devices
One public IP
```

Without NAT:

every device would need its own public IPv4 address.

IPv4 addresses are limited.

NAT significantly slowed IPv4 exhaustion.

---

# The Inbound Problem

Now suppose your Spring Boot application runs on:

```text
192.168.1.3:8080
```

You want people on the Internet to access it.

Problem:

Internet users cannot see:

```text
192.168.1.3
```

because it is private.

---

# Port Forwarding

Solution:

Configure router:

```text
External Port 80
        ↓
Internal IP 192.168.1.3
Internal Port 8080
```

Now:

```text
84.15.220.45:80
```

automatically forwards to:

```text
192.168.1.3:8080
```

---

# Example

Friend visits:

```text
http://84.15.220.45
```

Router forwards:

```text
84.15.220.45:80
         ↓
192.168.1.3:8080
```

Your Spring Boot application receives the request.

---

# Why Reserve the IP?

Suppose DHCP later changes:

```text
192.168.1.3
```

to:

```text
192.168.1.15
```

Port forwarding now points to the wrong machine.

Broken.

---

Therefore reserve:

```text
MAC Address
↓
Always gets 192.168.1.3
```

This is called:

```text
DHCP Reservation
```

---

# Dynamic Public IP Problem

Most home ISPs assign:

```text
Dynamic Public IP
```

Example today:

```text
84.15.220.45
```

Tomorrow:

```text
92.33.100.17
```

Now nobody knows your new address.

---

# Dynamic DNS (DDNS)

Dynamic DNS solves this.

Instead of remembering:

```text
84.15.220.45
```

you use:

```text
myserver.ddns.net
```

or

```text
myhost123.dyndns.com
```

When IP changes:

```text
84.15.220.45
↓
92.33.100.17
```

the DDNS service updates automatically.

Users continue using:

```text
myhost123.dyndns.com
```

without noticing.

---

# Why Developers Care

Imagine your Spring Boot API:

```text
localhost:8080
```

works perfectly.

But external users cannot access it.

Possible causes:

* NAT
* Missing port forwarding
* Firewall
* ISP blocking ports
* Wrong DHCP reservation

These are extremely common deployment issues.

---

# Modern Alternatives

Today many developers avoid home NAT complications by using:

* AWS EC2
* VPS providers
* Cloud Run
* Railway
* Render
* Fly.io
* Netlify (frontend)
* Vercel (frontend)

because servers already have public IP addresses.

---

# Relation to Docker

Docker also uses NAT.

Example:

```bash
docker run -p 8080:80 nginx
```

Docker performs a type of NAT:

```text
Host:8080
     ↓
Container:80
```

Very similar concept.

---

# Interview Questions

### Q1: What is NAT?

**Answer:** Network Address Translation translates private addresses into public addresses (and vice versa) so devices on private networks can communicate with the Internet.

---

### Q2: Why is NAT needed?

**Answer:** To allow many private devices to share a single public IPv4 address.

---

### Q3: What is port forwarding?

**Answer:** A router rule that forwards incoming traffic from a public port to a specific private IP and port.

---

### Q4: Why use DHCP reservations?

**Answer:** To ensure a device always receives the same internal IP address, preventing port forwarding rules from breaking.

---

### Q5: What problem does Dynamic DNS solve?

**Answer:** It provides a stable hostname even when the public IP address changes.

---

# Linux Administrator Insight

A very common troubleshooting scenario:

```text
Application works on localhost
Application works from another device in LAN
Application does NOT work from the Internet
```

The culprit is often:

```text
NAT + Missing Port Forwarding
```

For example, your Spring Boot app may be listening correctly on:

```text
0.0.0.0:8080
```

but unless the router forwards traffic:

```text
PublicIP:80 → 192.168.1.3:8080
```

nobody outside your network can reach it.

That's why understanding NAT is essential for networking, Linux administration, backend development, DevOps, and cloud deployment.