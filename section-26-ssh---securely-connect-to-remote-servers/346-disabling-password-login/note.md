## 346. Disabling Password Authentication

# Why Disable Password Authentication?

## Overview

Once SSH public key authentication has been configured and verified, it is recommended to disable password-based authentication.

This significantly improves security because:

* Passwords can be guessed.
* Passwords can be brute-forced.
* Passwords can be leaked or reused.
* SSH keys are much stronger than typical passwords.

---

# Passwords vs SSH Keys

## Password Authentication

```text id="2ec7qh"
Client
   │
   ▼
Send Password
   │
   ▼
Server Verifies Password
```

### Weaknesses

* Human-created passwords are often weak.
* Users may reuse passwords.
* Automated bots continuously attempt password guessing.

Example attacks:

```text id="5k1vdp"
admin
root
password123
welcome123
```

---

## SSH Key Authentication

```text id="gtjlwm"
Client
 ├── Private Key
 │
 ▼
Server
 ├── Public Key
 │
 ▼
Authentication Successful
```

### Benefits

* Extremely difficult to brute-force.
* Private key never leaves the client.
* Can be protected with a passphrase.
* Industry standard for production systems.

---

# Security Improvement

After disabling password authentication, an attacker would typically need:

```text id="l9c6ff"
Private SSH Key
         +
System Credentials
```

to gain administrative access.

For example:

* SSH access requires the private key.
* Administrative actions require `sudo`.

This provides multiple layers of protection.

---

# Before Disabling Password Authentication

## Important Warning

Never disable password authentication until you have successfully tested SSH key authentication.

Verify that the following works:

```bash id="4pr7zx"
ssh user@server
```

without prompting for a password.

---

## Recommended Test

Open a second terminal:

```bash id="xjlwm8"
ssh mohammad@server
```

If login succeeds using the key:

✔ Key authentication works

✔ Safe to continue

---

# Configure SSH

## Edit the SSH Server Configuration

Open:

```bash id="vtjlwm"
sudo nano /etc/ssh/sshd_config
```

---

## Locate the Directive

You may find:

```text id="5hndhv"
#PasswordAuthentication yes
```

or:

```text id="6jlwm5"
PasswordAuthentication yes
```

---

## Disable Password Authentication

Set:

```text id="jlwm18"
PasswordAuthentication no
```

---

# Meaning

After this change:

```text id="dgjnkg"
SSH Login Using Password
            ↓
        Rejected
```

Only key-based authentication will be accepted.

---

# Validate the Configuration

Before restarting SSH:

```bash id="jlwm25"
sudo sshd -t
```

---

## Successful Validation

No output usually means:

```text id="jlwm32"
Configuration is valid.
```

---

## Configuration Error

Example:

```text id="jlwm39"
Bad configuration option
```

Correct any issues before continuing.

---

# Restart SSH

Ubuntu / Debian:

```bash id="jlwm46"
sudo systemctl restart ssh
```

---

CentOS / Rocky Linux / RHEL:

```bash id="jlwm53"
sudo systemctl restart sshd
```

---

# Verify the Configuration

Open a new terminal and test:

```bash id="jlwm60"
ssh user@server
```

Expected result:

```text id="jlwm67"
Authentication using SSH key
```

---

# Test Password Login

Attempt to force password authentication:

```bash id="jlwm74"
ssh -o PreferredAuthentications=password user@server
```

Expected result:

```text id="jlwm81"
Permission denied
```

This confirms password authentication is disabled.

---

# Additional Recommended Settings

Many production servers use the following combination:

```text id="jlwm88"
PermitRootLogin no
PasswordAuthentication no
```

---

## Meaning

### Root Login

```text id="jlwm95"
Disabled
```

---

### Password Authentication

```text id="njlwm2"
Disabled
```

---

### Authentication Method

```text id="7jlwm9"
SSH Keys Only
```

This greatly reduces the attack surface.

---

# Typical Production Configuration

Example:

```text id="4jlwm6"
PermitRootLogin no
PasswordAuthentication no
AllowUsers mohammad admin
```

---

## Security Benefits

✔ No direct root access

✔ No password guessing attacks

✔ Only approved users may connect

✔ SSH keys required

---

# Common Mistake

## Locking Yourself Out

Suppose:

```text id="1jlwm3"
PasswordAuthentication no
```

is enabled before SSH keys are configured.

Result:

```text id="5jlwm0"
No Password Login
          +
No SSH Key
          =
No Access
```

You may lock yourself out of the server.

---

# Safe Procedure

Always follow:

```text id="tjlwm7"
Configure SSH Key
        ↓
Test SSH Key Login
        ↓
Open Second SSH Session
        ↓
Disable Password Authentication
        ↓
Validate Configuration
        ↓
Restart SSH
        ↓
Verify New Login
```

---

# Real-World Relevance

Most modern cloud providers encourage or require SSH key authentication.

Examples:

* Amazon EC2
* Google Cloud Compute Engine
* Microsoft Azure
* DigitalOcean
* Linode

Many production environments completely disable password-based SSH logins.

---

# Security Layering

A hardened SSH server often combines:

```text id="9jlwm4"
Custom SSH Port
          +
PermitRootLogin no
          +
AllowUsers
          +
SSH Key Authentication
          +
PasswordAuthentication no
          +
Firewall Rules
```

Each layer increases security and reduces attack opportunities.

---

# Important Takeaway

After successfully configuring SSH public key authentication, password authentication should generally be disabled:

```text id="6jlwm1"
PasswordAuthentication no
```

This prevents password-based attacks and ensures that only users possessing a valid private key can access the server.

Combined with:

```text id="3jlwm8"
PermitRootLogin no
```

and proper user restrictions, this forms the foundation of a secure SSH server configuration.
