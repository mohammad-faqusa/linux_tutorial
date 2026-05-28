## 332. Manual Domain-IP Mapping: Editing the `/etc/hosts` File on Linux

### Manual Domain Resolution

#### Overview

* Linux systems allow manual hostname-to-IP mapping without using external DNS servers.
* This is done using the local hosts file:

```bash id="zcw3nx"
/etc/hosts
```

* Entries inside this file override normal DNS resolution.

---

## The `/etc/hosts` File

### Purpose

* The `/etc/hosts` file stores static hostname mappings.
* The operating system checks this file before querying DNS servers.

---

### Syntax

```text id="dj7s3o"
<IP_ADDRESS> <HOSTNAME>
```

---

### Common Example

```text id="y2n8o1"
127.0.0.1 localhost
```

#### Explanation

* `127.0.0.1` is the loopback address.
* `localhost` refers to the current machine itself.

---

## Custom Hostname Mappings

### Example 1: Local Development

```text id="55sx3u"
127.0.0.1 my-project.local
```

#### Explanation

* Requests to:

```text id="c7e6h4"
my-project.local
```

will resolve to:

```text id="7wth8g"
127.0.0.1
```

* Useful for:

  * Local web development
  * Testing applications
  * Simulating production domains

---

### Example 2: Redirecting a Real Domain

```text id="0t4w2v"
127.0.0.1 google.com
```

#### Explanation

* The system will attempt to open Google on the local machine instead of the real Google servers.
* This demonstrates that `/etc/hosts` overrides external DNS resolution.

---

### Example 3: Internal Network Servers

```text id="09wrp3"
192.168.1.4 backup-server
```

#### Explanation

* Devices on the local network can be accessed using:

```text id="8zq2dj"
backup-server
```

instead of typing the IP address directly.

---

## Editing the Hosts File

### Open the File

```bash id="8fnyoe"
sudo nano /etc/hosts
```

---

### Example Configuration

```text id="13lmdv"
127.0.0.1 localhost
127.0.0.1 my-project.local
192.168.1.4 backup-server
```

---

### Save Changes in Nano

| Action | Shortcut   |
| ------ | ---------- |
| Save   | `CTRL + O` |
| Exit   | `CTRL + X` |

---

## Testing Host Resolution

### Use `ping`

```bash id="8u5o8k"
ping my-project.local
```

Expected result:

```text id="c7gd6m"
PING my-project.local (127.0.0.1)
```

---

### Use `host`

```bash id="a4tx0m"
host my-project.local
```

---

## Important Notes

### Hosts File Priority

* The `/etc/hosts` file is usually checked before DNS servers.
* This means local mappings override public DNS records.

---

### Local Scope

* Changes only affect the current machine.
* Other devices on the network will not use these mappings unless configured separately.

---

## Real-World Use Cases

### 1. Local Development

#### Example

* A developer may simulate a production domain locally:

```text id="12ojm9"
127.0.0.1 api.myapp.local
```

Useful for:

* Backend development
* Frontend API testing
* SSL certificate testing

---

### 2. Blocking Websites

#### Example

```text id="g1w5a6"
127.0.0.1 facebook.com
```

* Requests to Facebook will fail locally.

---

### 3. Internal Infrastructure

#### Example

```text id="s8b0jp"
192.168.1.10 database-server
192.168.1.11 monitoring-server
```

* Makes internal systems easier to access.

---

## Refreshing Local DNS Cache

### Why Refresh?

* DNS resolvers may cache previous DNS results.
* After editing `/etc/hosts`, cached entries may still be used.

---

# Checking Which DNS Service Is Running

### Check Port 53

```bash id="9zhj8g"
sudo lsof -i :53
```

#### Explanation

* Port `53` is the DNS port.
* This command identifies which DNS service is listening.

---

## Using `systemd-resolved`

### Most Common on Modern Linux Systems

---

### Flush DNS Cache

```bash id="0cn72k"
sudo resolvectl flush-caches
```

---

### Show Resolver Status

```bash id="rc2zhq"
sudo resolvectl status
```

---

### Show DNS Statistics

```bash id="k2nr9g"
sudo resolvectl statistics
```

---

### Reset Statistics

```bash id="j0jlwm"
sudo resolvectl reset-statistics
```

---

## Using `dnsmasq`

### Restart the Service

```bash id="2m1e0g"
sudo systemctl restart dnsmasq
```

---

## macOS DNS Cache Flush

```bash id="7ifh3u"
sudo dscacheutil -flushcache
```

---

## Important Networking Concepts

### Loopback Address

#### `127.0.0.1`

* Refers to the current machine itself.
* Known as:

  * localhost
  * loopback interface

---

### DNS Resolution Order

Typical resolution order:

```text id="cx8k20"
1. Browser cache
2. /etc/hosts
3. Local DNS cache
4. DNS resolver
5. External DNS servers
```

---

## Real-World DevOps and Backend Relevance

The `/etc/hosts` file is commonly used for:

* Local development environments
* API testing
* Internal infrastructure naming
* Reverse proxy testing
* SSL certificate testing
* Kubernetes and container debugging
* Simulating production domains locally

---

## Practical Example

Suppose a backend API runs locally on port `8080`.

You may configure:

```text id="i3y8j0"
127.0.0.1 api.myproject.local
```

Then access:

```text id="we6szm"
http://api.myproject.local:8080
```

instead of:

```text id="8nys0h"
http://localhost:8080
```

This better simulates real production environments.
