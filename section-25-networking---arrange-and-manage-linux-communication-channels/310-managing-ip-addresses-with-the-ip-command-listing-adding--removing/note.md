# 310. Managing IP Addresses with the `ip` Command: Listing, Adding & Removing

## Layer 3: Managing IP Addresses

The `ip` command can be used to inspect and modify IP addresses assigned to network interfaces.

Common operations:

* List IP addresses
* Add IP addresses
* Remove IP addresses
* Configure temporary network settings for testing and troubleshooting

---

# List IP Addresses

Display all network interfaces and their IP addresses:

```bash
ip addr show
```

Short form:

```bash
ip a
```

---

## Example Output

```text
2: enp0s5: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 192.168.1.120/24
```

Meaning:

| Field         | Description                               |
| ------------- | ----------------------------------------- |
| enp0s5        | Network interface                         |
| 192.168.1.120 | IPv4 address                              |
| /24           | Prefix length (subnet mask 255.255.255.0) |

---

# Add an IP Address

Syntax:

```bash
sudo ip addr add <ip>/<prefix> dev <interface>
```

Example:

```bash
sudo ip addr add 192.168.1.232/24 dev enp0s5
```

---

# Verify the Result

```bash
ip addr show
```

Example:

```text
inet 192.168.1.120/24
inet 192.168.1.232/24 secondary
```

The interface now owns two IP addresses.

---

# Multiple IP Addresses on One Interface

Linux allows:

```text
multiple IP addresses on a single network interface
```

Example:

```text
enp0s5
 ├─ 192.168.1.120/24
 └─ 192.168.1.232/24
```

Both addresses can be used simultaneously.

This is commonly used for:

* server migration
* virtual hosting
* testing
* network transitions

---

# Test the New Address

From another machine:

```bash
ping 192.168.1.232
```

Or locally:

```bash
ping 192.168.1.232
```

The address should respond because it belongs to the local machine.

---

# Remove an IP Address

Syntax:

```bash
sudo ip addr del <ip>/<prefix> dev <interface>
```

Example:

```bash
sudo ip addr del 192.168.1.232/24 dev enp0s5
```

Verify:

```bash
ip addr show
```

The secondary address disappears.

---

# Adding an Unreachable Address

Example:

```bash
sudo ip addr add 10.20.30.40/24 dev enp0s5
```

The operating system accepts the configuration.

However:

```text
assigning an IP address does not automatically create connectivity
```

---

## Why Communication Fails

Suppose the LAN is:

```text
192.168.1.0/24
```

but the interface receives:

```text
10.20.30.40/24
```

No neighboring devices exist in:

```text
10.20.30.0/24
```

Therefore communication usually fails.

---

# Example

Interface:

```text
10.20.30.40/24
```

Attempt:

```bash
ping 10.20.30.1
```

Possible result:

```text
Destination Host Unreachable
```

because no device with that address exists.

---

# Temporary Configuration

Changes made with:

```bash
ip addr add
ip addr del
```

are:

```text
temporary
```

They disappear after:

```bash
reboot
```

or interface reconfiguration.

---

# Persistent Configuration

Persistent configuration is usually managed by:

| Distribution   | Tool             |
| -------------- | ---------------- |
| Ubuntu         | Netplan          |
| Ubuntu Desktop | NetworkManager   |
| CentOS / RHEL  | NetworkManager   |
| Servers        | systemd-networkd |

---

# DHCP and Dynamic Address Assignment

In most LANs:

```text
IP addresses are assigned automatically
```

using:

```text
DHCP
(Dynamic Host Configuration Protocol)
```

The router typically provides:

* IP address
* subnet mask
* default gateway
* DNS servers

---

# Static Reservations

Instead of manually configuring addresses on devices, many routers support:

```text
DHCP Reservation
```

or

```text
Static Lease
```

Mapping:

```text
MAC Address → Fixed IP Address
```

Example:

```text
AA:BB:CC:DD:EE:FF
      ↓
192.168.1.50
```

Whenever that device connects, DHCP always assigns the same address.

---

# Useful Commands Summary

Show interfaces and IP addresses:

```bash
ip addr show
```

```bash
ip a
```

Add address:

```bash
sudo ip addr add 192.168.1.232/24 dev enp0s5
```

Remove address:

```bash
sudo ip addr del 192.168.1.232/24 dev enp0s5
```

Show routes:

```bash
ip route
```

Show neighbors (ARP cache):

```bash
ip neigh
```

---

# TL;DR

The `ip` command allows Layer 3 configuration:

```bash
ip addr show
```

Display addresses.

```bash
sudo ip addr add 192.168.1.232/24 dev enp0s5
```

Add an address.

```bash
sudo ip addr del 192.168.1.232/24 dev enp0s5
```

Remove an address.

Linux supports multiple IP addresses on one interface, and these changes are temporary unless configured through the system's network management tools.
