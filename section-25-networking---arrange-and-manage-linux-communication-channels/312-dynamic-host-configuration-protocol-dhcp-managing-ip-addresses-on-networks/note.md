# 312. Dynamic Host Configuration Protocol (DHCP): Managing IP Addresses on Networks

## What is DHCP?

**DHCP (Dynamic Host Configuration Protocol)** is a network management protocol that automatically provides network configuration to devices.

Without DHCP, every device would need manual configuration of:

* IP address
* Subnet mask
* Default gateway
* DNS servers

DHCP automates this process.

---

# Purpose of DHCP

DHCP allows devices to automatically obtain:

```text
IP address
Subnet mask
Default gateway
DNS servers
Lease duration
```

This enables devices to join a network with minimal configuration.

---

# DHCP Components

## DHCP Server

Responsibilities:

* Maintains a pool of available IP addresses
* Assigns addresses to clients
* Tracks lease durations
* Reclaims expired addresses
* Provides additional network configuration

In most home networks:

```text
Router = DHCP Server
```

---

## DHCP Client

Responsibilities:

* Requests network configuration
* Accepts offered addresses
* Renews leases before expiration
* Releases addresses when necessary

Examples:

* Linux
* Windows
* macOS
* Smartphones
* Raspberry Pi

---

## DHCP Relay Agent (Optional)

Used in larger networks.

Responsibilities:

* Forwards DHCP messages between subnets
* Allows one DHCP server to serve multiple networks

Common in:

* Enterprise networks
* Universities
* Data centers

---

# DHCP and the OSI Model

DHCP configures:

```text
Layer 3 (IP configuration)
```

However DHCP itself operates using:

```text
UDP
```

which belongs to:

```text
Layer 4 (Transport Layer)
```

Common ports:

| Port   | Purpose     |
| ------ | ----------- |
| UDP 67 | DHCP Server |
| UDP 68 | DHCP Client |

---

# DHCP Lease

A DHCP address assignment is called a:

```text
Lease
```

Example:

```text
IP Address : 192.168.1.120
Lease Time : 24 hours
```

The address belongs to the client temporarily.

Before expiration:

```text
client renews lease
```

---

# DHCP Process (DORA)

The DHCP exchange is commonly called:

```text
DORA
```

| Step | Meaning     |
| ---- | ----------- |
| D    | Discover    |
| O    | Offer       |
| R    | Request     |
| A    | Acknowledge |

---

# 1. Discover

The client has no IP address yet.

It broadcasts:

```text
DHCP Discover
```

Destination:

```text
255.255.255.255
```

Broadcast means:

```text
send to entire local network
```

Purpose:

```text
Find available DHCP servers
```

---

# 2. Offer

A DHCP server responds with:

```text
DHCP Offer
```

Example:

```text
IP Address: 192.168.1.120
Subnet Mask: 255.255.255.0
Gateway: 192.168.1.1
Lease: 24 hours
```

The server is effectively saying:

```text
Would you like this address?
```

---

# 3. Request

The client accepts the offer by sending:

```text
DHCP Request
```

Meaning:

```text
I want to use the offered address.
```

---

# 4. Acknowledge (ACK)

The server confirms:

```text
DHCP ACK
```

The client may now use:

```text
192.168.1.120
```

for normal communication.

---

# DHCP Sequence Diagram

```text
Client                           DHCP Server

Discover  --------------------->

            <------------------- Offer

Request   --------------------->

            <------------------- ACK
```

---

# Why Only DHCP Request + ACK Appeared?

Example:

```bash
sudo ip link set enp0s5 down
sudo ip link set enp0s5 up
```

In Wireshark you may observe only:

```text
DHCP Request
DHCP ACK
```

instead of all four steps.

---

# Explanation

The client already remembers:

```text
previously assigned IP address
```

and knows:

```text
which DHCP server granted it
```

Therefore it attempts:

```text
lease renewal
```

rather than a complete discovery process.

---

# Renewal Process

Instead of:

```text
Discover
Offer
Request
ACK
```

the client sends:

```text
Request
```

asking:

```text
Can I continue using my previous address?
```

The server replies:

```text
ACK
```

and the lease continues.

---

# Observing DHCP in Wireshark

Capture on the active interface.

Filter:

```text
dhcp
```

or

```text
bootp
```

(Wireshark historically labels DHCP packets as BOOTP).

Typical packets:

```text
DHCP Discover
DHCP Offer
DHCP Request
DHCP ACK
```

---

# Viewing DHCP Information on Linux

Show current IP:

```bash
ip addr show
```

---

Show routing information:

```bash
ip route
```

---

Show DNS configuration:

```bash
resolvectl status
```

or

```bash
cat /etc/resolv.conf
```

---

# Renew DHCP Lease

Using NetworkManager:

```bash
sudo dhclient -r
sudo dhclient
```

or reconnect the interface:

```bash
sudo ip link set enp0s5 down
sudo ip link set enp0s5 up
```

---

# Example Home Network

Router:

```text
192.168.1.1
```

DHCP Pool:

```text
192.168.1.100 - 192.168.1.200
```

Laptop joins network:

```text
Discover
Offer 192.168.1.120
Request
ACK
```

Result:

```text
Laptop IP: 192.168.1.120
Subnet: 255.255.255.0
Gateway: 192.168.1.1
DNS: Router or ISP DNS
```

---

# Advantages of DHCP

* Automatic configuration
* Prevents manual errors
* Centralized management
* Easy device replacement
* Supports dynamic environments
* Reduces administrative effort

---

# Useful Commands

Show addresses:

```bash
ip addr show
```

Show routes:

```bash
ip route
```

Release lease:

```bash
sudo dhclient -r
```

Request new lease:

```bash
sudo dhclient
```

Monitor DHCP traffic:

```text
Wireshark filter:
dhcp
```

or

```text
bootp
```

---

# TL;DR

DHCP automatically provides:

* IP address
* subnet mask
* default gateway
* DNS servers

The normal exchange is:

```text
Discover
Offer
Request
ACK
```

When reconnecting an interface quickly, the client often remembers its previous lease and performs only:

```text
Request
ACK
```

which is why Wireshark may show only two DHCP packets instead of the full four-step process.
