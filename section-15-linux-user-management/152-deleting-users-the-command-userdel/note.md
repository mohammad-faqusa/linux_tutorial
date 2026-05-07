## 152. Deleting Users: the Command `userdel`

# 152. Deleting Users: the Command `userdel`

The `userdel` command removes user accounts from Linux.

It can:

* delete the account
* optionally remove the home directory
* remove mail spool
* clean account database entries

---

# Basic Syntax

```bash id="40g5e2"
sudo userdel username
```

Example:

```bash id="egjlwm"
sudo userdel ahmad
```

This removes:

* `/etc/passwd` entry
* `/etc/shadow` entry
* `/etc/group` references

BUT:

* keeps the home directory
* keeps user files

---

# 1. Delete User + Home Directory

Most common option:

```bash id="p3wq5o"
sudo userdel -r ahmad
```

`-r` means:

> remove home directory and mail spool

This deletes:

```text id="hjlwmn"
/home/ahmad
```

too.

---

# 2. What Gets Modified

`userdel` edits:

| File          | Purpose                   |
| ------------- | ------------------------- |
| `/etc/passwd` | removes user              |
| `/etc/shadow` | removes password data     |
| `/etc/group`  | removes group memberships |

---

# 3. Check Existing Users

List normal users:

```bash id="8xpd0m"
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
```

---

# 4. Common Problem: User Is Logged In

Linux may refuse:

```text id="8e0z5s"
userdel: user is currently used by process
```

because:

* shell still active
* background process running
* GUI session exists

---

# Find User Processes

```bash id="jlwmq1"
ps -u ahmad
```

---

# Kill Processes

```bash id="z2p8uv"
sudo pkill -u ahmad
```

Then retry:

```bash id="f4p5xg"
sudo userdel -r ahmad
```

---

# 5. Check If User Exists

```bash id="0h5tkr"
id ahmad
```

If deleted:

```text id="i7yjlwm"
id: ‘ahmad’: no such user
```

---

# 6. What About The User's Group?

Many distros create:

* user `ahmad`
* group `ahmad`

called a User Private Group (UPG).

Sometimes `userdel` removes it automatically.

If not:

```bash id="jlwmfj"
sudo groupdel ahmad
```

---

# 7. Important Safety Warnings

Avoid deleting:

* `root`
* system users
* active service accounts

unless you understand the consequences.

Deleting wrong accounts can:

* break services
* prevent login
* damage package behavior

---

# 8. System Users vs Normal Users

Example system accounts:

```text id="jlwm7m"
gdm
daemon
www-data
systemd-network
```

These run services.

Normal users usually have:

| UID     | Type           |
| ------- | -------------- |
| `0`     | root           |
| `1-999` | system/service |
| `1000+` | human users    |

---

# 9. Difference Between Locking and Deleting

## Lock User

```bash id="2cjlwm"
sudo passwd -l ahmad
```

User still exists:

* files preserved
* ownership preserved
* history preserved

---

## Delete User

```bash id="8c1gk8"
sudo userdel -r ahmad
```

Account removed entirely.

---

# 10. Why Enterprises Often Prefer Locking

Deleting users can:

* break file ownership
* complicate audits
* remove forensic evidence

So companies often:

* lock accounts
* archive home directories

instead of deleting immediately.

---

# 11. Orphaned Files Problem

After deleting a user:

* files outside home directory may remain

Example:

```text id="qjlwm7"
/var/www/
/opt/
/srv/
/tmp/
```

Those files still keep the old numeric UID.

---

# Find Orphaned Files

Example:

```bash id="t5djlwm"
sudo find / -uid 1001
```

Very useful for cleanup.

---

# 12. Real-World Admin Workflow

Example:

## Disable immediately

```bash id="jlwmv5"
sudo passwd -l developer
```

## Kill active sessions

```bash id="r9mjlwm"
sudo pkill -u developer
```

## Archive files

```bash id="jlwm0z"
sudo tar -czf developer-home.tar.gz /home/developer
```

## Delete account later

```bash id="jlwm5g"
sudo userdel -r developer
```

This is a common production workflow.
