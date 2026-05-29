## 338. Networking (Bridged Adapter)

### Overview

A bridged network adapter allows a virtual machine (VM) to appear as a separate device on the same physical network as the host machine.

Instead of being hidden behind VirtualBox's internal networking mechanisms, the VM receives its own IP address from the local network and can communicate directly with other devices.

---

## Why Use Bridged Networking?

With a bridged adapter:

* The virtual machine becomes a full member of the local network.
* Other devices can communicate directly with the VM.
* The VM can obtain an IP address from the same DHCP server used by the host.
* SSH connections become much easier to establish.

---

## Network Architecture

### Bridged Adapter

```text
Router / DHCP Server
          │
 ┌────────┴────────┐
 │                 │
 ▼                 ▼
Host PC        Virtual Machine
192.168.1.10   192.168.1.15
```

Both systems appear as independent devices on the network.

---

## Comparison with NAT

### NAT Mode

```text
Internet
    │
    ▼
Host Computer
    │
    ▼
Virtual Machine
```

* VM is hidden behind the host.
* Direct access to the VM may require port forwarding.

---

### Bridged Mode

```text
Internet
    │
    ▼
Router
 ┌──┴──┐
 ▼     ▼
Host   VM
```

* Host and VM are peers.
* Both have independent network identities.
* No port forwarding is required for local network access.

---

## Configuring a Bridged Adapter in VirtualBox

### Step 1: Power Off the Virtual Machine

The VM should be shut down before modifying network settings.

---

### Step 2: Open VirtualBox Settings

1. Select the virtual machine.
2. Click:

```text
Settings
```

3. Open:

```text
Network
```

---

### Step 3: Change Adapter Type

Select:

```text
Attached to: Bridged Adapter
```

---

### Step 4: Select the Physical Network Interface

Choose the interface used by the host machine.

Examples:

```text
Wi-Fi Adapter
```

or

```text
Ethernet Adapter
```

---

### Step 5: Start the Virtual Machine

Boot the VM normally.

---

## Verify the IP Address

Inside the VM:

```bash
ip addr show
```

or

```bash
ip a
```

---

### Example Output

```text
192.168.1.15/24
```

This indicates that the VM received an IP address from the local network.

---

## Test Connectivity from the Host

Suppose the VM received:

```text
192.168.1.15
```

From the host machine:

```bash
ping 192.168.1.15
```

Expected result:

```text
64 bytes from 192.168.1.15
```

This confirms network communication between the host and the VM.

---

## Test Connectivity from the VM

Inside the VM:

```bash
ping 192.168.1.10
```

where:

```text
192.168.1.10
```

is the host machine's IP address.

---

## Hostname Resolution

If mDNS (Multicast DNS) is configured correctly, devices may be reachable using hostnames.

Example:

```bash
ping host.local
```

or

```bash
ping ubuntu.local
```

---

### How mDNS Works

Instead of querying a DNS server, devices ask the local network:

```text
Who owns ubuntu.local?
```

The correct device responds with its IP address.

---

## Verifying mDNS on Linux

Ensure Avahi is running:

```bash
systemctl status avahi-daemon
```

---

### Start Avahi if Needed

```bash
sudo systemctl enable --now avahi-daemon
```

---

## Practical Example

Suppose:

### Host

```text
Hostname: windows-pc
IP: 192.168.1.10
```

### Virtual Machine

```text
Hostname: ubuntu
IP: 192.168.1.15
```

You can test:

```bash
ping 192.168.1.15
```

or:

```bash
ping ubuntu.local
```

---

## Why This Is Important for SSH

In the next SSH lessons, bridged networking allows us to connect directly to the VM.

Example:

```bash
ssh mohammad@192.168.1.15
```

or:

```bash
ssh mohammad@ubuntu.local
```

This closely resembles real-world environments where administrators connect to remote Linux servers over a network.

---

## Common Troubleshooting

### VM Has No IP Address

Check:

```bash
ip addr show
```

If no address appears:

* Verify the bridged adapter is selected.
* Confirm the correct network interface is chosen.
* Ensure the router's DHCP server is active.

---

### Cannot Ping the VM

Check:

* Firewall settings
* VM network configuration
* Bridged adapter selection
* Whether both devices are on the same subnet

---

### `.local` Hostnames Do Not Work

Verify:

```bash
systemctl status avahi-daemon
```

and ensure mDNS support is installed and running.

---

## Important Takeaway

A bridged adapter makes the virtual machine behave like a real computer on the network.

Benefits include:

* Direct network communication
* Easier SSH access
* Realistic networking scenarios
* Better preparation for server administration and DevOps environments

Bridged networking is one of the most useful configurations when learning Linux networking and SSH administration.
