# 305. Understanding Layer 2 Hardware: Bridges, Switches and Wireless Access Points

# Layer 2 hardware

The Data Link Layer operates primarily with:

* bridges
* switches
* wireless access points

These devices work mainly using:

```text
MAC addresses
```

rather than IP addresses.

---

# bridge

## definition

A bridge is a Layer 2 device that:

```text
connects multiple network segments together
```

and forwards frames based on MAC addresses.

---

# purpose

A bridge learns:

* which MAC addresses exist on which network segment

and forwards frames only where needed.

This reduces unnecessary traffic.

---

# example

Without a bridge:

```text
Network A <------> Network B
```

all traffic might be visible everywhere.

With a bridge:

```text
only relevant traffic is forwarded
```

between segments.

---

# bridge vs switch

Both perform nearly identical functions.

Both:

* operate mainly at Layer 2
* learn MAC addresses
* forward Ethernet frames

---

# difference

Historically:

| Bridge            | Switch            |
| ----------------- | ----------------- |
| software-oriented | hardware-oriented |
| fewer ports       | many ports        |
| older technology  | modern technology |

Today:

```text
the distinction is mostly historical
```

Most switches effectively perform bridging internally.

---

# switch (Ethernet)

## definition

A switch is:

```text
a Layer 2 device that forwards Ethernet frames between devices
```

using MAC addresses.

---

# how it works

Suppose:

```text
PC1
PC2
PC3
PC4
```

connected to a switch.

The switch builds a table:

| MAC Address | Port   |
| ----------- | ------ |
| AA:AA       | Port 1 |
| BB:BB       | Port 2 |
| CC:CC       | Port 3 |

called:

```text
MAC address table
```

or:

```text
CAM table
```

---

# forwarding example

PC1 sends frame to:

```text
BB:BB:BB:BB:BB:BB
```

Switch checks table:

```text
BB:BB → Port 2
```

and forwards frame only to:

```text
Port 2
```

instead of sending it everywhere.

---

# benefit

Improves:

* bandwidth utilization
* performance
* scalability

---

# Layer 3 switches

Some modern switches can also perform:

* routing
* VLAN routing
* inter-network communication

These are called:

```text
Layer 3 switches
```

because they understand:

```text
IP addresses
```

in addition to MAC addresses.

---

# wireless access point (WAP)

## definition

A wireless access point provides:

```text
communication between Ethernet and Wi-Fi networks
```

---

# purpose

Converts:

```text
Ethernet frames
```

into:

```text
Wi-Fi frames
```

and vice versa.

---

# example

```text
Laptop (Wi-Fi)
      |
      |
   Access Point
      |
      |
Ethernet Network
```

---

# compatibility

Although Ethernet and Wi-Fi use different frame formats:

```text
both use MAC addresses
```

which makes conversion practical.

---

# Ethernet splitter / hub concept

Historically networks often used:

```text
hubs
```

instead of switches.

---

# how a hub works

Every device shares:

```text
the same communication medium
```

Example:

```text
PC1
  |
Hub
 /|\
PC2 PC3 PC4
```

---

# behavior

When PC1 transmits:

```text
all devices receive the signal
```

including:

* PC2
* PC3
* PC4

---

# frame filtering

Even though all devices receive the frame:

```text
only the intended destination processes it
```

because it recognizes its MAC address.

Other devices ignore it.

---

# problem: collisions

A collision occurs when:

```text
two devices transmit simultaneously
```

on the same shared medium.

---

# example

PC1:

```text
sending data
```

at same time as:

PC2:

```text
sending data
```

Both signals overlap:

```text
collision
```

Data becomes corrupted.

---

# consequence

Devices must:

* stop transmission
* wait random interval
* retransmit

Reducing efficiency.

---

# collision domain

A hub creates:

```text
one large collision domain
```

Meaning:

* every device competes for same medium

---

# solution: switches

Switches eliminate most collisions by:

```text
giving each port its own communication path
```

---

# example

Instead of:

```text
all devices sharing one cable
```

each device effectively gets:

```text
dedicated connection to switch
```

---

# result

Multiple devices can communicate simultaneously:

* PC1 ↔ PC2
* PC3 ↔ PC4

without interfering.

---

# important observation

To connected computers:

```text
switch operation is mostly transparent
```

Devices simply send Ethernet frames.

The switch handles forwarding automatically.

---

# comparison

| Device         | Layer | Main Function                |
| -------------- | ----- | ---------------------------- |
| Hub            | 1     | repeat signals               |
| Bridge         | 2     | forward frames               |
| Switch         | 2     | intelligent frame forwarding |
| Layer 3 Switch | 2/3   | switching + routing          |
| Access Point   | 2     | Ethernet ↔ Wi-Fi conversion  |

---

# packet journey example

```text
PC
 ↓
Switch
 ↓
Access Point
 ↓
Wi-Fi Client
```

Layer 2 devices forward frames using:

```text
MAC addresses
```

while higher layers continue carrying:

* IP packets
* TCP segments
* application data

unchanged.

---

# TL;DR

Layer 2 devices use MAC addresses to move frames through a local network.

* Bridges connect network segments.
* Switches intelligently forward frames and prevent collisions.
* Wireless access points translate between Ethernet and Wi-Fi.
* Hubs repeat all traffic and suffer from collisions.
* Modern networks primarily use switches rather than hubs.
