### Important clarifications

#### Layer 2 vs Layer 3

The statement:

> on layer 2, we could only send frames from one computer directly to another one

is slightly simplified.

More accurately:

* Layer 2 communication is limited to a **single LAN / broadcast domain**.
* Devices use **MAC addresses** to deliver frames.
* Switches can forward frames across the LAN.
* Once the destination is outside the LAN, Layer 2 alone is insufficient.

Example:

```text
PC A (192.168.1.10)
        |
      Switch
        |
PC B (192.168.1.20)
```

Layer 2 communication is enough.

But:

```text
PC A (192.168.1.10)
        |
      Router
        |
Internet
        |
Google Server
```

Google is outside the local network.

Layer 2 cannot reach it directly.

Layer 3 routing becomes necessary.

---

#### What is routing?

Routing means:

```text
choosing the next network hop toward the destination
```

A router examines the destination IP address and decides where to forward the packet.

Example:

```text
PC -> Home Router -> ISP Router -> ISP Router -> Google
```

Each router forwards the packet closer to the destination.

---

#### Why do we need IP addresses?

MAC addresses only have local significance.

Example:

```text
08:00:27:AA:BB:CC
```

A router on another continent has no idea where that device is located.

IP addresses solve this problem.

Example:

```text
192.168.1.100
8.8.8.8
142.250.x.x
```

They provide a hierarchical addressing scheme that routers can use for forwarding decisions.

---

#### Frames vs Packets

The course says:

> we send packets, which are wrapped into frames at each step

This is one of the most important networking concepts.

Example:

```text
Application Data
      ↓
TCP Segment
      ↓
IP Packet
      ↓
Ethernet Frame
```

The frame only exists on the current network link.

When a router receives it:

```text
[Ethernet Frame]
      ↓
Router removes frame
      ↓
IP Packet remains
      ↓
Creates NEW frame
      ↓
Forwards packet
```

Therefore:

* IP packet usually remains the same during forwarding.
* Ethernet frame changes at every hop.

---

#### Why does the destination MAC become the router?

When you run:

```bash
ping google.com
```

your machine eventually discovers Google's IP.

Suppose:

```text
Google IP = 142.250.x.x
```

Your PC realizes:

```text
142.250.x.x is not in my LAN
```

Therefore:

```text
send packet to default gateway
```

Usually:

```text
192.168.1.1
```

(the home router).

Result:

IP packet:

```text
Source IP      = 192.168.1.100
Destination IP = 142.250.x.x
```

Ethernet frame:

```text
Source MAC      = Your NIC
Destination MAC = Router MAC
```

Notice:

* IP destination = Google
* MAC destination = Router

because the router is the next hop.

---

#### What does `ip route show` actually display?

Example:

```bash
ip route show
```

Output:

```text
default via 192.168.1.1 dev wlp2s0
192.168.1.0/24 dev wlp2s0 proto kernel scope link
```

Meaning:

##### Local network

```text
192.168.1.0/24
```

can be reached directly through:

```text
wlp2s0
```

##### Everything else

```text
default via 192.168.1.1
```

means:

```text
If no more specific route exists,
send packet to router 192.168.1.1
```

This route is called:

```text
default route
```

or

```text
default gateway
```

---

#### LAN vs WAN

LAN:

```text
Home network
Office network
University network
```

Usually:

* low latency
* high speed
* privately managed

Examples:

```text
192.168.x.x
10.x.x.x
172.16-31.x.x
```

---

WAN:

```text
Internet
Corporate networks between cities
International provider networks
```

Connects multiple LANs together.

Routers are the devices that make WAN communication possible.

---

#### Wireshark observation

When capturing ICMP packets:

Expand:

```text
Ethernet II
```

You see:

```text
Source MAC
Destination MAC
```

Expand:

```text
Internet Protocol
```

You see:

```text
Source IP
Destination IP
```

This is an excellent demonstration that:

* Layer 2 uses MAC addresses.
* Layer 3 uses IP addresses.
* Both exist simultaneously in the same transmitted data.
