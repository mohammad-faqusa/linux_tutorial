## 153. How do Groups work?

# 153. How Do Groups Work?

Groups in Linux are a permission-management mechanism.

They allow:

* multiple users
* to share access
* to files, devices, and resources

without giving everyone full system access.

---

# 1. Why Groups Exist

Suppose you have:

* developers
* designers
* admins

You do NOT want every user to:

* own every file
* use sudo
* access all devices

Instead, Linux uses groups.

---

# 2. Linux Permission Model

Every file has:

| Property | Meaning       |
| -------- | ------------- |
| Owner    | one user      |
| Group    | one group     |
| Others   | everyone else |

View with:

```bash id="6djlwm"
ls -l
```

Example:

```text id="jlwm0k"
-rw-r----- 1 mohammad developers 1200 file.txt
```

Meaning:

| Part         | Meaning     |
| ------------ | ----------- |
| `mohammad`   | owner       |
| `developers` | group owner |

---

# 3. Permission Bits

Example:

```text id="jlwm3x"
-rwxr-x---
```

Split into:

```text id="jlwm5z"
owner | group | others
rwx   r-x     ---
```

Meaning:

| Entity | Permissions        |
| ------ | ------------------ |
| owner  | read/write/execute |
| group  | read/execute       |
| others | no access          |

---

# 4. How Linux Checks Permissions

When user accesses a file:

Linux checks in order:

1. Is user owner?
2. Else, is user in file's group?
3. Else, use "others" permissions.

---

# Example

File:

```text id="jlwm7z"
-rw-r----- mohammad developers report.txt
```

User:

* `ahmad`
* member of `developers`

Result:

* can read file

But:

* cannot write
* because group lacks `w`

---

# 5. Viewing Groups

## Current user groups

```bash id="wjglwm"
groups
```

or:

```bash id="x0jlwm"
id
```

---

# Example Output

```text id="jlwm1y"
uid=1000(mohammad)
gid=1000(mohammad)
groups=1000(mohammad),27(sudo),999(docker)
```

Meaning:

* primary group = `mohammad`
* supplementary groups = `sudo`, `docker`

---

# 6. Primary vs Supplementary Groups

---

## Primary Group

Stored in `/etc/passwd`.

Usually:

* default group for new files

Example:

```text id="jlwm4z"
mohammad:x:1000:1000
```

Primary GID = `1000`.

---

## Supplementary Groups

Stored in `/etc/group`.

Example:

```text id="jlwm8n"
sudo:x:27:mohammad
docker:x:999:mohammad
```

These grant extra permissions.

---

# 7. Creating Groups

```bash id="jlwm6p"
sudo groupadd developers
```

---

# 8. Add User To Group

```bash id="jlwm5j"
sudo usermod -aG developers mohammad
```

---

# 9. Change File Group

```bash id="4mjlwm"
sudo chgrp developers project.txt
```

Now members of `developers` inherit group permissions.

---

# 10. Shared Collaboration Example

Create shared directory:

```bash id="2qjlwm"
mkdir project
```

Set group:

```bash id="3njlwm"
sudo chgrp developers project
```

Set permissions:

```bash id="6jlwm0"
chmod 770 project
```

Meaning:

* owner: full access
* group: full access
* others: none

Perfect for team collaboration.

---

# 11. Special Group Examples

Linux uses groups for hardware/devices too.

| Group     | Purpose                |
| --------- | ---------------------- |
| `sudo`    | administrative access  |
| `docker`  | Docker daemon access   |
| `audio`   | sound devices          |
| `video`   | GPU/video devices      |
| `plugdev` | removable devices      |
| `lpadmin` | printer administration |

---

# 12. Why Docker Group Is Dangerous

Example:

```bash id="6vjlwm"
sudo usermod -aG docker mohammad
```

Looks harmless.

But Docker group members can often:

* mount host filesystem
* access root-equivalent containers

So:

> Docker group is effectively root-level access.

Very important security concept.

---

# 13. Setgid Directories

Advanced group-sharing feature.

Example:

```bash id="9jlwm1"
chmod g+s shared_dir
```

Now:

* new files inherit directory's group automatically

Very useful for team folders.

---

# Example

Without setgid:

```text id="0jlwm5"
new file -> creator's primary group
```

With setgid:

```text id="1jlwm7"
new file -> directory group
```

---

# 14. File Ownership Commands

## Change owner

```bash id="2jlwm8"
sudo chown mohammad file.txt
```

---

## Change owner + group

```bash id="3jlwm9"
sudo chown mohammad:developers file.txt
```

---

## Change only group

```bash id="4jlwm0"
sudo chgrp developers file.txt
```

---

# 15. Important Security Principle

Groups implement:

> role-based access control (RBAC)

Instead of giving everyone root access:

* assign controlled group permissions

This is foundational in Linux security.

---

# 16. Real-World Example

Web server setup:

```text id="5jlwm2"
/var/www
```

owned by:

```text id="6jlwm3"
root:www-data
```

Developers added to:

```text id="7jlwm4"
www-data
```

Now:

* web team can edit website
* others cannot

without needing sudo.

---

# 17. Summary

Groups allow Linux to:

* organize users
* share resources
* enforce permissions
* avoid excessive root usage

They are one of the most fundamental concepts in Unix/Linux administration.
