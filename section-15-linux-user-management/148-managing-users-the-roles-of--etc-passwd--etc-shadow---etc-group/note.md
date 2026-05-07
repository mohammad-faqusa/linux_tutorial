## 148. Managing Users: The Roles of `/etc/passwd`, `/etc/shadow` & `/etc/group`

These three files are the core of Linux user management:

* `/etc/passwd`
* `/etc/shadow`
* `/etc/group`

They work together to define:

* users
* passwords
* permissions
* groups

---

# 1. `/etc/passwd`

This file stores **user account information**.

View it:

```bash
cat /etc/passwd
```

Example line:

```bash
mohammad:x:1000:1000:Mohammad:/home/mohammad:/bin/bash
```

Format:

```text
username:password_placeholder:UID:GID:comment:home_directory:login_shell
```

Explanation:

| Field            | Meaning                         |
| ---------------- | ------------------------------- |
| `mohammad`       | Username                        |
| `x`              | Password moved to `/etc/shadow` |
| `1000`           | User ID (UID)                   |
| `1000`           | Primary Group ID (GID)          |
| `Mohammad`       | Full name/comment field         |
| `/home/mohammad` | Home directory                  |
| `/bin/bash`      | Default shell                   |

---

## Important Notes

### UID

Each user has a unique ID.

Common ranges:

| UID Range | Purpose                 |
| --------- | ----------------------- |
| `0`       | root                    |
| `1-999`   | system/service accounts |
| `1000+`   | normal users            |

---

### Login Shell

Examples:

| Shell               | Meaning       |
| ------------------- | ------------- |
| `/bin/bash`         | Bash shell    |
| `/bin/zsh`          | Zsh shell     |
| `/usr/sbin/nologin` | Cannot log in |

System services often use `nologin`.

---

# 2. `/etc/shadow`

Stores **encrypted passwords** and password policies.

Only root can read it:

```bash
sudo cat /etc/shadow
```

Example:

```bash
mohammad:$y$j9T$asd123...:19800:0:99999:7:::
```

Format:

```text
username:hashed_password:last_change:min:max:warn:inactive:expire:reserved
```

---

## Important Fields

| Field           | Meaning                             |
| --------------- | ----------------------------------- |
| username        | Account name                        |
| hashed password | Encrypted password                  |
| last_change     | Days since Jan 1 1970               |
| min             | Minimum days before password change |
| max             | Maximum password age                |
| warn            | Warning days before expiration      |

---

## Why Passwords Are Here

Originally passwords were stored in `/etc/passwd`.

Problem:

* everyone can read `/etc/passwd`
* attackers could steal password hashes

Solution:

* move hashes to `/etc/shadow`
* only root can access it

This greatly improved Linux security.

---

# 3. `/etc/group`

Defines Linux groups.

View:

```bash
cat /etc/group
```

Example:

```bash
sudo:x:27:mohammad
```

Format:

```text
group_name:password_placeholder:GID:user_list
```

Explanation:

| Field      | Meaning              |
| ---------- | -------------------- |
| `sudo`     | Group name           |
| `x`        | Password placeholder |
| `27`       | Group ID             |
| `mohammad` | Users in this group  |

---

# Primary vs Secondary Groups

Every user has:

## Primary Group

Defined in `/etc/passwd`.

Example:

```text
mohammad:x:1000:1000
```

Primary GID = `1000`

---

## Supplementary Groups

Stored in `/etc/group`.

Example:

```text
sudo:x:27:mohammad
docker:x:999:mohammad
```

These give additional permissions.

---

# Relationship Between The 3 Files

## `/etc/passwd`

Defines:

* who the user is
* UID
* home
* shell
* primary group

---

## `/etc/shadow`

Defines:

* password hash
* password aging/security

---

## `/etc/group`

Defines:

* group memberships
* shared permissions

---

# Useful Commands

## Show current user info

```bash
id
```

---

## Show groups

```bash
groups
```

---

## Add user

```bash
sudo useradd username
```

---

## Set password

```bash
sudo passwd username
```

---

## Add user to sudo group

```bash
sudo usermod -aG sudo username
```

---

## Create group

```bash
sudo groupadd developers
```

---

# Why Groups Matter

Linux permissions are based on:

* Owner
* Group
* Others

Example:

```bash
-rwxr-x---
```

Meaning:

* owner: full access
* group: read/execute
* others: no access

Groups allow multiple users to share controlled access.

---

# Security Design

Linux separates:

* identity (`/etc/passwd`)
* authentication (`/etc/shadow`)
* authorization (`/etc/group`)

This separation is one reason Linux is considered secure and scalable.
