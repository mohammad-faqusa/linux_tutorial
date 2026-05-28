## 333. The mDNS (Multicast DNS) Standard: Configuring Hostnames in Local Networks

### Hostnames in Local Networks

#### What Is a Hostname?

* A hostname is a human-readable name assigned to a device on a network.
* Hostnames make devices easier to identify and access without remembering IP addresses.

#### Example

Instead of connecting to:

```text id="gnrjgt"
192.168.1.15
```

we may connect using:

```text id="mpvm0s"
ubuntu-server
```

---

## Hostnames and DHCP

### During DHCP Negotiation

* When a device requests an IP address from a DHCP server, it may also send its hostname.
* The DHCP server can associate:

  * IP address
  * MAC address
  * hostname

---

## Displaying the Current Hostname

### Show Hostname

```bash id="4m6g9k"
hostname
```

---

## Changing the Hostname

### Temporary Change

```bash id="jlwm0v"
sudo hostname new-hostname
```

* This change may be lost after reboot.

---

### Permanent Change

#### Edit the Hostname File

```bash id="vtjlwm"
sudo nano /etc/hostname
```

Example:

```text id="khz8z8"
myserver
```

---

#### Update `/etc/hosts`

```bash id="t0vlz6"
sudo nano /etc/hosts
```

Example:

```text id="vfgm2g"
127.0.0.1 localhost
127.0.1.1 myserver
```

---

#### Apply Changes

```bash id="eh44hj"
sudo reboot
```

or:

```bash id="jlwm18"
sudo systemctl restart systemd-hostnamed
```

---

# Resolving Local Hostnames

## Accessing Devices by Hostname

### Example

```bash id="4mdgr6"
ping ubuntu.local
```

Expected result:

```text id="9qys7l"
PING ubuntu.local (192.168.x.x)
```

---

# Why `.local`?

### The `.local` Domain

* `.local` is a special domain reserved for local network hostname discovery.
* It is used by:

```text id="r3r0pw"
mDNS (Multicast DNS)
```

---

# What Is mDNS?

## Multicast DNS (mDNS)

### Definition

* mDNS allows devices on the same local network to discover and communicate with each other without a traditional DNS server.

### Main Idea

* Devices broadcast DNS queries using multicast packets.
* Other devices on the network respond if they own the requested hostname.

---

# Example Workflow

Suppose a device named:

```text id="sgk0gk"
raspberrypi.local
```

exists on the network.

Another device sends:

```text id="h8fy8o"
Who is raspberrypi.local?
```

using multicast.

The Raspberry Pi responds with its IP address.

---

# Difference Between DNS and mDNS

| Feature             | Traditional DNS           | mDNS           |
| ------------------- | ------------------------- | -------------- |
| Requires DNS server | Yes                       | No             |
| Scope               | Internet / large networks | Local networks |
| Query Type          | Unicast                   | Multicast      |
| Common Domain       | `.com`, `.org`            | `.local`       |
| Infrastructure      | Centralized               | Peer-to-peer   |

---

# Important Requirements

## Both Devices Must Support mDNS

For mDNS to work correctly:

* Both devices must:

  * Be on the same local network
  * Support mDNS
  * Have mDNS services running properly

---

# mDNS on Different Operating Systems

## macOS

### Bonjour / Zeroconf

* macOS supports mDNS by default using:

```text id="qtjlwm"
Bonjour
```

also known as:

```text id="o6m4qz"
Zeroconf (Zero Configuration Networking)
```

---

## Linux

### Avahi Daemon

* Linux commonly uses:

```text id="31nln4"
Avahi
```

to provide mDNS support.

---

### Install Required Packages

#### CentOS / Rocky Linux

```bash id="1lgjkm"
sudo dnf install nss-mdns avahi
```

---

#### Ubuntu / Debian

```bash id="7dwmdo"
sudo apt install avahi-daemon libnss-mdns
```

---

### Start the Avahi Service

```bash id="x2w8cx"
sudo systemctl enable --now avahi-daemon
```

---

### Check Service Status

```bash id="qfjlwm"
systemctl status avahi-daemon
```

---

## Windows

* Windows supports some mDNS features.
* Support is more limited compared to macOS and Linux.

---

# Practical Example

Suppose a Raspberry Pi exists on the network.

Instead of using:

```text id="jlwm44"
192.168.1.50
```

we can access it using:

```bash id="v8jwwm"
ping raspberrypi.local
```

or:

```bash id="sxv1p9"
ssh pi@raspberrypi.local
```

This is extremely useful for:

* IoT devices
* Home labs
* Smart home systems
* Embedded systems
* Raspberry Pi projects

---

# Packet Analysis with Wireshark

## Capturing mDNS Traffic

### Generate Traffic

```bash id="jlwm81"
ping raspberrypi.local
```

---

### Wireshark Filter

```text id="jlwm88"
mdns
```

or:

```text id="7o6z91"
udp.port == 5353
```

---

# Important mDNS Details

## Default Port

```text id="jlwm95"
UDP 5353
```

---

## Multicast Address

### IPv4

```text id="jlwm99"
224.0.0.251
```

---

### IPv6

```text id="fdz1tt"
ff02::fb
```

---

# Real-World Relevance

mDNS is heavily used in:

* Smart home systems
* IoT devices
* Printers
* Apple AirDrop
* Chromecast
* Raspberry Pi projects
* Home Assistant
* Embedded Linux systems

---

# Important Limitation

mDNS generally works only:

* Inside the same local network or broadcast domain
* Not across the public internet

Routers usually do not forward multicast mDNS traffic between networks.

---

# Important Concept

### Traditional DNS

* "Ask the DNS server."

### mDNS

* "Ask everyone on the local network."
