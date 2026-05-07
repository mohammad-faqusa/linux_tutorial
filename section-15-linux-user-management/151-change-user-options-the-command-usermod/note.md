## 151. Change User Options: the Command `usermod`

# 151. Change User Options: the Command `usermod`

The `usermod` command is used to modify existing user accounts.

It can change:

* groups
* shell
* home directory
* username
* UID
* account lock status
* expiration settings

---

# Basic Syntax

```bash id="4m2l0u"
sudo usermod [options] username
```

Example:

```bash id="3djlwm"
sudo usermod -s /bin/bash ahmad
```

---

# 1. Add User To A Group

Very common.

```bash id="qlf14y"
sudo usermod -aG sudo ahmad
```

Meaning:

| Option | Meaning              |
| ------ | -------------------- |
| `-a`   | append               |
| `-G`   | supplementary groups |

This adds `ahmad` to the `sudo` group.

---

# VERY IMPORTANT

Never do:

```bash id="n6qu35"
sudo usermod -G sudo ahmad
```

without `-a`.

Why?

Because it REPLACES all supplementary groups.

The user may lose:

* docker access
* audio access
* network access
* etc.

Always use:

```bash id="vqz7rq"
-aG
```

when adding groups.

---

# 2. View User Groups

```bash id="yjlwm6"
groups ahmad
```

or:

```bash id="7w9gmb"
id ahmad
```

---

# 3. Change Login Shell

Example:

```bash id="k7dqmg"
sudo usermod -s /bin/zsh ahmad
```

Check:

```bash id="c8kqmn"
grep ahmad /etc/passwd
```

---

# 4. Change Home Directory

```bash id="fjlwmv"
sudo usermod -d /new/home ahmad
```

But this only changes the path in `/etc/passwd`.

To MOVE files too:

```bash id="kk0ut6"
sudo usermod -d /new/home -m ahmad
```

`-m` = move existing contents.

---

# 5. Rename User

Example:

```bash id="bzbh4u"
sudo usermod -l mohammad ahmad
```

This changes:

* login name

BUT:

* home directory name remains unchanged unless manually modified

---

# Rename Home Directory Too

```bash id="st07tb"
sudo usermod -l mohammad -d /home/mohammad -m ahmad
```

---

# 6. Change UID

```bash id="8e6k8z"
sudo usermod -u 2000 ahmad
```

Useful when syncing users across systems.

---

# 7. Lock User Account

```bash id="3sk2hj"
sudo usermod -L ahmad
```

Unlock:

```bash id="g0fyqe"
sudo usermod -U ahmad
```

This affects password login.

---

# 8. Set Account Expiration

```bash id="hjlwm4"
sudo usermod -e 2026-12-31 ahmad
```

After that date:

* account disabled

---

# 9. Add Multiple Groups

```bash id="yjlwmu"
sudo usermod -aG sudo,docker,libvirt ahmad
```

Very common for developers.

---

# 10. Remove From Groups

`usermod` cannot directly remove one supplementary group cleanly.

Ubuntu usually uses:

```bash id="2n7ogv"
sudo deluser ahmad docker
```

instead.

---

# 11. Common Real-World Examples

## Give Docker Access

```bash id="tr4q8l"
sudo usermod -aG docker mohammad
```

---

## Give VirtualBox Access

```bash id="vjlwm8"
sudo usermod -aG vboxusers mohammad
```

---

## Give Sudo Access

```bash id="n1qg6r"
sudo usermod -aG sudo mohammad
```

---

# 12. When Changes Take Effect

Group changes often require:

## Re-login

or:

```bash id="3b5dzg"
newgrp docker
```

or full reboot sometimes.

---

# 13. Where `usermod` Changes Data

It edits:

| File          | Purpose                |
| ------------- | ---------------------- |
| `/etc/passwd` | user settings          |
| `/etc/shadow` | password/account state |
| `/etc/group`  | supplementary groups   |

---

# 14. Difference Between `passwd`, `chage`, and `usermod`

| Command   | Purpose             |
| --------- | ------------------- |
| `passwd`  | password management |
| `chage`   | password aging      |
| `usermod` | account properties  |

---

# 15. Safe Admin Workflow

Example developer setup:

```bash id="hmxjlwm"
sudo adduser developer
sudo usermod -aG sudo,docker developer
sudo passwd -e developer
```

Meaning:

* create user
* give permissions
* force password change on first login

This is a common Linux administration workflow.
