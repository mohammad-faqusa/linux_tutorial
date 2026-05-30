## 342. SSH Security Tips (Part 1): Changing the SSH Port on CentOS / RHEL

# Why Additional Steps Are Required

On Ubuntu, changing the SSH port is usually as simple as:

```bash
sudo nano /etc/ssh/sshd_config
```

followed by restarting the SSH service.

However, on CentOS, Rocky Linux, RHEL, and other SELinux-enabled distributions, additional configuration is required because:

* SELinux restricts which ports services are allowed to use.
* Firewalld may block the new port.

Therefore, changing the SSH port requires updating:

* SSH configuration
* SELinux policy
* Firewall rules

---

# Step 1: Change the SSH Port

## Edit the SSH Configuration

```bash
sudo nano /etc/ssh/sshd_config
```

Locate:

```text
#Port 22
```

Replace it with:

```text
Port 2222
```

You may choose any unused port.

Example:

```text
Port 2022
Port 2222
Port 22222
```

---

# Step 2: Configure SELinux

## Why?

Even if SSH is configured to use port 2222, SELinux may prevent the SSH daemon from binding to that port.

By default, SELinux allows SSH to listen only on approved SSH ports.

---

## Install Required Utilities

The `semanage` command is provided by:

```bash
policycoreutils-python-utils
```

or on some systems:

```bash
policycoreutils
```

Install it:

```bash
sudo dnf install policycoreutils-python-utils
```

If that package is unavailable:

```bash
sudo dnf install policycoreutils
```

---

## Verify Existing SSH Ports

```bash
sudo semanage port -l | grep ssh
```

Example:

```text
ssh_port_t    tcp    22
```

---

## Add the New SSH Port

Example:

```bash
sudo semanage port -a -t ssh_port_t -p tcp 2222
```

### Explanation

| Option          | Meaning       |
| --------------- | ------------- |
| `-a`            | Add           |
| `-t ssh_port_t` | SSH port type |
| `-p tcp`        | TCP protocol  |
| `2222`          | New SSH port  |

---

## Verify the New SELinux Rule

```bash
sudo semanage port -l | grep ssh
```

Example:

```text
ssh_port_t    tcp    22,2222
```

This confirms SELinux now permits SSH traffic on port 2222.

---

# Step 3: Configure Firewalld

## Verify Firewalld Status

```bash
sudo systemctl status firewalld
```

Expected result:

```text
active (running)
```

---

## Allow the New SSH Port

```bash
sudo firewall-cmd --add-port=2222/tcp --permanent
```

### Explanation

* Opens TCP port 2222.
* `--permanent` ensures the rule survives reboots.

---

## Reload Firewalld

```bash
sudo firewall-cmd --reload
```

This applies the new configuration.

---

## Verify Firewall Rules

```bash
sudo firewall-cmd --list-ports
```

Example:

```text
2222/tcp
```

---

# Step 4: Restart SSH

## Validate the Configuration

```bash
sudo sshd -t
```

If no output appears:

```text
Configuration is valid.
```

---

## Restart the SSH Service

```bash
sudo systemctl restart sshd
```

---

# Step 5: Verify SSH Is Listening

```bash
ss -tulpn | grep ssh
```

Example:

```text
LISTEN 0 128 *:2222
```

SSH is now listening on the new port.

---

# Step 6: Test the New Connection

Before closing your current session, open a second terminal and test:

```bash
ssh user@server-ip -p 2222
```

Example:

```bash
ssh mohammad@192.168.1.15 -p 2222
```

---

# Step 7: Remove the Old SSH Firewall Rule (Optional)

After verifying the new port works correctly:

```bash
sudo firewall-cmd --remove-service=ssh --permanent
sudo firewall-cmd --reload
```

### What Does This Do?

The default SSH service corresponds to:

```text
TCP Port 22
```

Removing it prevents access through the old port.

---

# Important Safety Warning

Never remove port 22 access until:

✔ SELinux is configured

✔ Firewalld allows the new port

✔ SSH is listening on the new port

✔ A successful connection has been tested

Otherwise you may lock yourself out of the server.

---

# Troubleshooting

## Permission Denied Despite Open Firewall

Check SELinux:

```bash
sudo semanage port -l | grep ssh
```

If the new port is missing, SELinux is blocking SSH.

---

## Connection Timed Out

Check:

```bash
sudo firewall-cmd --list-ports
```

The new port may not be open.

---

## SSH Service Fails to Start

Validate the configuration:

```bash
sudo sshd -t
```

Correct any reported errors.

---

# Security Best Practices

When exposing SSH to the Internet:

✔ Change the default port

✔ Use SSH key authentication

✔ Disable root login

✔ Monitor authentication logs

✔ Keep the system updated

✔ Restrict firewall access

✔ Use Fail2Ban or similar protection mechanisms

---

# Important Takeaway

On CentOS, Rocky Linux, and RHEL systems, changing the SSH port requires updating three components:

```text
SSH Configuration
        +
SELinux Policy
        +
Firewalld Rules
```

If any one of these is not configured correctly, SSH may fail to accept connections on the new port.
