## 161. Assigning & Changing File Permissions with `chmod` & `chown`

# 161. Assigning & Changing File Permissions with `chmod` & `chown`

Linux file security is mainly controlled using:

| Command | Purpose            |
| ------- | ------------------ |
| `chmod` | change permissions |
| `chown` | change owner       |
| `chgrp` | change group       |

These are foundational Linux administration commands.

---

# 1. Understanding Linux File Permissions

View permissions:

```bash id="4m1q7v"
ls -l
```

Example:

```text id="8m2q1v"
-rwxr-x--- 1 mohammad developers 1200 app.sh
```

---

# Breakdown

```text id="3q7m1v"
- rwx r-x ---
  |   |   |
  |   |   └── others
  |   └────── group
  └────────── owner
```

---

# Permission Meanings

| Symbol | Meaning |
| ------ | ------- |
| `r`    | read    |
| `w`    | write   |
| `x`    | execute |

---

# Categories

| Category | Meaning       |
| -------- | ------------- |
| owner    | file owner    |
| group    | group members |
| others   | everyone else |

---

# Example Meaning

```text id="6m1q8v"
-rwxr-x---
```

| Entity | Permissions |
| ------ | ----------- |
| owner  | rwx         |
| group  | r-x         |
| others | ---         |

---

# 2. `chmod` — Change Permissions

Basic syntax:

```bash id="2q4m1v"
chmod permissions file
```

---

# Numeric Mode

Most common method.

Example:

```bash id="9m1q5v"
chmod 755 script.sh
```

---

# Numeric Values

| Number | Permission |
| ------ | ---------- |
| 7      | rwx        |
| 6      | rw-        |
| 5      | r-x        |
| 4      | r--        |
| 0      | ---        |

---

# Example

```text id="5v1m8q"
755
```

means:

| Category | Permissions |
| -------- | ----------- |
| owner    | rwx         |
| group    | r-x         |
| others   | r-x         |

---

# Another Example

```bash id="1q7m4v"
chmod 600 secret.txt
```

Result:

```text id="8m4q1v"
-rw-------
```

Only owner can read/write.

Very common for:

* SSH keys
* passwords
* secrets

---

# 3. Symbolic Mode

Instead of numbers:

```bash id="2v7m1q"
chmod u+x script.sh
```

Meaning:

* add execute to user(owner)

---

# Symbols

| Symbol | Meaning     |
| ------ | ----------- |
| `u`    | user(owner) |
| `g`    | group       |
| `o`    | others      |
| `a`    | all         |

---

# Operations

| Symbol | Meaning           |
| ------ | ----------------- |
| `+`    | add permission    |
| `-`    | remove permission |
| `=`    | set exactly       |

---

# Examples

---

## Add execute for everyone

```bash id="6q1m8v"
chmod a+x script.sh
```

---

## Remove write from group

```bash id="1v4m7q"
chmod g-w file.txt
```

---

## Give only owner read/write

```bash id="7m2q1v"
chmod go-rwx secret.txt
```

---

# 4. Executable Files

Without execute permission:

```bash id="4q1m8v"
./script.sh
```

fails.

Enable execution:

```bash id="1m7q4v"
chmod +x script.sh
```

Now executable.

---

# 5. Recursive Permissions

Directories recursively:

```bash id="5v2m1q"
chmod -R 755 website/
```

Be VERY careful with `-R`.

Incorrect recursive permissions can:

* expose private files
* break applications

---

# 6. `chown` — Change Owner

Basic syntax:

```bash id="7m1q8v"
sudo chown user file
```

Example:

```bash id="2q7m1v"
sudo chown mohammad report.txt
```

Now:

* owner becomes mohammad.

---

# Change Owner AND Group

```bash id="4m1q7v"
sudo chown mohammad:developers report.txt
```

Meaning:

| Part       | Meaning |
| ---------- | ------- |
| mohammad   | owner   |
| developers | group   |

---

# Verify

```bash id="8m2q1v"
ls -l report.txt
```

Example:

```text id="3q7m1v"
-rw-r--r-- mohammad developers report.txt
```

---

# 7. `chgrp` — Change Group Only

Example:

```bash id="6m1q8v"
sudo chgrp developers report.txt
```

Changes:

* only group ownership

---

# 8. Real-World Example

Suppose:

```text id="2q4m1v"
/var/www/project
```

should belong to:

* user `www-data`
* group `developers`

Run:

```bash id="9m1q5v"
sudo chown -R www-data:developers /var/www/project
```

Now:

* web server owns files
* developers collaborate through group

---

# 9. Shared Collaboration Setup

Create shared folder:

```bash id="5v1m8q"
mkdir shared
```

Assign group:

```bash id="1q7m4v"
sudo chgrp developers shared
```

Enable collaboration:

```bash id="8m4q1v"
chmod 2770 shared
```

Meaning:

* full owner/group access
* setgid inheritance
* no public access

---

# 10. Dangerous Permissions

---

## `777`

```bash id="2v7m1q"
chmod 777 file
```

Result:

```text id="6q1m8v"
rwxrwxrwx
```

EVERYONE can:

* read
* write
* execute

Usually VERY dangerous.

---

# Why Beginners Overuse 777

It “fixes permission denied”.

But it destroys security.

Professional admins rarely use:

* 777

except very special cases like:

* `/tmp`

---

# 11. Special Permissions

---

## setuid

```bash id="1v4m7q"
chmod 4755 program
```

Runs executable as owner.

---

## setgid

```bash id="7m2q1v"
chmod 2770 shared_dir
```

New files inherit directory group.

---

## sticky bit

```bash id="4q1m8v"
chmod 1777 /tmp
```

Users can only delete their own files.

---

# 12. Ownership vs Permissions

VERY important distinction.

---

## Ownership

Who owns the file?

Changed by:

* `chown`
* `chgrp`

---

## Permissions

What actions are allowed?

Changed by:

* `chmod`

---

# Example

You may own file but still:

```text id="1m7q4v"
chmod 400 myfile
```

Now:

* you cannot write it yourself.

Because permissions deny it.

---

# 13. Enterprise Linux Practice

Organizations carefully use:

* groups
* ownership
* restricted permissions

to enforce:

* least privilege
* secure collaboration
* service isolation

This is one of the foundations of Unix/Linux security design.
