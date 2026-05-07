## 149. Creating and Securing New Users: `useradd` & `passwd`

Linux manages users mainly with two commands:

* `useradd` → creates the account
* `passwd` → sets or changes the password

---

# 1. Creating a User — `useradd`

Basic syntax:

```bash id="fd8lyh"
sudo useradd username
```

Example:

```bash id="6d85x2"
sudo useradd ahmad
```

This creates:

* user entry in `/etc/passwd`
* entry in `/etc/shadow`
* usually a group with same name

BUT:

* no password yet
* possibly no home directory depending on distro

---

# 2. Create User With Home Directory

Usually preferred:

```bash id="rjlwm7"
sudo useradd -m ahmad
```

`-m` means:

> create `/home/ahmad`

---

# 3. Set Password — `passwd`

After creating the user:

```bash id="x10f9z"
sudo passwd ahmad
```

Linux will ask:

```text id="7lb6i5"
New password:
Retype new password:
```

Now the account becomes usable.

---

# 4. Verify User Creation

Check:

```bash id="6gw9kc"
cat /etc/passwd | grep ahmad
```

Example output:

```text id="mk0g7n"
ahmad:x:1001:1001::/home/ahmad:/bin/sh
```

---

# 5. Verify Home Directory

```bash id="wq68yc"
ls /home
```

You should see:

```text id="tftc1s"
ahmad
```

---

# 6. Switch To The User

```bash id="cckpmu"
su - ahmad
```

or:

```bash id="2n42b0"
sudo su - ahmad
```

---

# 7. Important `useradd` Options

| Option | Meaning                  |
| ------ | ------------------------ |
| `-m`   | Create home directory    |
| `-d`   | Custom home directory    |
| `-s`   | Specify shell            |
| `-G`   | Add supplementary groups |
| `-u`   | Specify UID              |
| `-c`   | Comment/full name        |

---

# Examples

## Create user with Bash shell

```bash id="bjj0dx"
sudo useradd -m -s /bin/bash ahmad
```

---

## Add user directly to sudo group

```bash id="cly5o2"
sudo useradd -m -G sudo ahmad
```

---

## Create service account with no login

```bash id="5dprha"
sudo useradd -r -s /usr/sbin/nologin nginxuser
```

---

# 8. Password Security — `passwd`

## Change your own password

```bash id="v5j9r8"
passwd
```

---

## Change another user's password

```bash id="s6mbhq"
sudo passwd ahmad
```

---

# 9. Lock A User Account

Disable login without deleting:

```bash id="0j0l6k"
sudo passwd -l ahmad
```

Unlock:

```bash id="e4y7jw"
sudo passwd -u ahmad
```

---

# 10. Expire Passwords

Force password reset on next login:

```bash id="2yrd7y"
sudo passwd -e ahmad
```

---

# 11. Password Policies

View policy:

```bash id="g35lwi"
sudo chage -l ahmad
```

Set expiration:

```bash id="w8l0g7"
sudo chage -M 90 ahmad
```

Meaning:

* password expires after 90 days

---

# 12. Difference Between `useradd` and `adduser`

## `useradd`

Low-level utility:

* minimal
* manual
* script-friendly

---

## `adduser`

Friendlier interactive wrapper (Debian/Ubuntu):

```bash id="mj17rp"
sudo adduser ahmad
```

It:

* creates home directory
* asks for password
* asks for user info
* configures account automatically

Ubuntu users often prefer `adduser`.

---

# 13. Recommended Ubuntu Practice

Instead of:

```bash id="wbyf5u"
sudo useradd -m ahmad
sudo passwd ahmad
```

Ubuntu admins commonly use:

```bash id="7u8v20"
sudo adduser ahmad
```

because it is simpler and safer for beginners.

---

# 14. Where User Data Gets Stored

Creating a user modifies:

| File             | Purpose           |
| ---------------- | ----------------- |
| `/etc/passwd`    | user info         |
| `/etc/shadow`    | password hash     |
| `/etc/group`     | group memberships |
| `/home/username` | personal files    |

---

# 15. Typical Real-World Flow

Create developer account:

```bash id="c5i7y7"
sudo adduser developer
sudo usermod -aG sudo developer
```

Verify:

```bash id="slv2wc"
id developer
```

Switch:

```bash id="i1r21o"
su - developer
```

This is a very common Linux administration workflow.
