# 313. Inspecting DHCP Logs with `systemd-networkd`: Troubleshooting IP Address Issues

## DHCP: Inspecting Logs

When troubleshooting DHCP issues, network logs are often the first place to investigate.

Typical information available in logs:

* DHCP requests
* DHCP offers
* Lease acquisition
* Lease renewal
* Gateway assignment
* DNS configuration
* Network link up/down events
* DHCP failures and timeouts

---

# Systems Using `systemd-networkd`

If networking is managed by **systemd-networkd**, logs can be viewed using:

```bash
journalctl -u systemd-networkd
```

Follow logs in real time:

```bash
journalctl -fu systemd-networkd
```

Show only logs from the current boot:

```bash
journalctl -b -u systemd-networkd
```

---

## Example Output

```text
systemd-networkd[412]:
enp0s5: DHCPv4 address 192.168.1.120/24 via 192.168.1.1

systemd-networkd[412]:
enp0s5: Gained carrier

systemd-networkd[412]:
enp0s5: DHCP lease lost
```

---

# Systems Using NetworkManager

Many desktop distributions use **NetworkManager** instead of `systemd-networkd`.

View logs:

```bash
journalctl -u NetworkManager
```

Follow logs live:

```bash
journalctl -fu NetworkManager
```

Current boot only:

```bash
journalctl -b -u NetworkManager
```

---

## Example Output

```text
NetworkManager:
device enp0s5 activated

NetworkManager:
dhcp4 lease acquired

NetworkManager:
gateway 192.168.1.1

NetworkManager:
dns server 8.8.8.8
```

---

# Searching for DHCP Messages

Filter DHCP-related events:

```bash
journalctl -u NetworkManager | grep -i dhcp
```

or

```bash
journalctl -u systemd-networkd | grep -i dhcp
```

Search all boot logs:

```bash
journalctl -b | grep -i dhcp
```

---

# Useful Troubleshooting Procedure

Disconnect and reconnect the interface:

```bash
sudo ip link set dev enp0s5 down
sudo ip link set dev enp0s5 up
```

While monitoring logs:

```bash
journalctl -fu NetworkManager
```

or

```bash
journalctl -fu systemd-networkd
```

Observe:

1. Link detected
2. DHCP request sent
3. DHCP response received
4. IP address assigned
5. Route and DNS configured

---

# Determine Which Service Manages Networking

Check NetworkManager:

```bash
systemctl status NetworkManager
```

Check systemd-networkd:

```bash
systemctl status systemd-networkd
```

Show active networking services:

```bash
systemctl --type=service | grep -i network
```

---

# Common DHCP Problems Visible in Logs

| Message                      | Possible Cause                          |
| ---------------------------- | --------------------------------------- |
| DHCP timeout                 | DHCP server unreachable                 |
| No carrier                   | Cable disconnected / Wi-Fi disconnected |
| Lease lost                   | DHCP lease expired                      |
| No route to host             | Missing gateway configuration           |
| Failed to acquire DHCP lease | DHCP server unavailable                 |
| DNS lookup failures          | Incorrect DNS configuration             |

---

# Useful Commands

View network logs:

```bash
journalctl -u systemd-networkd
```

```bash
journalctl -u NetworkManager
```

Follow logs live:

```bash
journalctl -fu systemd-networkd
```

```bash
journalctl -fu NetworkManager
```

Show interface information:

```bash
ip addr show
```

Show routes:

```bash
ip route
```

Show DNS configuration:

```bash
resolvectl status
```

---

# TL;DR

DHCP troubleshooting often begins with log inspection.

For systems using **systemd-networkd**:

```bash
journalctl -u systemd-networkd
```

For systems using **NetworkManager**:

```bash
journalctl -u NetworkManager
```

These logs reveal DHCP negotiations, lease renewals, interface state changes, gateway configuration, DNS assignments, and network-related errors.
