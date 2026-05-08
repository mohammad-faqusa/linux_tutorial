## 155. Creating & Modifying Custom Groups: the Command `groupadd`

# 155. Creating & Modifying Custom Groups: the Command `groupadd`

Groups are used in Linux to:

* organize users
* share permissions
* control access
* separate roles

The main commands are:

| Command    | Purpose      |
| ---------- | ------------ |
| `groupadd` | create group |
| `groupmod` | modify group |
| `groupdel` | delete group |

---

# 1. Create A Group — `groupadd`

Basic syntax:

```bash id="8m1q4v"
sudo groupadd groupname
```

Example:

```bash id="5q7m1v"
sudo groupadd developers
```

Linux creates:

* a new group entry in `/etc/group`

---

# Verify

```bash id="2v8m1q"
grep developers /etc/group
```

Example:

```text id="4m1q7v"
developers:x:1001:
```

Format:

```text id="7q2m1v"
group_name:password_placeholder:GID:user_list
```

---

# 2. Group IDs (GID)

Every group has a unique numeric ID.

Example:

```text id="1m8q4v"
developers:x:1001:
```

Here:

* GID = `1001`

---

# View Group IDs

```bash id="4q1m7v"
getent group developers
```

or:

```bash id="8v1m4q"
cat /etc/group
```

---

# 3. Create Group With Specific GID

```bash id="2m7q1v"
sudo groupadd -g 2000 developers
```

Useful for:

* NFS/shared storage
* enterprise synchronization
* containers
* LDAP integration

---

# 4. Add Users To Group

Groups are useless until users join them.

Example:

```bash id="5m8q1v"
sudo usermod -aG developers mohammad
```

or Ubuntu-style:

```bash id="7q1m4v"
sudo adduser mohammad developers
```

---

# Verify Membership

```bash id="1v8m4q"
groups mohammad
```

---

# 5. Create Shared Team Directory

Very common workflow.

Create directory:

```bash id="4m1q7v"
sudo mkdir /backend-team
```

Assign group:

```bash id="8m2q1v"
sudo chgrp developers /backend-team
```

Set permissions:

```bash id="3q7m1v"
sudo chmod 2770 /backend-team
```

Meaning:

* shared collaboration
* automatic group inheritance via setgid

---

# 6. Modify Group Name — `groupmod`

Rename group:

```bash id="6m1q8v"
sudo groupmod -n backend developers
```

Meaning:

* old name = developers
* new name = backend

---

# Verify

```bash id="2q4m1v"
grep backend /etc/group
```

---

# 7. Change Group GID

```bash id="9m1q5v"
sudo groupmod -g 3000 backend
```

Now:

* group numeric ID changes

Useful for:

* storage consistency
* shared servers

---

# 8. Delete Group — `groupdel`

Example:

```bash id="5v1m8q"
sudo groupdel backend
```

Removes:

* group entry from `/etc/group`

---

# IMPORTANT WARNING

Cannot delete a user's PRIMARY group while user still exists.

Example:

```text id="1q7m4v"
groupdel: cannot remove the primary group of user 'mohammad'
```

Because:

* primary group linked in `/etc/passwd`

---

# 9. Difference Between Primary And Supplementary Groups

---

## Primary Group

Stored in:

```text id="8m4q1v"
/etc/passwd
```

Example:

```text id="2v7m1q"
mohammad:x:1000:1000
```

Primary GID = `1000`.

---

## Supplementary Groups

Stored in:

```text id="6q1m8v"
/etc/group
```

Example:

```text id="1v4m7q"
sudo:x:27:mohammad
docker:x:999:mohammad
```

---

# 10. Real-World Example

Suppose company has:

| Team                | Group    |
| ------------------- | -------- |
| backend developers  | backend  |
| frontend developers | frontend |
| designers           | design   |
| operations          | devops   |

Create:

```bash id="7m2q1v"
sudo groupadd backend
sudo groupadd frontend
sudo groupadd design
sudo groupadd devops
```

Assign users appropriately.

This creates role separation.

---

# 11. Group Permissions In Practice

Example file:

```text id="4q1m8v"
-rw-rw---- mohammad backend api.js
```

Meaning:

* backend group members can edit file
* others cannot

---

# 12. Check Current Groups

## Current user groups

```bash id="1m7q4v"
groups
```

---

## All system groups

```bash id="5v2m1q"
cat /etc/group
```

---

## Specific group info

```bash id="7m1q8v"
getent group backend
```

---

# 13. Enterprise Linux Perspective

Groups are fundamental to:

* RBAC (Role-Based Access Control)
* least privilege security
* multi-user collaboration

Instead of:

* giving everyone sudo/root

organizations define:

* controlled groups
* controlled permissions
* controlled resource access

This is one of the core Unix security philosophies.
