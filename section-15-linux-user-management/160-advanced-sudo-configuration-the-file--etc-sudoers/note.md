## 160. Advanced `sudo` Configuration: the File `/etc/sudoers`

# 160. Advanced `sudo` Configuration: the File `/etc/sudoers`

The file:

```text id="4m1q7v"
/etc/sudoers
```

controls:

* who may use sudo
* which commands they may run
* as which users
* whether passwords are required
* environment/security behavior

It is one of the most security-critical configuration files in Linux.

---

# VERY IMPORTANT RULE

Never edit directly with:

```bash id="8m2q1v"
sudo nano /etc/sudoers
```

Always use:

```bash id="3q7m1v"
sudo visudo
```

because:

* syntax is validated
* file is locked safely
* mistakes can be caught before saving

---

# 1. Basic Sudoers Syntax

Common Ubuntu rule:

```text id="6m1q8v"
%sudo ALL=(ALL:ALL) ALL
```

This line gives sudo group members full sudo access.

---

# Understanding The Syntax

General format:

```text id="2q4m1v"
user host=(run_as_user:run_as_group) commands
```

---

# Breakdown

Example:

```text id="9m1q5v"
mohammad ALL=(ALL:ALL) ALL
```

| Part        | Meaning               |
| ----------- | --------------------- |
| `mohammad`  | user                  |
| `ALL`       | any host              |
| `(ALL:ALL)` | run as any user/group |
| `ALL`       | any command           |

Meaning:

> mohammad may execute any command as any user.

---

# 2. User vs Group Rules

---

## User Rule

```text id="5v1m8q"
mohammad ALL=(ALL) ALL
```

applies to:

* only mohammad

---

## Group Rule

```text id="1q7m4v"
%sudo ALL=(ALL) ALL
```

`%` means:

* group

So applies to:

* all sudo group members

---

# 3. Passwordless sudo

Example:

```text id="8m4q1v"
mohammad ALL=(ALL) NOPASSWD: ALL
```

Now:

```bash id="2v7m1q"
sudo apt update
```

does NOT ask for password.

---

# Security Warning

Very convenient, but dangerous on:

* desktops
* shared systems

Commonly used for:

* automation
* CI/CD
* scripts

---

# 4. Restrict Commands

Very important enterprise feature.

Example:

```text id="6q1m8v"
ahmad ALL=(ALL) /usr/bin/systemctl restart nginx
```

Now Ahmad may ONLY run:

```bash id="1v4m7q"
sudo systemctl restart nginx
```

Nothing else.

---

# If Ahmad Tries

```bash id="7m2q1v"
sudo apt update
```

Linux denies access.

---

# 5. Multiple Commands

```text id="4q1m8v"
ahmad ALL=(ALL) /usr/bin/systemctl restart nginx, /usr/bin/systemctl status nginx
```

Comma-separated list.

---

# 6. Running As Specific Users

Example:

```text id="1m7q4v"
mohammad ALL=(postgres) ALL
```

Meaning:

* Mohammad may run commands ONLY as postgres.

Example:

```bash id="5v2m1q"
sudo -u postgres psql
```

works.

But:

```bash id="7m1q8v"
sudo apt update
```

may fail.

---

# 7. Aliases In sudoers

For cleaner large configs.

---

## User Alias

```text id="2q7m1v"
User_Alias DEVTEAM = mohammad, ahmad
```

---

## Command Alias

```text id="4m1q7v"
Cmnd_Alias WEB = /usr/bin/systemctl restart nginx
```

---

## Usage

```text id="8m2q1v"
DEVTEAM ALL=(ALL) WEB
```

Now all DEVTEAM users may restart nginx.

---

# 8. Environment Security

Sudo sanitizes dangerous variables.

Defaults section:

```text id="3q7m1v"
Defaults env_reset
```

Prevents:

* PATH hijacking
* malicious library injection
* unsafe environments

---

# 9. secure_path

Example:

```text id="6m1q8v"
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
```

When using sudo:

* PATH becomes restricted/safe

Prevents executing malicious fake commands.

---

# 10. use_pty

Modern Ubuntu often shows:

```text id="2q4m1v"
Defaults use_pty
```

Meaning:

* sudo commands use pseudo-terminal

Improves:

* logging
* auditing
* security

---

# 11. Include Directory — `/etc/sudoers.d`

Modern systems usually avoid editing main sudoers directly.

Instead:

```text id="9m1q5v"
/etc/sudoers.d/
```

contains separate config files.

---

# Example

Create dedicated file:

```bash id="5v1m8q"
sudo visudo -f /etc/sudoers.d/nginx-admins
```

Add:

```text id="1q7m4v"
ahmad ALL=(ALL) /usr/bin/systemctl restart nginx
```

Cleaner and safer.

---

# 12. Check Your Permissions

Current user:

```bash id="8m4q1v"
sudo -l
```

Another user:

```bash id="2v7m1q"
sudo -l -U ahmad
```

---

# 13. Common Enterprise Design

Organizations commonly:

* disable root login
* use sudo policies
* restrict commands
* audit privileged actions

Example:

* developers → restart app only
* DevOps → manage containers
* DB admins → postgres access only

---

# 14. Dangerous Misconfigurations

Very dangerous:

```text id="6q1m8v"
ALL ALL=(ALL) NOPASSWD: ALL
```

This effectively gives:

* unrestricted root access
* no authentication

Huge security risk.

---

# 15. Real-World Example

Suppose:

| User     | Permission             |
| -------- | ---------------------- |
| mohammad | full sudo              |
| ahmad    | restart nginx only     |
| sara     | run backup script only |

Possible sudoers:

```text id="1v4m7q"
mohammad ALL=(ALL) ALL

ahmad ALL=(ALL) /usr/bin/systemctl restart nginx

sara ALL=(root) /usr/local/bin/backup.sh
```

This demonstrates:

* least privilege security
* controlled administrative delegation

One of the core philosophies of Linux system administration.
