# 299. The `ip` Command: Inspecting Network Configurations

# introduction: the `ip` command

The `ip` command is:

```text id="ipcmd001"
a modern Linux networking utility for inspecting and managing network configuration
```

It is part of:

```text id="ipcmd002"
iproute2
```

package suite.

---

# purpose of the `ip` command

The `ip` command is used to:

* inspect IP addresses
* inspect network interfaces
* inspect routes
* configure interfaces
* troubleshoot networking
* manage routing tables

---

# important historical context

The `ip` command replaces older tools such as:

| Old Tool | Modern Replacement |
| -------- | ------------------ |
| ifconfig | ip                 |
| route    | ip route           |
| netstat  | ss / ip            |

---

# why `ip` replaced older tools

Older tools:

* fragmented functionality
* inconsistent syntax
* limited IPv6 support
* outdated networking model

The `ip` command provides:

```text id="ipcmd003"
one unified networking interface
```

---

# basic command

Show network interfaces and IP addresses:

```bash id="ipcmd004"
ip addr show
```

Short version:

```bash id="ipcmd005"
ip a
```

Very commonly used.

---

# older equivalent

Old command:

```bash id="ipcmd006"
ifconfig -a
```

Meaning:

* show all network interfaces

Including:

* inactive interfaces

---

# important note

Modern Linux distributions often:

```text id="ipcmd007"
do not install ifconfig by default
```

because:

```text id="ipcmd008"
ip command preferred
```

---

# what `ip addr show` displays

The command shows:

* interface names
* MAC addresses
* IPv4 addresses
* IPv6 addresses
* interface state
* MTU
* broadcast addresses

---

# example output structure

```text id="ipcmd009"
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP>
```

---

# interface name

Example:

```text id="ipcmd010"
enp0s3
```

This is:

```text id="ipcmd011"
network interface name
```

Examples:

* eth0
* wlan0
* enp0s3
* wlp2s0

---

# interface flags

Example:

```text id="ipcmd012"
UP
```

Meaning:

```text id="ipcmd013"
interface enabled
```

---

# LOWER_UP

```text id="ipcmd014"
LOWER_UP
```

Usually means:

```text id="ipcmd015"
physical/network link detected
```

Example:

* Ethernet cable connected
* WiFi associated

---

# IPv4 address example

```text id="ipcmd016"
inet 192.168.1.20/24
```

Meaning:

* IPv4 address:

```text id="ipcmd017"
192.168.1.20
```

with subnet mask:

```text id="ipcmd018"
/24
```

---

# IPv6 address example

```text id="ipcmd019"
inet6 fe80::...
```

Meaning:

* IPv6 address assigned

---

# important networking concept

A Linux system may have:

```text id="ipcmd020"
multiple network interfaces
```

Examples:

* Ethernet
* WiFi
* Docker virtual interfaces
* VPN interfaces
* loopback interface

---

# loopback interface

Very important interface:

```text id="ipcmd021"
lo
```

Represents:

```text id="ipcmd022"
localhost
```

Usually:

```text id="ipcmd023"
127.0.0.1
```

---

# common practical usage

Inspect current IP:

```bash id="ipcmd024"
ip addr show
```

or:

```bash id="ipcmd025"
ip a
```

---

# showing only one interface

Example:

```bash id="ipcmd026"
ip addr show enp0s3
```

---

# another major component: routes

Show routing table:

```bash id="ipcmd027"
ip route show
```

Short version:

```bash id="ipcmd028"
ip r
```

Very important command.

---

# routing table purpose

The routing table determines:

```text id="ipcmd029"
where packets should be forwarded
```

Especially:

* default gateway
* local networks
* VPN routes

---

# example route

```text id="ipcmd030"
default via 192.168.1.1
```

Meaning:

```text id="ipcmd031"
send internet traffic through home router
```

---

# another useful component

Show link-layer information:

```bash id="ipcmd032"
ip link show
```

Short version:

```bash id="ipcmd033"
ip l
```

Displays:

* interfaces
* MAC addresses
* link states

---

# interface manipulation

Bring interface up:

```bash id="ipcmd034"
sudo ip link set enp0s3 up
```

Bring interface down:

```bash id="ipcmd035"
sudo ip link set enp0s3 down
```

Very useful for troubleshooting.

---

# assigning IP addresses manually

Example:

```bash id="ipcmd036"
sudo ip addr add 192.168.1.50/24 dev enp0s3
```

Adds:

* temporary IP address

---

# important note

Changes made with `ip`:

```text id="ipcmd037"
usually temporary
```

and disappear after:

* reboot
* NetworkManager reload
* interface reset

Persistent configuration handled elsewhere.

---

# macOS note

macOS does not natively provide:

```text id="ipcmd038"
Linux ip command
```

because:

* different networking stack/tools

---

# alternative for macOS

Possible solution:

```text id="ipcmd039"
iproute2mac
```

Provides:

* compatibility wrapper
* Linux-like syntax

internally using:

* macOS networking commands

---

# installation on macOS

Using Homebrew:

```bash id="ipcmd040"
brew install iproute2mac
```

---

# important note about compatibility

`iproute2mac`:

```text id="ipcmd041"
does NOT fully replicate Linux ip functionality
```

Some outputs/features differ.

---

# why the `ip` command is important

The `ip` command is foundational for:

* Linux networking
* server administration
* Docker networking
* Kubernetes
* VPN troubleshooting
* cloud infrastructure
* debugging connectivity issues

---

# useful commands summary

Show addresses:

```bash id="ipcmd042"
ip addr show
```

Short form:

```bash id="ipcmd043"
ip a
```

Show routes:

```bash id="ipcmd044"
ip route show
```

Short form:

```bash id="ipcmd045"
ip r
```

Show interfaces:

```bash id="ipcmd046"
ip link show
```

Bring interface down:

```bash id="ipcmd047"
sudo ip link set enp0s3 down
```

Bring interface up:

```bash id="ipcmd048"
sudo ip link set enp0s3 up
```

Assign temporary IP:

```bash id="ipcmd049"
sudo ip addr add 192.168.1.50/24 dev enp0s3
```

Old legacy command:

```bash id="ipcmd050"
ifconfig -a
```
