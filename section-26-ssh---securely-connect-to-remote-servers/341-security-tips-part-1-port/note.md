## 341. SSH Security Tips (Part 1): Changing the Default Port and Monitoring Logs

# SSH Server Security

## Is SSH Secure?

SSH is designed to be secure by default.

It provides:

* Encryption
* Authentication
* Data integrity verification

This means attackers cannot easily read or modify the communication between the client and the server.

---

## Important Security Reminder

Although SSH itself is secure, poor configuration can still expose a server to attacks.

Good security practices include:

* Using strong passwords
* Keeping systems updated
* Closing unused SSH sessions
* Monitoring authentication logs
* Using SSH keys instead of passwords
* Hardening the SSH configuration

---

# Common Threat: Automated SSH Scanning

## The Problem

SSH typically listens on:

```text
TCP Port 22
```

Attackers know this.

As a result, many automated bots continuously scan the Internet looking for servers with SSH exposed on port 22.

Example:

```text
Attacker Bot
      │
      ▼
Scan IP Addresses
      │
      ▼
Check Port 22
```

---

## What Happens?

Bots may attempt:

* Username guessing
* Password brute-force attacks
* Vulnerability scanning
* Banner collection

Even if the attacks fail, they can generate large numbers of log entries.

Example log messages:

```text
Failed password for root
Failed password for admin
Invalid user test
```

---

# Changing the SSH Port

## Why Change the Port?

Changing the SSH port does not make SSH inherently more secure.

However, it helps reduce:

* Automated scanning
* Log pollution
* Opportunistic attacks

This concept is often called:

```text
Security Through Obscurity
```

It should not replace proper security measures, but it can reduce unwanted traffic.

---

# SSH Configuration File

The SSH server configuration is stored in:

```bash
/etc/ssh/sshd_config
```

---

# Editing the Configuration

## Open the File

```bash
sudo nano /etc/ssh/sshd_config
```

---

## Locate the Port Directive

Default configuration:

```text
#Port 22
```

---

## Change the Port

Example:

```text
Port 2222
```

You may choose another unused port:

```text
Port 2222
Port 2022
Port 22222
```

Avoid ports already used by other services.

---

# Validate the Configuration

Before restarting SSH, verify that the configuration is valid.

```bash
sudo sshd -t
```

---

## Successful Validation

No output usually means:

```text
Configuration is valid.
```

---

## Configuration Error

Example:

```text
Bad configuration option
```

Fix the error before restarting the service.

---

# Restart the SSH Service

## Ubuntu / Debian

```bash
sudo systemctl restart ssh
```

---

## Rocky Linux / CentOS / RHEL

```bash
sudo systemctl restart sshd
```

---

# Verify the New Port

Check listening ports:

```bash
ss -tulpn | grep ssh
```

Example:

```text
LISTEN 0 128 *:2222
```

This confirms SSH is listening on the new port.

---

# Connecting to the New Port

Because SSH no longer uses port 22, the client must specify the port explicitly.

---

## Syntax

```bash
ssh username@server -p PORT
```

---

## Example

```bash
ssh mohammad@ubuntu.local -p 2222
```

or

```bash
ssh mohammad@192.168.1.15 -p 2222
```

---

# Important Firewall Considerations

## Common Issue

After changing the SSH port:

```text
Connection refused
```

or

```text
Connection timed out
```

may occur.

---

## Why?

The firewall may still allow only port 22.

---

## Example Using UFW

Allow the new port:

```bash
sudo ufw allow 2222/tcp
```

Verify:

```bash
sudo ufw status
```

---

## Important Safety Tip

Never close your current SSH session before testing the new one.

Bad sequence:

```text
Change Port
Restart SSH
Logout
Cannot Reconnect
```

You may lock yourself out of the server.

---

## Recommended Sequence

```text
Change Port
Restart SSH
Open New SSH Session
Verify Success
Close Old Session
```

---

# Monitoring SSH Logs

## Why Monitor Logs?

SSH logs reveal:

* Login attempts
* Failed passwords
* Successful logins
* Invalid usernames
* Potential attacks

Monitoring logs is an important part of server administration.

---

# Authentication Log File

On Ubuntu and Debian systems:

```bash
/var/log/auth.log
```

---

# Search for SSH Events

```bash
grep sshd /var/log/auth.log
```

Example output:

```text
sshd[1234]: Accepted password for mohammad
sshd[1235]: Failed password for root
```

---

# Real-Time Monitoring

Use:

```bash
sudo tail -f /var/log/auth.log
```

This displays new log entries as they occur.

---

# Example Attack Log

```text
Failed password for root from 203.0.113.10
Failed password for admin from 203.0.113.10
Invalid user test from 203.0.113.10
```

These entries often indicate automated scanning or brute-force attempts.

---

# Modern Alternative: Journalctl

On systemd-based systems:

```bash
sudo journalctl -u ssh
```

or

```bash
sudo journalctl -u sshd
```

depending on the distribution.

---

# Best Practice Summary

## Good SSH Security

✔ Use strong passwords

✔ Change the default SSH port

✔ Monitor authentication logs

✔ Keep systems updated

✔ Use SSH key authentication

✔ Disable unnecessary accounts

✔ Restrict firewall access

---

## Important Note

Changing the SSH port reduces automated attacks and log noise, but it is not a replacement for proper security measures.

The most effective SSH security improvements are:

* SSH key authentication
* Disabling password authentication
* Firewall restrictions
* Regular monitoring

These topics will be covered in the upcoming SSH security lessons.

---

# Important Takeaway

SSH is secure by design, but publicly exposed SSH servers are constantly scanned by automated bots.

Changing the default port from:

```text
22
```

to something less common can significantly reduce unwanted login attempts and keep authentication logs cleaner.

Always validate configuration changes, test new connections before closing existing sessions, and regularly monitor SSH logs for suspicious activity.
