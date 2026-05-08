## 154. Add and Remove Group Members with `usermod`, `adduser`, `deluser`

# 154. Add and Remove Group Members with `usermod`, `adduser`, `deluser`

Linux allows users to belong to multiple groups.

This is how:

* permissions
* administrative access
* device access
* collaboration

are managed.

The most common tools are:

| Command   | Purpose                        |
| --------- | ------------------------------ |
| `usermod` | low-level account modification |
| `adduser` | friendly Debian/Ubuntu wrapper |
| `deluser` | remove user from group         |

---

# 1. Add User To A Group — `usermod`

Most common method:

```bash id="1m7v4q"
sudo usermod -aG developers mohammad
```

Meaning:

| Option | Meaning              |
| ------ | -------------------- |
| `-a`   | append               |
| `-G`   | supplementary groups |

This adds:

* `mohammad`
  to:
* `developers`

---

# VERY IMPORTANT WARNING

Never forget `-a`.

BAD:

```bash id="8q2m5v"
sudo usermod -G developers mohammad
```

This REPLACES all supplementary groups.

User may lose:

* sudo access
* docker access
* audio access
* networking access

---

# CORRECT

```bash id="5v1n8q"
sudo usermod -aG developers mohammad
```

---

# 2. Verify Group Membership

```bash id="3k7m1v"
groups mohammad
```

or:

```bash id="6q2n4t"
id mohammad
```

Example:

```text id="9m1v5x"
mohammad : mohammad sudo docker developers
```

---

# 3. Add User Using `adduser`

Ubuntu/Debian provides friendlier syntax:

```bash id="4n8q1v"
sudo adduser mohammad developers
```

Meaning:

* add user `mohammad`
* to group `developers`

This is very readable.

---

# Internally

It modifies:

```text id="7v2m5q"
/etc/group
```

Example before:

```text id="1q8m4v"
developers:x:1001:
```

After:

```text id="5n1v7k"
developers:x:1001:mohammad
```

---

# 4. Remove User From Group — `deluser`

Example:

```bash id="8m4q2v"
sudo deluser mohammad developers
```

Meaning:

* remove user from supplementary group

---

# Example Result

Before:

```text id="2v7m1n"
developers:x:1001:mohammad
```

After:

```text id="6q1m8v"
developers:x:1001:
```

---

# 5. Difference Between Primary and Supplementary Groups

---

## Primary Group

Stored in:

```text id="3m8v1q"
/etc/passwd
```

Example:

```text id="5q2n7v"
mohammad:x:1000:1000
```

Primary GID = `1000`.

---

## Supplementary Groups

Stored in:

```text id="8v1m4q"
/etc/group
```

Example:

```text id="1n7q5v"
sudo:x:27:mohammad
docker:x:999:mohammad
```

---

# 6. Real-World Group Examples

---

## Give Docker Access

```bash id="4q8v1m"
sudo usermod -aG docker mohammad
```

Now user can run:

```bash id="7m1q5v"
docker ps
```

without sudo.

---

## Give VirtualBox Access

```bash id="2q7v1m"
sudo usermod -aG vboxusers mohammad
```

---

## Give Administrative Access

```bash id="5m8v2q"
sudo usermod -aG sudo mohammad
```

---

# 7. When Changes Take Effect

Group membership updates often require:

* logout/login
* reboot
* new shell session

because current session cached old groups.

---

# Temporary Refresh

```bash id="1v4q8m"
newgrp developers
```

This starts a shell using the new group.

---

# 8. How Linux Uses Groups

When accessing a file:

Linux checks:

1. owner
2. group membership
3. others

So group membership directly affects:

* read access
* write access
* execute access

---

# 9. Shared Team Example

Create group:

```bash id="7q1m4v"
sudo groupadd backend-team
```

Add users:

```bash id="5v8m2q"
sudo adduser mohammad backend-team
sudo adduser ahmad backend-team
```

Create shared folder:

```bash id="2m7v1q"
sudo mkdir /backend
sudo chgrp backend-team /backend
sudo chmod 2770 /backend
```

Now:

* both developers collaborate safely
* no sudo needed

---

# 10. View All Groups

```bash id="8q4m1v"
cat /etc/group
```

---

# 11. View Members Of One Group

Example:

```bash id="5m1q7v"
getent group developers
```

Output:

```text id="2v8m4q"
developers:x:1001:mohammad,ahmad
```

Very useful for scripting/admin work.

---

# 12. Enterprise Perspective

Groups implement:

* role separation
* least privilege access
* team collaboration

Instead of:

* giving everyone root access

Organizations create:

* developers
* qa
* devops
* finance
* webadmins

each with controlled permissions.

This is one of the core security models of Linux.
