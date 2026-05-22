# 308. What are Subnet Masks and How Do They Work?

## purpose of a subnet mask

A subnet mask determines:

```text
which part of an IP address identifies the network
which part identifies the host
```

It allows a device to decide:

* Is the destination on my local network?
* Or must I send the packet to the router (gateway)?

---

# example

Suppose our computer has:

```text
IP Address : 192.168.1.2
Subnet Mask: 255.255.255.0
```

or equivalently:

```text
192.168.1.2/24
```

---

# why the subnet mask matters

When sending a packet to:

```text
192.168.1.3
```

the computer must determine:

```text
Is 192.168.1.3 in my local network?
```

To answer this, it performs:

```text
IP Address AND Subnet Mask
Destination IP AND Subnet Mask
```

---

# example calculation

## our IP

```text
192.168.1.2
AND
255.255.255.0
=
192.168.1.0
```

---

## destination IP

```text
192.168.1.3
AND
255.255.255.0
=
192.168.1.0
```

---

# result

Both produce:

```text
192.168.1.0
```

Therefore:

```text
both addresses belong to the same network
```

The packet can be sent directly on the local network.

No router required.

---

# another example

Suppose:

```text
Our IP       : 192.168.1.2/24
Destination  : 8.8.8.8
```

---

## our network

```text
192.168.1.2
AND
255.255.255.0
=
192.168.1.0
```

---

## destination network

```text
8.8.8.8
AND
255.255.255.0
=
8.8.8.0
```

---

# result

Networks differ:

```text
192.168.1.0
≠
8.8.8.0
```

Therefore:

```text
destination is outside our local network
```

The packet must be sent to:

```text
default gateway (router)
```

which forwards it toward the Internet.

---

# subnet masks in binary

Subnet masks consist of:

```text
continuous 1s followed by continuous 0s
```

Example:

```text
255.255.255.0
```

Binary form:

```text
11111111.11111111.11111111.00000000
```

---

# meaning

| Bit Value | Meaning         |
| --------- | --------------- |
| 1         | Network portion |
| 0         | Host portion    |

---

# CIDR notation

Instead of writing:

```text
255.255.255.0
```

we usually write:

```text
/24
```

because there are:

```text
24 network bits
```

---

# common subnet masks

| CIDR | Subnet Mask     |
| ---- | --------------- |
| /8   | 255.0.0.0       |
| /16  | 255.255.0.0     |
| /24  | 255.255.255.0   |
| /25  | 255.255.255.128 |
| /26  | 255.255.255.192 |
| /27  | 255.255.255.224 |
| /28  | 255.255.255.240 |

---

# example: /24 network

Suppose:

```text
192.168.1.3/24
```

Network address:

```text
192.168.1.0
```

Subnet mask:

```text
255.255.255.0
```

---

# usable host range

Hosts may use:

```text
192.168.1.1
through
192.168.1.254
```

---

# reserved addresses

## network address

```text
192.168.1.0
```

Identifies the network itself.

Cannot be assigned to a device.

---

## broadcast address

```text
192.168.1.255
```

Used to send traffic to all hosts in the subnet.

Cannot be assigned to a device.

---

# visualization

```text
Network:
192.168.1.0/24

Network Address : 192.168.1.0
First Host      : 192.168.1.1
Last Host       : 192.168.1.254
Broadcast       : 192.168.1.255
```

---

# practical decision process

Suppose:

```text
My IP: 192.168.1.16/24
```

Destination:

```text
192.168.1.50
```

Network comparison:

```text
192.168.1.0
=
192.168.1.0
```

Result:

```text
send directly
```

---

Destination:

```text
8.8.8.8
```

Network comparison:

```text
192.168.1.0
≠
8.8.8.0
```

Result:

```text
send to gateway
```

---

# inspecting subnet information

Show interfaces and subnet masks:

```bash
ip addr show
```

or:

```bash
ip a
```

Example output:

```text
inet 192.168.1.16/24
```

Meaning:

```text
IP Address : 192.168.1.16
Subnet Mask: 255.255.255.0
```

---

# useful examples

```text
192.168.1.10/24
Subnet mask = 255.255.255.0
```

```text
10.0.0.5/8
Subnet mask = 255.0.0.0
```

```text
172.16.10.20/16
Subnet mask = 255.255.0.0
```

---

# TL;DR

A subnet mask:

* separates network bits from host bits
* determines whether a destination is local or remote
* allows hosts to decide whether to:

  * send directly to another device
  * send through the default gateway

Example:

```text
192.168.1.2/24
```

means:

```text
IP Address : 192.168.1.2
Subnet Mask: 255.255.255.0
Network    : 192.168.1.0
```

Hosts in the same `/24` network communicate directly; all other destinations are forwarded to the router.
