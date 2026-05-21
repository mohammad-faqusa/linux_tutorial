# 304. OSI Layer 2: The Data Link Layer

## overview

After Layer 1 provides a physical connection:

```text
bits can travel between devices
```

However, Layer 1 alone cannot answer:

* Who should receive the data?
* How are errors detected?
* How are devices identified?
* How is data organized?
* How is congestion handled?

These responsibilities belong to:

```text
Layer 2 — The Data Link Layer
```

---

# data units: frames

Layer 2 sends data in units called:

```text
frames
```

A frame is a structured container that carries:

* payload data
* source MAC address
* destination MAC address
* error-checking information
* protocol metadata

---

# frame size

Frame size depends on the protocol.

Examples:

| Protocol | Typical Maximum Frame Size |
| -------- | -------------------------- |
| Ethernet | ~1500 bytes payload (MTU)  |
| Wi-Fi    | varies by standard         |

---

# responsibilities of Layer 2

The Data Link Layer provides:

```text
reliable communication between devices on the same local network
```

---

## error detection

Layer 2 detects transmission errors.

Examples:

* electrical noise
* corrupted bits
* wireless interference

Typically performed using:

```text
CRC (Cyclic Redundancy Check)
```

or similar checksum mechanisms.

---

## device identification

Layer 2 identifies devices using:

```text
MAC addresses
```

Every frame contains:

* source MAC address
* destination MAC address

allowing devices to determine:

```text
who sent the frame
who should receive the frame
```

---

## flow control

Layer 2 may implement mechanisms that prevent:

```text
fast sender overwhelming slow receiver
```

depending on protocol and hardware.

---

## frame encapsulation

Layer 2 organizes transmitted information into:

```text
frames
```

Before transmission it adds:

* source MAC address
* destination MAC address
* control information
* error detection fields

This process is called:

```text
encapsulation
```

---

# Layer 2 sublayers

Traditionally Layer 2 is divided into:

## Logical Link Control (LLC)

Responsibilities:

* flow control
* error detection
* interface to Layer 3

Provides communication services to higher layers.

---

## Media Access Control (MAC)

Responsibilities:

* addressing
* frame delivery
* media access

Uses:

```text
MAC addresses
```

to identify devices on the local network.

---

# common Layer 2 technologies

## Ethernet (IEEE 802.3)

Most common wired LAN technology.

---

## Wi-Fi (IEEE 802.11)

Most common wireless LAN technology.

---

# Ethernet (IEEE 802.3)

## definition

Ethernet is:

```text
a family of wired networking technologies
```

primarily used in:

```text
Local Area Networks (LANs)
```

---

# characteristics

Originally developed:

```text
1970s
```

Today it remains the dominant wired networking technology.

---

# Ethernet frame

An Ethernet frame typically contains:

| Component       | Purpose                 |
| --------------- | ----------------------- |
| Destination MAC | receiver                |
| Source MAC      | sender                  |
| EtherType       | protocol identification |
| Payload         | actual data             |
| CRC/FCS         | error detection         |

---

# Ethernet frame size

Typical maximum payload:

```text
1500 bytes
```

commonly called:

```text
MTU (Maximum Transmission Unit)
```

---

# addressing example

Source:

```text
AA:BB:CC:DD:EE:FF
```

Destination:

```text
11:22:33:44:55:66
```

These addresses appear directly inside the Ethernet frame.

---

# Wi-Fi (IEEE 802.11)

## definition

Wi-Fi is:

```text
a wireless networking protocol
```

using radio waves instead of cables.

---

# relationship with Ethernet

Wi-Fi and Ethernet are different Layer 2 technologies.

However:

```text
both use MAC addressing
```

and are designed to interoperate.

---

# wireless access point

A wireless access point often performs conversion between:

```text
Wi-Fi frames
```

and

```text
Ethernet frames
```

allowing wireless devices to communicate with wired networks.

---

# Wi-Fi frames

Wi-Fi frames contain additional information compared to Ethernet:

Examples:

* signal management
* wireless authentication
* association information
* radio control fields

because wireless communication is more complex than cable communication.

---

# MAC address

## definition

MAC stands for:

```text
Media Access Control
```

A MAC address is:

```text
a unique identifier assigned to a network interface
```

---

# size

Standard MAC address:

```text
48 bits
```

or:

```text
6 bytes
```

---

# format

Example:

```text
01:23:45:67:89:AB
```

Six groups:

```text
2 hexadecimal digits
```

separated by colons.

---

# manufacturer assignment

Structure:

| Part          | Purpose            |
| ------------- | ------------------ |
| First 3 bytes | Manufacturer (OUI) |
| Last 3 bytes  | Device identifier  |

---

# OUI

OUI means:

```text
Organizationally Unique Identifier
```

Identifies manufacturer.

Example:

```text
00:1A:2B
```

may belong to a specific vendor.

---

# device identifier

Remaining bytes identify:

```text
specific device produced by that manufacturer
```

---

# MAC address example

```text
00:1A:2B:45:67:89
```

* OUI:

```text
00:1A:2B
```

* Device portion:

```text
45:67:89
```

---

# MAC spoofing

Although MAC addresses are assigned by manufacturers:

```text
they can be changed in software
```

This process is called:

```text
MAC spoofing
```

Common uses:

* privacy
* testing
* virtualization
* security research

---

# viewing MAC addresses

Display interfaces and MAC addresses:

```bash
ip addr show
```

Example output:

```text
2: enp0s3:
    link/ether 08:00:27:aa:bb:cc
```

The value after:

```text
link/ether
```

is the MAC address.

---

# practical Wireshark example

Generate traffic:

```bash
ping google.com
```

---

# capture packets

Open:

```text
Wireshark
```

Select active network interface.

---

# filter ICMP traffic

Filter:

```text
icmp
```

Shows ping requests and replies.

---

# inspect packet

Select packet:

```text
Frame 13
```

Expand:

```text
Ethernet II
```

---

# information visible

Example:

```text
Destination: xx:xx:xx:xx:xx:xx
Source: yy:yy:yy:yy:yy:yy
```

---

# Ethernet frame structure

Conceptually:

```text
+---------------------+
| Destination MAC     |
+---------------------+
| Source MAC          |
+---------------------+
| Protocol Identifier |
+---------------------+
| Payload Data        |
+---------------------+
| CRC/FCS             |
+---------------------+
```

---

# packet journey example

Suppose:

```text
ping google.com
```

1. Computer creates ICMP packet.
2. Layer 3 adds IP information.
3. Layer 2 encapsulates packet into Ethernet frame.
4. Source and destination MAC addresses added.
5. Frame transmitted through cable or Wi-Fi.
6. Switch/router receives frame.
7. Frame forwarded toward destination.

---

# key distinction

| Layer   | Address Type |
| ------- | ------------ |
| Layer 2 | MAC Address  |
| Layer 3 | IP Address   |

Examples:

Layer 2:

```text
08:00:27:AA:BB:CC
```

Layer 3:

```text
192.168.1.10
```

Both appear in network communication but serve different purposes.

---

# TL;DR

Layer 2 (Data Link Layer):

* provides communication between devices on the same network
* sends data as frames
* uses MAC addresses for identification
* performs error detection
* handles frame encapsulation
* includes technologies such as Ethernet and Wi-Fi
* acts as the bridge between the Physical Layer and the Network Layer (IP)
