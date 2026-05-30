## 343. SSH Security Tips (Part 2): Disabling Root Login and Whitelisting Users

# SSH User Security

## The Problem

By default, SSH may allow any local user account with a valid password to attempt a login.

Example:

```text
mohammad
ahmad
admin
test
developer
```

If these accounts exist on the server and SSH authentication is enabled, they may potentially be used for remote access.

This increases the attack surface of the system.

---

# Security Principle

A good security practice is:

```text
Least Privilege
```

Users should have only the permissions they actually need.

For SSH access, this means:

* Disable direct root login.
* Allow only authorized users.
* Restrict unnecessary accounts.

---

# Disabling Root Login

## Why Disable Root Login?

The root account has unrestricted access to the entire system.

If an attacker successfully compromises the root account:

```text
Full System Compromise
```

is possible immediately.

---

## Common Attack Pattern

Automated bots frequently attempt:

```text
root
admin
administrator
```

because these usernames are commonly present on Linux servers.

Example log entries:

```text
Failed password for root
Failed password for root
Failed password for root
```

Thousands of such attempts may occur daily on public servers.

---

# Recommended Approach

Instead of logging in directly as root:

1. Log in as a normal user.
2. Elevate privileges when necessary.

Example:

```bash
ssh mohammad@server
```

Then:

```bash
sudo -s
```

or:

```bash
sudo su -
```

---

# Configure SSH to Disable Root Login

## Edit the SSH Server Configuration

Open:

```bash
sudo nano /etc/ssh/sshd_config
```

---

## Locate the Directive

You may find:

```text
#PermitRootLogin prohibit-password
```

or:

```text
#PermitRootLogin yes
```

---

## Disable Root Login

Set:

```text
PermitRootLogin no
```

---

## Meaning

```text
Root Login via SSH
        │
        ▼
    Denied
```

Even if the root password is correct, SSH login will be refused.

---

# Validate the Configuration

Before restarting SSH:

```bash
sudo sshd -t
```

---

## Successful Validation

No output typically means:

```text
Configuration is valid.
```

---

# Restart SSH

Ubuntu/Debian:

```bash
sudo systemctl restart ssh
```

---

CentOS/RHEL/Rocky Linux:

```bash
sudo systemctl restart sshd
```

---

# Testing Root Login

Attempt:

```bash
ssh root@server-ip
```

Expected result:

```text
Permission denied
```

or

```text
Access denied
```

This confirms root login has been disabled.

---

# Whitelisting SSH Users

## The Problem

Even after disabling root login, every local user account may still be able to connect through SSH.

Example:

```text
mohammad
ahmad
test
developer
backup
```

All of these users might be able to attempt SSH logins.

---

# Why Restrict Users?

We should explicitly define who is allowed to access the server remotely.

Benefits:

* Smaller attack surface
* Better access control
* Easier auditing
* Improved security

---

# AllowUsers Directive

SSH provides the:

```text
AllowUsers
```

directive.

This creates an SSH whitelist.

---

## Example Configuration

Open:

```bash
sudo nano /etc/ssh/sshd_config
```

Add:

```text
AllowUsers mohammad ahmad
```

---

## Meaning

### Allowed

```text
mohammad
ahmad
```

### Blocked

```text
root
test
developer
guest
backup
```

Only the listed users may connect via SSH.

---

# Example Scenario

Suppose the server contains:

```text
mohammad
ahmad
developer
backup
```

and SSH configuration contains:

```text
AllowUsers mohammad ahmad
```

---

## Result

### Successful Login

```bash
ssh mohammad@server
```

✔ Allowed

---

### Successful Login

```bash
ssh ahmad@server
```

✔ Allowed

---

### Failed Login

```bash
ssh developer@server
```

✘ Denied

---

### Failed Login

```bash
ssh backup@server
```

✘ Denied

---

# Validate and Restart

## Validate

```bash
sudo sshd -t
```

---

## Restart

Ubuntu/Debian:

```bash
sudo systemctl restart ssh
```

---

CentOS/RHEL/Rocky:

```bash
sudo systemctl restart sshd
```

---

# Verify Current Users

Display local accounts:

```bash
cat /etc/passwd

Human Users Only

Often filtered with:

grep /home /etc/passwd

This helps identify actual user accounts.
```

---

# Recommended Production Configuration

Example:

```text
PermitRootLogin no

AllowUsers mohammad admin
```

This configuration:

✔ Disables direct root login

✔ Restricts SSH access to approved users

✔ Reduces exposure to brute-force attacks

---

# Additional Security Improvements

Many production servers also use:

```text
PasswordAuthentication no
```

to disable password-based logins entirely.

Instead, users authenticate using:

```text
SSH Public Keys
```

which are significantly more secure.

This topic will be covered in upcoming lessons.

---

# Security Layers

A secure SSH server typically combines:

```text
Strong Passwords
        +
Non-Default Port
        +
No Root Login
        +
User Whitelisting
        +
SSH Keys
        +
Firewall Rules
```

Each layer adds additional protection.

---

# Important Takeaway

Two of the simplest and most effective SSH security improvements are:

1. Disable direct root login:

```text
PermitRootLogin no
```

2. Explicitly define who may access the server:

```text
AllowUsers mohammad ahmad
```

Together, these measures significantly reduce the risk of unauthorized access and are considered standard best practices for SSH server hardening.
