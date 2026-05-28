# DNS Record Types

DNS (Domain Name System) converts human-readable names like `google.com` into IP addresses that computers understand.

---

# 1. A Record (IPv4)

Maps a domain to an IPv4 address.

Example:

```bash
host google.com
```

Possible output:

```bash
google.com has address 142.250.74.14
```

Meaning:

```text
google.com → 142.250.74.14
```

This is the most common DNS record on the internet.

---

# 2. AAAA Record (IPv6)

Maps a domain to an IPv6 address.

Example:

```bash
host -t AAAA google.com
```

Possible output:

```bash
google.com has IPv6 address 2a00:1450:400f:80d::200e
```

Why called AAAA?

Because IPv6 addresses are 128-bit (4 times larger than IPv4).

---

# 3. CNAME Record (Alias)

Creates an alias pointing to another domain.

Example:

```text
mail.example.com → example.com
```

Command:

```bash
host -t CNAME www.google.com
```

Possible output:

```bash
www.google.com is an alias for forcesafesearch.google.com
```

Meaning:

```text
www.google.com → another hostname
```

Very common in:

* CDNs
* Cloudflare
* Vercel
* Netlify
* subdomains

You will use this heavily when deploying your future React portfolio and custom domains.

---

# 4. MX Record (Mail Exchange)

Specifies mail servers responsible for receiving emails.

Example:

```bash
host -t MX gmail.com
```

Possible output:

```bash
gmail.com mail is handled by 10 alt1.gmail-smtp-in.l.google.com.
```

Meaning:

* Gmail has dedicated email servers
* Lower priority number = higher priority

Example:

```text
Priority 10 → primary mail server
Priority 20 → backup server
```

This is extremely important for:

* custom domain emails
* SPF/DKIM/DMARC later
* your Cloudflare email routing setup

---

# 5. NS Record (Name Servers)

Defines authoritative DNS servers for a domain.

Example:

```bash
host -t NS google.com
```

Possible output:

```bash
google.com name server ns1.google.com.
```

Meaning:
These servers contain the official DNS records for the domain.

When you buy a domain from:

* Cloudflare
* Namecheap
* GoDaddy

you usually configure NS records.

---

# The `host` Command

Linux utility used to query DNS records.

Basic syntax:

```bash
host domain.com
```

---

# Useful Examples

## Query default records

```bash
host google.com
```

---

## Query all records

```bash
host -a google.com
```

This shows:

* A
* AAAA
* MX
* NS
* SOA

and more.

---

## Query specific record types

### IPv4

```bash
host -t A google.com
```

### IPv6

```bash
host -t AAAA google.com
```

### Mail servers

```bash
host -t MX gmail.com
```

### Name servers

```bash
host -t NS google.com
```

### CNAME

```bash
host -t CNAME www.github.com
```

---

# Very Important Real-World Skill

As a backend/full-stack/devops engineer, you’ll constantly use DNS tools for:

* debugging deployments
* verifying domains
* checking SSL setups
* Cloudflare troubleshooting
* email configuration
* Kubernetes ingress debugging
* reverse proxy issues
* API routing problems

---

# Another Important Concept

DNS resolution usually follows this order:

```text
Browser cache
↓
OS cache
↓
DNS Resolver (ISP/Cloudflare/Google)
↓
Root DNS servers
↓
TLD servers (.com)
↓
Authoritative name servers
↓
Final IP address
```

---

# Practical Labs You Should Try

## 1. Inspect Google

```bash
host -a google.com
```

---

## 2. Inspect GitHub mail servers

```bash
host -t MX github.com
```

---

## 3. Inspect your own domain

Example:

```bash
host -a mohammadfaqusa.com
```

Very useful because you already use Cloudflare and custom email routing.

---

# Compare With Other DNS Tools

Linux has multiple DNS tools:

| Tool       | Purpose                |
| ---------- | ---------------------- |
| `host`     | Simple DNS queries     |
| `dig`      | Advanced DNS debugging |
| `nslookup` | Older interactive tool |

Later you’ll probably use:

* `dig`
* `resolvectl`
* `systemd-resolve`

much more in production environments.

---

# Mini Challenge

Try these:

```bash
host google.com
host -t MX gmail.com
host -t NS cloudflare.com
host -a github.com
```

Then observe:

* which records exist
* IPv4 vs IPv6
* mail priorities
* aliases
* authoritative DNS servers
