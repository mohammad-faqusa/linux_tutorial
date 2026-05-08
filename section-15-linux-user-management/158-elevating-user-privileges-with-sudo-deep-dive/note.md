## 158. Elevating User Privileges with `sudo` (Deep Dive)

# 158. Elevating User Privileges with `sudo` (Deep Dive)

`sudo` is one of the most important Linux security tools.

It allows a normal user to:

* temporarily execute commands
* with elevated privileges
* usually as root

WITHOUT logging in permanently as root.

---

# 1. What Does `sudo` Mean?

Historically:

```text id="4m1q7v"
sudo = superuser do
```

Meaning:

> execute command as superuser

---

# Basic Usage

```bash id="8m2q1v"
sudo command
```

Example:

```bash id="3q7m1v"
sudo apt update
```

---

# 2. Why `sudo` Exists

Early Unix systems often used:

```bash id="6m1q8v"
su -
```

to become root permanently.

Problem:

* dangerous
* no accountability
* easy accidental damage
* shared root password

---

Modern Linux prefers:

```bash id="2q4m1v"
sudo
```

because it provides:

* temporary elevation
* logging
* auditing
* finer permissions

---

# 3. How `sudo` Works Internally

Suppose user:

```text id="9m1q5v"
mohammad
```

belongs to:

```text id="5v1m8q"
sudo
```

group.

When running:

```bash id="1q7m4v"
sudo apt update
```

Linux does:

| Step | Action                                |
| ---- | ------------------------------------- |
| 1    | sudo checks `/etc/sudoers`            |
| 2    | verifies permissions                  |
| 3    | asks for YOUR password                |
| 4    | launches command with root privileges |
| 5    | command runs with effective UID 0     |

---

# Important Concept

You authenticate using:

* YOUR password

NOT root password.

This improves:

* accountability
* logging
* individual responsibility

---

# 4. Verify Current User

Normal user:

```bash id="8m4q1v"
whoami
```

Output:

```text id="2v7m1q"
mohammad
```

---

With sudo:

```bash id="6q1m8v"
sudo whoami
```

Output:

```text id="1v4m7q"
root
```

Meaning:

* command executed as root.

---

# 5. The Sudoers File

Main configuration:

```text id="7m2q1v"
/etc/sudoers
```

Safely edited using:

```bash id="4q1m8v"
sudo visudo
```

---

# Common Ubuntu Rule

```text id="1m7q4v"
%sudo ALL=(ALL:ALL) ALL
```

Meaning:

| Part        | Meaning               |
| ----------- | --------------------- |
| `%sudo`     | members of sudo group |
| `ALL`       | any host              |
| `(ALL:ALL)` | run as any user/group |
| `ALL`       | any command           |

---

# 6. Add User To sudo Group

Ubuntu-style:

```bash id="5v2m1q"
sudo usermod -aG sudo mohammad
```

Now user gains sudo access.

---

# 7. Sudo Password Caching

After entering password once:

```bash id="7m1q8v"
sudo apt update
```

sudo temporarily remembers authentication.

Default timeout:

* usually 15 minutes

So subsequent sudo commands may not ask again.

---

# Force Password Again

```bash id="2q7m1v"
sudo -k
```

Next sudo command requires password.

---

# 8. Root Shell vs Single Command

---

## Single command

```bash id="4m1q7v"
sudo apt update
```

Safer.

---

## Full root shell

```bash id="8m2q1v"
sudo su -
```

or:

```bash id="3q7m1v"
sudo -i
```

Now:

* every command runs as root

More dangerous.

---

# 9. Difference Between `su` and `sudo`

| `su`                           | `sudo`              |
| ------------------------------ | ------------------- |
| switches user                  | runs command        |
| usually requires root password | uses your password  |
| persistent shell               | temporary elevation |
| less auditing                  | detailed logging    |

---

# 10. Running Commands As Other Users

Not only root.

Example:

```bash id="6m1q8v"
sudo -u postgres psql
```

Runs:

* `psql`
  as:
* user `postgres`

Very common for databases/services.

---

# 11. Security Logging

Sudo logs commands.

Check:

```bash id="2q4m1v"
sudo journalctl | grep sudo
```

or:

```bash id="9m1q5v"
sudo tail /var/log/auth.log
```

Useful for:

* auditing
* investigations
* enterprise security

---

# 12. Passwordless sudo

Example sudoers entry:

```text id="5v1m8q"
mohammad ALL=(ALL) NOPASSWD: ALL
```

Now sudo never asks password.

Useful for:

* automation
* scripts
* CI/CD

Dangerous on personal systems.

---

# 13. Restricting sudo Commands

Example:

```text id="1q7m4v"
mohammad ALL=(ALL) /usr/bin/systemctl restart nginx
```

Now user can ONLY:

```bash id="8m4q1v"
sudo systemctl restart nginx
```

Nothing else.

Very common in enterprises.

---

# 14. Environment Sanitization

Sudo removes dangerous environment variables.

Example:

```bash id="2v7m1q"
sudo env
```

Many variables disappear.

This prevents:

* PATH hijacking
* LD_PRELOAD attacks
* malicious environment injection

---

# 15. Why `sudo` Is Safer Than Logging As Root

| Feature                 | sudo | direct root |
| ----------------------- | ---- | ----------- |
| auditing                | yes  | weaker      |
| temporary               | yes  | no          |
| personal accountability | yes  | no          |
| least privilege         | yes  | no          |

---

# 16. Sudo Is Extremely Powerful

A user with unrestricted sudo is effectively:

* root

Because they can run:

```bash id="6q1m8v"
sudo su -
```

or:

```bash id="1v4m7q"
sudo bash
```

So:

> unrestricted sudo == full system control.

---

# 17. Enterprise Linux Practice

Organizations often:

* avoid direct root login
* use sudo-based administration
* assign limited sudo permissions
* log all elevated actions

This is foundational modern Linux security practice.
