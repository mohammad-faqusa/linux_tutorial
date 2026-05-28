## 331. DNS Vulnerabilities and Security Measures

### DNS: Security Problems

#### The Problem

* DNS was designed in the early days of the internet when networks were much smaller and users generally trusted each other.
* Security was not a primary concern during the original design of DNS.
* Traditional DNS does not provide:

  * Encryption
  * Authentication
  * Integrity verification
* Because of this, attackers may manipulate DNS communication in several ways.

---

## Common DNS Vulnerabilities

### 1. DNS Spoofing

#### Definition

* DNS spoofing occurs when an attacker provides fake DNS responses to redirect users to malicious destinations.

#### Example

* A user attempts to visit:

```text
google.com
```

* Normally, DNS should return:

```text
142.250.x.x
```

* An attacker instead returns:

```text
192.168.x.x
```

* The victim is redirected to a fake website controlled by the attacker.

#### Possible Consequences

* Stealing usernames and passwords
* Fake banking websites
* Malware distribution
* Session hijacking

---

### 2. Cache Poisoning

#### Definition

* DNS resolvers cache DNS records to improve performance.
* Cache poisoning occurs when an attacker inserts malicious DNS entries into the resolver's cache.

#### Example

* A DNS resolver normally stores:

```text
github.com → 140.82.x.x
```

* An attacker poisons the cache with:

```text
github.com → malicious IP address
```

* Every user relying on that resolver may now be redirected to the malicious server.

#### Why It Is Dangerous

* Affects many users simultaneously
* Users may not notice the attack
* Attack may persist until the cache expires

---

### 3. Man-in-the-Middle (MITM) Attack

#### Definition

* An attacker intercepts DNS traffic between the client and the DNS server and provides false responses.

#### Common Scenarios

* Public WiFi networks
* Unsecured networks
* Compromised routers

#### Example

* A user sends the query:

```text
facebook.com
```

* The attacker intercepts the request and responds with:

```text
fake-facebook-server
```

* The victim may unknowingly enter credentials into a phishing website.

---

## HTTPS as a Protection Mechanism

### HTTPS and TLS

* Although DNS queries themselves may remain unencrypted, HTTPS protects the transferred data after the connection is established.
* HTTPS uses SSL/TLS certificates to verify the identity of websites.

---

### Example

#### Normal Secure Connection

* The user visits:

```text
https://google.com
```

* The browser checks:

  * SSL/TLS certificate
  * Domain ownership
  * Certificate authority
  * Certificate validity

---

#### If DNS Is Manipulated

* An attacker redirects the victim to a fake server.
* The fake server does not possess Google's legitimate certificate.
* The browser displays warnings such as:

```text
Your connection is not private
NET::ERR_CERT_AUTHORITY_INVALID
```

---

### Important Concept

* HTTPS protects:

  * The transferred data
* HTTPS does NOT protect:

  * DNS queries themselves

---

## DNSSEC (DNS Security Extensions)

### Purpose

* DNSSEC adds authentication and integrity verification to DNS responses.
* It allows clients to verify that DNS responses are genuine.

---

### DNSSEC Helps Prevent

* DNS spoofing
* Cache poisoning
* Forged DNS responses

---

### Important Limitation

* DNSSEC does not encrypt DNS traffic.
* DNS queries may still be visible to attackers or ISPs.

---

## Modern DNS Security Enhancements

### DNS over HTTPS (DoH)

* Encrypts DNS queries using HTTPS.
* Prevents attackers from easily inspecting DNS traffic.

#### Common Providers

* Cloudflare
* Google
* Quad9

---

### DNS over TLS (DoT)

* Another protocol for encrypting DNS traffic using TLS.

---

## Real-World Importance

### Backend and DevOps Relevance

DNS security is important in:

* Cloudflare configurations
* API gateways
* Kubernetes ingress
* Reverse proxies
* SSL/TLS deployments
* Email infrastructure
* Production system security

---

## Practical Example

Suppose your frontend application communicates with:

```text
api.example.com
```

If DNS is compromised:

* Traffic could be redirected to a malicious server.

However:

* HTTPS certificate validation helps prevent attackers from impersonating the legitimate server.

This is why:

* SSL/TLS certificates
* HTTPS enforcement
* Certificate verification

are critically important in modern systems.

---

## Important Security Principle

### DNS vs HTTPS

#### DNS answers:

```text
"Where should I connect?"
```

#### HTTPS answers:

```text
"Can I trust who answered?"
```
