# 311. Navigating Network Routing: Inspecting Routing Tables & Adding Routes

## What is a Routing Table?

A routing table tells the operating system:

```text
Where should packets be sent?
```

When an application wants to send data:

```text
Destination IP → Routing Table → Next Hop
```

The kernel consults the routing table before sending every packet.

---

# Display Routing Table

Show all routes:

```bash
ip route show
```

Example:

```text
default via 192.168.1.1 dev enp0s5

192.168.1.0/24 dev enp0s5 proto kernel scope link src 192.168.1.16
```

---

# Understanding the Output

## Local Network Route

```text
192.168.1.0/24 dev enp0s5
```

Meaning:

```text
To reach any address in 192.168.1.0/24,
send packets directly through enp0s5.
```

Examples:

```text
192.168.1.20
192.168.1.50
192.168.1.200
```

No router is required.

ARP will be used to discover the destination MAC address.

---

## Default Route

```text
default via 192.168.1.1 dev enp0s5
```

Meaning:

```text
If no more specific route exists,
send packets to 192.168.1.1
```

This is called:

```text
Default Gateway
```

Typically your home router.

Examples:

```text
8.8.8.8
1.1.1.1
142.250.x.x (Google)
```

All use the default route.

---

# Determine Which Route Will Be Used

Syntax:

```bash
ip route get <destination>
```

Example:

```bash
ip route get 8.8.8.8
```

Possible output:

```text
8.8.8.8 via 192.168.1.1 dev enp0s5 src 192.168.1.16
```

Meaning:

* destination: 8.8.8.8
* next hop: 192.168.1.1
* outgoing interface: enp0s5
* source IP: 192.168.1.16

---

# Adding Routes

Syntax:

```bash
sudo ip route add <destination> via <gateway> dev <interface>
```

Example:

```bash
sudo ip route add 10.0.0.0/24 via 192.168.1.1 dev enp0s5
```

Meaning:

```text
To reach 10.0.0.0/24,
forward packets to 192.168.1.1
```

---

# Removing Routes

Syntax:

```bash
sudo ip route del <destination> via <gateway> dev <interface>
```

Example:

```bash
sudo ip route del 10.0.0.0/24 via 192.168.1.1 dev enp0s5
```

---

# Host Routes (/32)

Example:

```bash
sudo ip route add 9.9.9.9/32 via 192.168.1.26 dev enp0s5
```

Meaning:

```text
For exactly one destination:
9.9.9.9

Send traffic through:
192.168.1.26
```

`/32` means:

```text
Single host route
```

Not a subnet.

---

# Why Didn't the Ping Work?

Example:

```bash
ping 9.9.9.9
```

You added:

```bash
sudo ip route add 9.9.9.9/32 via 192.168.1.26 dev enp0s5
```

Packets reach:

```text
192.168.1.26
```

but no reply arrives.

---

# Explanation

The routing table only changes:

```text
YOUR machine's routing decision
```

It does NOT automatically make:

```text
192.168.1.26
```

act as a router.

---

# What Happens

Step 1:

```text
Your PC
    ↓
192.168.1.26
```

The packet successfully arrives.

---

Step 2:

Device `192.168.1.26` receives the packet.

Destination:

```text
9.9.9.9
```

---

Step 3:

The device checks:

```text
Am I configured to forward packets?
```

Usually:

```text
No
```

Most Linux PCs, laptops, Raspberry Pis and desktops are not routers by default.

---

# IP Forwarding

For a Linux machine to route packets it must enable:

```bash
cat /proc/sys/net/ipv4/ip_forward
```

Output:

```text
0
```

means:

```text
packet forwarding disabled
```

---

Enable temporarily:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

or:

```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

---

# Even That Is Not Enough

The forwarding device also needs:

* a route to the Internet
* proper firewall rules
* NAT/masquerading in many cases

Otherwise packets may leave but replies never return.

---

# Example: Real Router

Home network:

```text
PC
192.168.1.16
        ↓
Router
192.168.1.1
        ↓
Internet
        ↓
9.9.9.9
```

Works because the router:

* forwards packets
* performs NAT
* maintains routing tables
* receives return traffic

---

# Example: Normal PC

```text
PC A
192.168.1.16
        ↓
PC B
192.168.1.26
        ↓
9.9.9.9
```

Usually fails because:

```text
PC B is not configured as a router
```

and drops the packet.

---

# Route Selection Rule

Linux always chooses:

```text
Most specific route
```

Example:

```text
default via 192.168.1.1

9.9.9.9/32 via 192.168.1.26
```

For destination:

```text
9.9.9.9
```

Linux chooses:

```text
9.9.9.9/32
```

because `/32` is more specific than `default`.

---

# Useful Commands

Show routing table:

```bash
ip route show
```

Determine selected route:

```bash
ip route get 8.8.8.8
```

Add route:

```bash
sudo ip route add 10.0.0.0/24 via 192.168.1.1 dev enp0s5
```

Delete route:

```bash
sudo ip route del 10.0.0.0/24 via 192.168.1.1 dev enp0s5
```

Check forwarding status:

```bash
cat /proc/sys/net/ipv4/ip_forward
```

Enable forwarding:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

---

# TL;DR

The routing table determines:

```text
Destination IP → Next Hop
```

Examples:

```text
192.168.1.0/24
```

→ send directly on local network

```text
default via 192.168.1.1
```

→ send to router

A custom route such as:

```bash
sudo ip route add 9.9.9.9/32 via 192.168.1.26
```

only tells your machine to send packets to `192.168.1.26`.

If `192.168.1.26` is not configured as a router (IP forwarding + routing + NAT), the packets will be discarded and communication will fail.
