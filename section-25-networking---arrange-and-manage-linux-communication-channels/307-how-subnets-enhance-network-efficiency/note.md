## 307. How Subnets enhance Network Efficiency

### Important clarification: a subnet is not simply "a network within a network"

That definition is common for beginners, but technically:

A subnet is:

```text
a portion of an IP network defined by a subnet mask (or prefix length)
```

Examples:

```text
192.168.1.0/24
192.168.2.0/24
10.0.0.0/8
```

Each of these represents a different subnet.

---

### Why do we need subnets?

Without subnets, every device would think:

```text
every other IP address is directly reachable
```

and would constantly broadcast ARP requests.

This becomes inefficient in large networks.

Example:

```text
5000 computers in one giant LAN
```

Problems:

* huge broadcast traffic
* larger ARP tables
* reduced performance
* harder administration

Therefore networks are split into smaller subnets.

---

### The real question a host asks

When sending a packet, the host must answer:

```text
Is the destination inside my subnet?
```

If YES:

```text
send directly to destination MAC
```

If NO:

```text
send to default gateway (router)
```

The subnet mask allows the host to make this decision.

---

### Example

Your machine:

```text
IP Address : 192.168.1.100
Subnet Mask: 255.255.255.0
```

Equivalent CIDR notation:

```text
192.168.1.100/24
```

Network portion:

```text
192.168.1
```

Host portion:

```text
100
```

---

### Case 1: local destination

Destination:

```text
192.168.1.50
```

Both addresses belong to:

```text
192.168.1.0/24
```

Therefore:

```text
same subnet
```

The computer:

1. Uses ARP to discover MAC address of 192.168.1.50
2. Creates Ethernet frame
3. Sends directly

Router is not involved.

---

### Case 2: Internet destination

Destination:

```text
8.8.8.8
```

Different network.

Therefore:

```text
not in local subnet
```

The computer sends the Ethernet frame to:

```text
default gateway
```

For example:

```text
192.168.1.1
```

Router MAC becomes:

```text
Destination MAC
```

inside Ethernet frame.

---

### Why WiFi ↔ Ethernet communication still works directly

The course correctly notes:

> even if one device uses WiFi and another uses Ethernet

Example:

```text
PC (Ethernet)
      |
   Router/AP
      |
Laptop (WiFi)
```

Both devices belong to:

```text
192.168.1.0/24
```

The wireless access point internally bridges Layer-2 traffic.

Result:

```text
same subnet
```

Communication remains direct.

No Layer-3 routing is required.

Only frame forwarding inside the LAN occurs.

---

### How the subnet mask works mathematically

Example:

```text
IP:   192.168.1.100
Mask: 255.255.255.0
```

Binary:

```text
IP
11000000.10101000.00000001.01100100

MASK
11111111.11111111.11111111.00000000
```

The mask tells us:

```text
first 24 bits = network
last 8 bits = host
```

Therefore:

```text
Network Address
192.168.1.0
```

Hosts inside subnet:

```text
192.168.1.1
...
192.168.1.254
```

---

### What happens in Wireshark

When pinging a local machine:

```text
ping 192.168.1.50
```

Ethernet frame:

```text
Destination MAC = MAC of 192.168.1.50
```

IP packet:

```text
Destination IP = 192.168.1.50
```

---

When pinging Google:

```text
ping google.com
```

Ethernet frame:

```text
Destination MAC = Router MAC
```

IP packet:

```text
Destination IP = Google's IP
```

This is one of the clearest demonstrations of the difference between:

* Layer 2 addressing (MAC)
* Layer 3 addressing (IP)

The IP destination remains Google, but the Ethernet destination becomes the next hop (the router).
