# 303. Managing Layer 1: Controlling Physical Devices with Software

## Layer 1 device management

Although Layer 1 deals with physical connectivity, Linux allows network interfaces to be controlled through software.

This makes it possible to:

* enable interfaces
* disable interfaces
* reset interfaces
* troubleshoot connectivity issues

---

# identify available interfaces

Display network interfaces:

```bash
ip addr show
```

Short form:

```bash
ip a
```

---

# example output

```text
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP>
3: wlp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP>
```

Possible interface names:

| Interface | Description        |
| --------- | ------------------ |
| enp0s3    | Ethernet adapter   |
| wlp2s0    | Wi-Fi adapter      |
| lo        | Loopback interface |

---

# interface state

Common states:

| Flag       | Meaning                |
| ---------- | ---------------------- |
| UP         | Interface enabled      |
| DOWN       | Interface disabled     |
| LOWER_UP   | Physical link detected |
| NO-CARRIER | No cable/link detected |

---

# disable an interface

Syntax:

```bash
sudo ip link set dev <interface> down
```

Example:

```bash
sudo ip link set dev enp0s5 down
```

Result:

```text
network interface disabled
```

The operating system stops using that interface.

---

# effects of disabling an interface

Possible consequences:

* internet connection lost
* SSH session disconnected
* VPN disconnected
* network services become unreachable

---

# important warning

If connected remotely through SSH:

```bash
sudo ip link set dev enp0s5 down
```

may immediately terminate the remote session.

Always verify which interface is being modified.

---

# enable an interface

Syntax:

```bash
sudo ip link set dev <interface> up
```

Example:

```bash
sudo ip link set dev enp0s5 up
```

Result:

```text
interface re-enabled
```

Network connectivity can resume if:

* cable connected
* Wi-Fi available
* configuration valid

---

# verify interface status

Check current status:

```bash
ip link show
```

Example:

```text
2: enp0s5: <BROADCAST,MULTICAST,UP,LOWER_UP>
```

Meaning:

* interface enabled
* physical link active

---

# practical workflow

## identify interface

```bash
ip addr show
```

---

## disable interface

```bash
sudo ip link set dev enp0s5 down
```

---

## verify status

```bash
ip link show enp0s5
```

Expected:

```text
state DOWN
```

---

## enable interface again

```bash
sudo ip link set dev enp0s5 up
```

---

## verify connectivity

```bash
ping google.com
```

or

```bash
ping 8.8.8.8
```

---

# common troubleshooting use cases

Disable and re-enable an interface to:

* recover from driver issues
* refresh DHCP configuration
* reset Wi-Fi connection
* test failover mechanisms
* simulate network outages

---

# persistence

Commands executed with `ip link` are:

```text
temporary
```

After reboot:

* NetworkManager
* systemd-networkd
* netplan

may restore the original configuration.

Persistent interface configuration is managed through network configuration files and services.

---

# useful commands summary

Show interfaces:

```bash
ip addr show
```

```bash
ip a
```

Show link information:

```bash
ip link show
```

Disable interface:

```bash
sudo ip link set dev enp0s5 down
```

Enable interface:

```bash
sudo ip link set dev enp0s5 up
```

Test connectivity:

```bash
ping 8.8.8.8
```

```bash
ping google.com
```
