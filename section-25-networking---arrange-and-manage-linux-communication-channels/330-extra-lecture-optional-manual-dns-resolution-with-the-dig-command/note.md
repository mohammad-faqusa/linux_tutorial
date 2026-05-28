# What is `dig`?

`dig` stands for:

```text
Domain Information Groper
```

It manually queries DNS servers.

Unlike normal DNS resolution, with `dig` you can:

* choose WHICH DNS server to ask
* inspect the full DNS response
* follow DNS delegation manually
* troubleshoot DNS step-by-step

---

# Manual DNS Resolution

Normally DNS resolution is automatic:

```text
Browser
→ Resolver
→ Root server
→ TLD server
→ Authoritative server
→ Final answer
```

With `dig`, we can manually walk through these steps ourselves.

This is extremely valuable for deeply understanding DNS.

---

# Step 1 — Ask a Root DNS Server

Command:

```bash
dig @a.root-servers.net com NS
```

Meaning:

```text
@a.root-servers.net
```

Ask THIS specific DNS server.

and:

```text
com NS
```

Ask:

> "Who are the name servers responsible for `.com`?"

---

# Expected Result

You’ll see something like:

```text
com.    172800 IN NS a.gtld-servers.net.
com.    172800 IN NS b.gtld-servers.net.
```

Meaning:

```text
The .com TLD is managed by these servers
```

This is DNS delegation.

The root server does NOT know Google’s IP.

It only says:

```text
"I don't know google.com,
but these servers manage .com domains."
```

---

# Step 2 — Ask the `.com` TLD Server

Now ask one of those `.com` servers:

```bash
dig @e.gtld-servers.net google.com NS
```

Meaning:

```text
Who manages google.com?
```

Expected result:

```text
google.com. IN NS ns1.google.com.
google.com. IN NS ns2.google.com.
```

Meaning:

```text
These are Google's authoritative DNS servers
```

Again:
The `.com` server does NOT give the final IP.

It delegates responsibility.

---

# Step 3 — Ask Google's Authoritative DNS Server

Now we ask Google's own nameserver:

```bash
dig @ns1.google.com google.com A
```

Expected result:

```text
google.com. IN A 142.250.x.x
```

NOW we finally receive the real IP address.

---

# Full DNS Resolution Chain

The entire process becomes:

```text
1. Root server
   ↓
2. .com TLD server
   ↓
3. google.com's authoritative nameserver
   ↓
4. Final A record
```

This is exactly how DNS works internally.

---

# Understanding the Commands

---

# Query Specific Server

```bash
dig @server domain type
```

Example:

```bash
dig @8.8.8.8 google.com A
```

Ask Google DNS directly.

---

# Query Record Types

## A Record

```bash
dig google.com A
```

---

## AAAA Record

```bash
dig google.com AAAA
```

---

## MX Record

```bash
dig gmail.com MX
```

---

## NS Record

```bash
dig google.com NS
```

---

# ALL Records

```bash
dig google.com ANY
```

or:

```bash
dig google.com all
```

However:
many DNS providers restrict `ANY` queries today for security/performance reasons.

---

# Important Sections in `dig` Output

Example:

```bash
dig google.com
```

You’ll see:

---

## HEADER

```text
;; ->>HEADER<<- opcode: QUERY, status: NOERROR
```

Indicates:

* query succeeded
* no DNS errors

---

## QUESTION SECTION

```text
;; QUESTION SECTION:
;google.com. IN A
```

What we asked for.

---

## ANSWER SECTION

```text
google.com. 300 IN A 142.250.x.x
```

This is the actual answer.

---

## AUTHORITY SECTION

Shows authoritative DNS servers.

---

## ADDITIONAL SECTION

Extra helpful information:
usually IPs of nameservers.

---

# TTL (Time To Live)

Example:

```text
google.com. 300 IN A 142.250.x.x
```

The `300` means:

```text
Cache this record for 300 seconds
```

Very important in:

* DNS propagation
* Cloudflare changes
* deployment debugging

---

# Very Important Real-World Usage

You will heavily use `dig` later for:

---

## 1. Debugging Domain Propagation

```bash
dig @8.8.8.8 mohammadfaqusa.com
dig @1.1.1.1 mohammadfaqusa.com
```

Compare DNS providers.

---

## 2. Debugging Cloudflare

Check:

* proxied records
* nameservers
* propagation
* caching

---

## 3. Email Troubleshooting

```bash
dig gmail.com MX
```

Important for:

* SPF
* DKIM
* DMARC

---

## 4. Kubernetes / DevOps

Common production debugging:

```bash
dig service.namespace.svc.cluster.local
```

---

## 5. Docker Networking

DNS inside containers.

---

# Extremely Useful Short Commands

## Short output only

```bash
dig +short google.com
```

Returns only IPs.

Very commonly used in scripts.

---

## Reverse DNS Lookup

```bash
dig -x 8.8.8.8
```

Find domain name from IP.

---

# Compare `host` vs `dig`

| Tool       | Purpose                |
| ---------- | ---------------------- |
| `host`     | Simple quick queries   |
| `dig`      | Professional debugging |
| `nslookup` | Older interactive tool |

In real production:
`dig` is king.

---

# Mini Labs

Try these:

## Full DNS chain manually

```bash
dig @a.root-servers.net com NS
dig @e.gtld-servers.net google.com NS
dig @ns1.google.com google.com A
```

---

## Check your domain

```bash
dig mohammadfaqusa.com
```

---

## Check Cloudflare DNS

```bash
dig @1.1.1.1 google.com
```

---

## Check Google DNS

```bash
dig @8.8.8.8 google.com
```

---

# Important Concept

DNS is NOT a single database.

It is:

* distributed
* hierarchical
* delegated

That is why DNS scales globally.

---

