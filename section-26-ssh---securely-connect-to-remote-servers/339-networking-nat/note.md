## 339. Networking (NAT Network)

# Overview

In this lesson, we create a small virtual network consisting of two virtual machines (VMs) that can communicate with each other using VirtualBox's NAT Network feature.

Unlike a standard NAT adapter, a NAT Network allows multiple virtual machines to communicate with each other while still providing internet access through the host machine.

This setup is ideal for learning:

* SSH
* Client-server communication
* Linux networking
* Multi-machine environments

---

# NAT vs NAT Network

## Standard NAT

```text
Virtual Machine
       │
       ▼
VirtualBox NAT
       │
       ▼
Internet
```

### Characteristics

* Internet access works.
* VM can access the outside world.
* Other VMs cannot easily communicate with it.
* Host-to-VM communication usually requires port forwarding.

---

## NAT Network

```text
          NAT Network
      ┌────────┬────────┐
      ▼        ▼        ▼
    VM1      VM2      VM3
```

### Characteristics

* Internet access works.
* VMs can communicate with each other.
* Ideal for creating virtual labs.
* Useful for SSH practice and networking experiments.

---

# Creating a Second Virtual Machine

To simulate a real network, we need at least two virtual machines.

---

## Clone an Existing VM

### Steps

1. Open VirtualBox.
2. Right-click the existing VM.
3. Select:

```text
Clone
```

4. Choose a new name.

Example:

```text
ubuntu-server
ubuntu-client
```

---

## MAC Address Option

Choose:

```text
Generate New MAC Addresses
```

### Why?

Every network device must have a unique MAC address.

If two machines share the same MAC address, networking problems may occur.

---

# Configure a Unique Hostname

After cloning, both machines will have the same hostname.

We must change it.

---

## Edit the Hostname

```bash
sudo nano /etc/hostname
```

Example:

### VM1

```text
ubuntu-server
```

### VM2

```text
ubuntu-client
```

---

# Update `/etc/hosts`

Each machine should also update its local hostname mapping.

---

## Edit Hosts File

```bash
sudo nano /etc/hosts
```

Example:

```text
127.0.0.1 localhost
127.0.1.1 ubuntu-server
```

or:

```text
127.0.0.1 localhost
127.0.1.1 ubuntu-client
```

depending on the machine.

---

## Why Is This Necessary?

The hostname should correctly resolve to the local machine.

Without updating `/etc/hosts`, hostname-related issues may occur.

---

# Reboot the Virtual Machine

Apply the hostname changes:

```bash
sudo reboot
```

---

# Creating the NAT Network

## Open VirtualBox Network Manager

### Steps

1. Open VirtualBox.
2. Click:

```text
Tools
```

3. Select:

```text
Network
```

---

## Create a New NAT Network

Click:

```text
Create
```

Example:

```text
NatNetwork1
```

---

## Verify Network Settings

Typical configuration:

```text
Network:
10.0.2.0/24
```

VirtualBox automatically provides:

* DHCP
* Routing
* Internet access

---

# Connect VMs to the NAT Network

For each VM:

---

## Open VM Settings

```text
Settings
→ Network
```

---

## Change Adapter Mode

Select:

```text
Attached To:
NAT Network
```

---

## Select the Network

Choose:

```text
NatNetwork1
```

---

# Start Both Virtual Machines

Boot both VMs.

---

# Verify Network Configuration

Inside each VM:

```bash
ip addr show
```

or:

```bash
ip a
```

---

## Example Output

### VM1

```text
10.0.2.4
```

### VM2

```text
10.0.2.5
```

Both machines belong to the same subnet.

---

# Test Connectivity

## Ping Between VMs

From VM1:

```bash
ping 10.0.2.5
```

---

From VM2:

```bash
ping 10.0.2.4
```

Expected result:

```text
64 bytes from 10.0.2.x
```

This confirms successful communication.

---

# Verify Internet Access

From either VM:

```bash
ping google.com
```

or:

```bash
ping 8.8.8.8
```

If replies are received:

```text
64 bytes from ...
```

then internet connectivity is working.

---

# Network Architecture

```text
                 Internet
                      │
                      ▼
              VirtualBox NAT
                      │
         ┌────────────┴────────────┐
         ▼                         ▼
   ubuntu-server            ubuntu-client
      10.0.2.4                 10.0.2.5
```

---

# Why This Setup Is Useful

This environment closely resembles real-world networking.

You can practice:

* SSH connections
* Client-server applications
* Database servers
* Web servers
* DNS experiments
* Linux administration

---

# SSH Example

Suppose:

### VM1

```text
ubuntu-server
10.0.2.4
```

### VM2

```text
ubuntu-client
10.0.2.5
```

From VM2:

```bash
ssh mohammad@10.0.2.4
```

You can remotely access VM1 exactly as you would access a real Linux server.

---

# NAT Network vs Bridged Adapter

| Feature                     | NAT Network | Bridged Adapter |
| --------------------------- | ----------- | --------------- |
| Internet Access             | Yes         | Yes             |
| VM-to-VM Communication      | Yes         | Yes             |
| Visible to Physical Network | No          | Yes             |
| Receives Router IP Address  | No          | Yes             |
| Ideal for Labs              | Yes         | Yes             |
| Ideal for Isolated Testing  | Yes         | No              |

---

# Important Takeaway

A NAT Network allows multiple virtual machines to communicate with each other while maintaining internet access through the host machine.

This creates a safe and isolated networking environment that is perfect for:

* Learning SSH
* Practicing Linux administration
* Testing client-server applications
* Building networking labs

The next SSH lessons will use this environment to establish secure connections between Linux systems.
