# 302. OSI Layer 1: The Physical Layer

## Physical Layer (Layer 1)

The Physical Layer is:

```text
the lowest layer of the OSI model
```

It is responsible for:

```text
transmitting raw bits between devices through a physical medium
```

At this layer, data is simply:

```text
0s and 1s
```

without any knowledge of:

* IP addresses
* MAC addresses
* TCP
* HTTP
* applications

---

# physical medium

The Physical Layer defines how bits travel through a communication channel.

Examples:

## Copper cables

Examples:

* Ethernet cables (Cat5e, Cat6, Cat7)
* telephone cables

Transmission method:

* electrical signals

---

## Fiber-optic cables

Transmission method:

* pulses of light

Advantages:

* very high bandwidth
* long-distance transmission
* resistance to electromagnetic interference

Commonly used in:

* ISPs
* data centers
* backbone internet connections

---

## Wireless communication

Examples:

* Wi-Fi
* Bluetooth
* cellular networks (4G, 5G)

Transmission method:

* radio waves

---

# data transmission

Computers work with:

```text
digital data
```

The Physical Layer converts digital information into physical signals.

Examples:

| Medium         | Signal Type        |
| -------------- | ------------------ |
| Ethernet cable | electrical voltage |
| Fiber optic    | light pulses       |
| Wi-Fi          | radio waves        |

---

# example

Binary data:

```text
10110010
```

may become:

```text
high voltage
low voltage
high voltage
high voltage
...
```

or:

```text
light on
light off
light on
...
```

depending on transmission medium.

---

# signalling

The Physical Layer defines:

## voltage levels

Example:

```text
0 = 0 volts
1 = 5 volts
```

(or other electrical standards)

---

## modulation

For wireless communication:

```text
digital information
→ radio signal
```

Modulation techniques include:

* AM
* FM
* QAM
* OFDM

Modern Wi-Fi uses advanced modulation schemes.

---

## synchronization

Sender and receiver must agree on:

* timing
* clock rate
* bit boundaries

Otherwise:

```text
10110010
```

could be interpreted incorrectly.

---

# error detection

Physical transmission is not perfect.

Possible problems:

* electrical noise
* weak wireless signal
* damaged cable
* interference

---

## basic error detection

Some technologies use mechanisms such as:

* parity bits
* checksums
* CRC (Cyclic Redundancy Check)

to detect transmission errors.

---

# examples of Layer 1 devices

## Network cable

Examples:

```text
Cat5e
Cat6
Cat6a
Cat7
```

---

## Fiber optic cable

Used for:

* internet backbone
* ISP infrastructure
* data centers

---

## Network interface card (NIC)

Examples:

```text
eth0
enp0s3
wlp2s0
```

Responsible for:

* sending/receiving signals

---

## Hub

Legacy Layer 1 device.

Function:

```text
repeat incoming signal to all ports
```

Rarely used today.

---

## Repeater

Used to:

```text
amplify and regenerate signals
```

for longer distances.

---

# what Layer 1 does NOT know

The Physical Layer does NOT understand:

* websites
* DNS
* IP addresses
* ports
* TCP connections
* files
* applications

It only sees:

```text
electrical, optical, or radio signals
```

---

# example: opening google.com

When visiting:

```text
https://google.com
```

Layer 1 only handles:

```text
transmitting bits through cable, fiber, or Wi-Fi
```

It does not know:

* destination website
* HTTP request
* DNS lookup

Those belong to higher layers.

---

# troubleshooting Layer 1 problems

Typical symptoms:

* cable unplugged
* damaged cable
* weak Wi-Fi signal
* disconnected antenna
* faulty network card
* fiber cut
* switch power failure

---

# Linux commands related to Layer 1

Show interfaces:

```bash
ip link show
```

Show link status:

```bash
ethtool enp0s3
```

Monitor interface state:

```bash
ip addr show
```

---

# TL;DR

The Physical Layer (Layer 1):

* provides the physical connection
* transmits raw bits
* converts digital data into physical signals
* uses cables, fiber, or radio waves
* handles signalling and synchronization
* performs basic error detection

After Layer 1 is available:

```text
devices can physically exchange bits
```

Higher OSI layers then build communication protocols on top of this physical connection.
