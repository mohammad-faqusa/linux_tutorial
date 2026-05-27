# 328. The Domain Name System (DNS)

## What Is DNS?

DNS stands for:

```text
Domain Name System
```

It is an **Application Layer (Layer 7)** protocol.

Purpose:

```text
Translate Domain Names → IP Addresses
```

Example:

```text
google.com
↓
142.250.x.x
```

Humans prefer:

```text
google.com
```

Computers route packets using:

```text
IP addresses
```

DNS bridges the gap.

---

# Why DNS Is Needed

Suppose your browser wants to access:

```text
https://google.com
```

TCP/IP networking requires:

```text
Destination IP Address
```

not:

```text
google.com
```

Therefore:

Before any HTTP or HTTPS request can happen:

```text
Domain Name
↓
DNS Resolution
↓
IP Address
↓
TCP Connection
↓
HTTPS
↓
HTTP Request
```

---

# DNS Uses Port 53

Typically:

```text
UDP Port 53
```

Sometimes:

```text
TCP Port 53
```

for large responses or zone transfers.

---

# Step 1 — Local Browser Cache

Modern browsers keep their own DNS cache.

Suppose you recently visited:

```text
google.com
```

Browser may already know:

```text
google.com → 142.250.x.x
```

If found:

```text
No network DNS request needed
```

Very fast.

---

# Step 2 — Operating System Cache

If browser cache misses:

Browser asks the OS:

```text
Do you know google.com?
```

Linux also maintains a DNS cache.

If found:

```text
Done
```

---

# Step 3 — DNS Resolver

If OS also doesn't know:

the system contacts a:

```text
DNS Resolver
```

Usually provided by:

* ISP
* Google DNS
* Cloudflare DNS
* company network

Examples:

| Provider       | IP      |
| -------------- | ------- |
| Google DNS     | 8.8.8.8 |
| Google DNS     | 8.8.4.4 |
| Cloudflare DNS | 1.1.1.1 |
| Cloudflare DNS | 1.0.0.1 |

---

# What Is a DNS Resolver?

A DNS resolver performs the hard work of finding the IP address.

Your computer asks:

```text
What's the IP of google.com?
```

The resolver investigates and returns the answer.

---

# Resolver Cache

Resolvers also cache DNS records.

Suppose millions of people request:

```text
google.com
```

It would be inefficient to query root servers every time.

Therefore the resolver stores answers temporarily.

This is controlled by:

```text
TTL
Time To Live
```

in DNS records.

---

# If Resolver Doesn't Know

Now the real DNS resolution process begins.

---

# Root Name Servers

Your course mentions:

```text
13 root server groups
```

Named:

```text
A.root-servers.net
B.root-servers.net
...
M.root-servers.net
```

These are the top of the DNS hierarchy.

---

# Important Clarification

There are not only 13 physical servers.

There are:

```text
13 logical root server clusters
```

distributed worldwide using Anycast.

---

# Step 1 — Ask Root Server

Resolver asks:

```text
Where is google.com?
```

Root server replies:

```text
I don't know google.com
But ask the .com TLD servers
```

---

# Step 2 — Ask TLD Server

TLD = Top-Level Domain.

Examples:

```text
.com
.org
.net
.edu
.ps
```

Resolver contacts:

```text
.com TLD servers
```

asks:

```text
Where is google.com?
```

TLD server replies:

```text
Ask Google's authoritative name servers
```

Example:

```text
ns1.google.com
```

---

# Step 3 — Ask Authoritative Name Server

Now resolver contacts:

```text
ns1.google.com
```

asks:

```text
What's the IP of google.com?
```

Now we finally get the answer:

```text
google.com → 142.250.x.x
```

---

# Step 4 — Return Result

Resolver now:

1. Stores the answer in cache
2. Sends the IP to your operating system
3. OS sends it to the browser
4. Browser can finally connect

---

# Full DNS Flow

```text
Browser Cache
      ↓
OS Cache
      ↓
DNS Resolver
      ↓
Root Server
      ↓
TLD Server (.com)
      ↓
Authoritative Server (ns1.google.com)
      ↓
IP Address Returned
      ↓
Browser Connects
```

---

# Authoritative Name Server

This is the server that officially knows the DNS records for a domain.

For your domain:

```text
mohammadfaqusa.com
```

Cloudflare currently acts as the authoritative DNS provider.

Meaning:

Cloudflare stores records like:

```text
api.mohammadfaqusa.com
portfolio.mohammadfaqusa.com
mail.mohammadfaqusa.com
```

---

# Example with Your Domain

Suppose someone visits:

```text
portfolio.mohammadfaqusa.com
```

DNS process eventually reaches:

Cloudflare authoritative DNS servers.

Cloudflare replies:

```text
portfolio.mohammadfaqusa.com
↓
76.76.x.x
```

(or whatever IP/service you configured).

---

# Common DNS Record Types

## A Record

Maps:

```text
Domain → IPv4 Address
```

Example:

```text
api.example.com → 192.168.1.10
```

---

## AAAA Record

Maps:

```text
Domain → IPv6 Address
```

---

## CNAME Record

Alias to another domain.

Example:

```text
www.example.com
↓
example.com
```

---

## MX Record

Mail servers.

Example:

```text
gmail.com → mail servers
```

---

## TXT Record

Text-based metadata.

Used for:

* SPF
* DKIM
* domain verification

---

# DNS Tools in Linux

## nslookup

```bash
nslookup google.com
```

---

## dig

Better and more professional:

```bash
dig google.com
```

---

## Query Specific Resolver

```bash
dig @8.8.8.8 google.com
```

Ask Google DNS directly.

---

## Show Mail Servers

```bash
dig MX gmail.com
```

---

# DNS and Cloudflare

Since you use Cloudflare:

When you create:

```text
laptop.mohammadfaqusa.com
```

you are creating DNS records.

Cloudflare becomes your authoritative DNS provider.

---

# DNS Caching and Propagation

Suppose you change:

```text
api.mohammadfaqusa.com
```

to a new IP.

Some users may still see the old IP temporarily because of caching.

This is called:

```text
DNS Propagation
```

though technically it's usually cache expiration.

---

# Interview Questions

### Q1: What is DNS?

**Answer:** A Layer 7 protocol that translates domain names into IP addresses.

---

### Q2: Which port does DNS usually use?

**Answer:** UDP 53.

---

### Q3: What is a DNS resolver?

**Answer:** A server that resolves domain names into IP addresses on behalf of clients.

---

### Q4: What is an authoritative name server?

**Answer:** The server officially responsible for DNS records of a domain.

---

### Q5: What are root name servers?

**Answer:** The top-level DNS servers that direct resolvers toward TLD servers.

---

### Q6: What does a TLD server do?

**Answer:** It directs queries to the authoritative name servers for a domain.