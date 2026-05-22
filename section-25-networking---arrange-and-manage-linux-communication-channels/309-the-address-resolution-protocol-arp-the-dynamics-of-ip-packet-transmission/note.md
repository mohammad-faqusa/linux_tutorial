# 309. The Address Resolution Protocol (ARP): Dynamics of IP Packet Transmission

## Practice

Generate local network traffic:

```bash
ping raspberrypi.local
```

or

```bash
ping 192.168.1.x
```

Then:

* Open Wireshark
* Start capturing on the active network interface
* Pause the capture after a few seconds
* Filter packets using:

```text
arp
```

---

# ARP in a Local Network

Suppose:

```text
My IP:      192.168.1.10
Target IP:  192.168.1.20
```

Before sending data, the sender must discover:

```text
Which MAC address belongs to 192.168.1.20?
```

---

## Step 1: ARP Request (Broadcast)

The sender broadcasts:

```text
Who has 192.168.1.20?
Tell 192.168.1.10
```

Destination MAC:

```text
FF:FF:FF:FF:FF:FF
```

This frame is received by every device on the local network.

---

## Step 2: Devices Check the Request

Each device verifies:

```text
Is 192.168.1.20 my IP address?
```

Most devices ignore the request.

Only the owner of:

```text
192.168.1.20
```

responds.

---

## Step 3: ARP Reply

The target device sends:

```text
192.168.1.20 is at AA:BB:CC:DD:EE:FF
```

The reply contains:

* IP address
* MAC address

The sender now knows which MAC address should receive the Ethernet frame.

---

## Step 4: Store in ARP Cache

The operating system stores:

```text
192.168.1.20 → AA:BB:CC:DD:EE:FF
```

Future packets can be sent immediately without another ARP request.

---

# What You Will See in Wireshark

Filter:

```text
arp
```

Typical request:

```text
Who has 192.168.1.20?
Tell 192.168.1.10
```

Typical reply:

```text
192.168.1.20 is at AA:BB:CC:DD:EE:FF
```

This shows:

```text
IP address ↔ MAC address mapping
```

---

# Communication Outside the Local Network

Suppose:

```text
My IP:      192.168.1.10/24
Destination: 8.8.8.8
```

The destination is outside the local subnet.

Therefore:

```text
The packet cannot be sent directly to 8.8.8.8
```

---

## Step 1: Determine the Gateway

Example routing table:

```text
Default Gateway: 192.168.1.1
```

The computer decides:

```text
Send the packet to the router
```

---

## Step 2: ARP for the Gateway

The computer does NOT search for:

```text
8.8.8.8
```

Instead it searches for:

```text
192.168.1.1
```

(the gateway).

Broadcast request:

```text
Who has 192.168.1.1?
Tell 192.168.1.10
```

---

## Step 3: Router Replies

Example:

```text
192.168.1.1 is at 11:22:33:44:55:66
```

---

## Step 4: Send Ethernet Frame

Ethernet frame:

```text
Destination MAC:
11:22:33:44:55:66

Payload:
IP packet destined for 8.8.8.8
```

Notice:

* Layer 2 destination = Router MAC
* Layer 3 destination = 8.8.8.8

---

## Step 5: Router Forwards Packet

The router:

* receives the frame
* extracts the IP packet
* checks the destination IP
* forwards the packet toward the Internet

This process repeats through multiple routers until the packet reaches the destination.

---

# Important Distinction

When sending to a host in the same subnet:

```text
ARP resolves the target device's MAC address
```

When sending outside the subnet:

```text
ARP resolves the gateway's MAC address
```

NOT the remote host's MAC address.

Your computer never learns the MAC address of:

```text
8.8.8.8
```

because MAC addresses are only meaningful inside the local Layer 2 network.

---

# Example Summary

### Local Device

```text
192.168.1.10 → 192.168.1.20

ARP:
Who has 192.168.1.20?

Reply:
192.168.1.20 is at AA:BB:CC:DD:EE:FF

Frame sent directly to target.
```

### Internet Host

```text
192.168.1.10 → 8.8.8.8

ARP:
Who has 192.168.1.1?

Reply:
192.168.1.1 is at 11:22:33:44:55:66

Frame sent to router.
Router forwards packet to Internet.
```

---

# Useful Commands

Show ARP cache:

```bash
ip neigh
```

Show interfaces and MAC addresses:

```bash
ip addr show
```

Show routing table:

```bash
ip route
```

Generate ARP traffic:

```bash
ping <local-ip>
```

Wireshark filter:

```text
arp
```
