## 162. Setting File Permissions Efficiently: `chmod` with Numerical Values

In Linux, every file and directory has:

* **Owner** (user)
* **Group**
* **Permissions**

The main commands are:

* `chmod` → change permissions
* `chown` → change owner/group

---

# 1. Understanding Linux Permissions

Run:

```bash
ls -l
```

Example:

```bash
-rwxr-xr-- 1 mohammad developers 1200 May 8 test.sh
```

Breakdown:

```text
-rwxr-xr--
```

| Part | Meaning      |
| ---- | ------------ |
| `-`  | regular file |
| `d`  | directory    |
| `r`  | read         |
| `w`  | write        |
| `x`  | execute      |

Permissions are divided into 3 sections:

```text
rwx   r-x   r--
│      │      │
│      │      └── Others
│      └──────── Group
└─────────────── Owner
```

---

# 2. Permission Meanings

## For Files

| Permission | Meaning          |
| ---------- | ---------------- |
| `r`        | can read file    |
| `w`        | can modify file  |
| `x`        | can execute file |

---

## For Directories

| Permission | Meaning                |
| ---------- | ---------------------- |
| `r`        | list files             |
| `w`        | create/delete files    |
| `x`        | enter directory (`cd`) |

Important:

Without execute permission on a directory:

```bash
cd mydir
```

will fail even if you can read it.

---

# 3. `chmod` — Change Permissions

Syntax:

```bash
chmod [permissions] file
```

There are 2 main methods:

* Symbolic mode
* Numeric (octal) mode

---

# 4. Symbolic Mode

## Add permission

```bash
chmod u+x script.sh
```

Meaning:

| Symbol | Meaning     |
| ------ | ----------- |
| `u`    | user(owner) |
| `g`    | group       |
| `o`    | others      |
| `a`    | all         |

So:

```bash
u+x
```

means:

```text
add execute permission to owner
```

---

## Examples

### Add execute to everyone

```bash
chmod a+x script.sh
```

---

### Remove write from others

```bash
chmod o-w file.txt
```

---

### Give group read/write

```bash
chmod g+rw project.txt
```

---

# 5. Numeric (Octal) Mode

Each permission has a number:

| Permission | Value |
| ---------- | ----- |
| r          | 4     |
| w          | 2     |
| x          | 1     |

Add them together.

---

## Common Values

| Number | Meaning |
| ------ | ------- |
| 7      | rwx     |
| 6      | rw-     |
| 5      | r-x     |
| 4      | r--     |

---

## Example

```bash
chmod 755 script.sh
```

Breakdown:

```text
7 = rwx (owner)
5 = r-x (group)
5 = r-x (others)
```

Equivalent to:

```text
rwxr-xr-x
```

---

## Another Example

```bash
chmod 644 notes.txt
```

Meaning:

```text
rw-r--r--
```

Owner can edit, others can only read.

---

# 6. Recursive Permissions

For directories:

```bash
chmod -R 755 myfolder
```

`-R` means recursive.

Be careful with recursive changes.

---

# 7. `chown` — Change Owner

Syntax:

```bash
chown owner file
```

---

## Example

```bash
sudo chown ahmad file.txt
```

Changes owner to `ahmad`.

---

# 8. Change Owner AND Group

```bash
sudo chown ahmad:developers file.txt
```

Meaning:

* owner = ahmad
* group = developers

---

# 9. Change Only Group

Use `chgrp`:

```bash
sudo chgrp developers file.txt
```

Or:

```bash
sudo chown :developers file.txt
```

---

# 10. Recursive Ownership Change

```bash
sudo chown -R ahmad:developers myproject
```

Very common for web servers and shared folders.

---

# 11. Execute Permission Example

Suppose:

```bash
nano hello.sh
```

Content:

```bash
#!/bin/bash
echo "Hello"
```

Try running:

```bash
./hello.sh
```

You get:

```text
Permission denied
```

Because execute permission is missing.

Fix:

```bash
chmod +x hello.sh
```

Now:

```bash
./hello.sh
```

works.

---

# 12. Directory Permission Example

```bash
mkdir testdir
chmod 000 testdir
```

Now:

```bash
cd testdir
```

fails.

Because no permissions exist.

---

# 13. Common Real-World Permissions

| Permission | Usage               |
| ---------- | ------------------- |
| 755        | scripts/directories |
| 644        | normal files        |
| 700        | private files       |
| 600        | passwords/SSH keys  |

---

# 14. VERY IMPORTANT: SSH Keys

Private SSH keys MUST be restricted:

```bash
chmod 600 ~/.ssh/id_rsa
```

Otherwise SSH refuses to use them.

---

# 15. Special Permissions (Advanced)

There are advanced permissions:

* SUID
* SGID
* Sticky bit

Example:

```bash
drwxrwxrwt
```

The `t` is sticky bit (`/tmp` uses it).

You’ll learn these later.

---

# 16. Useful Commands

## See permissions

```bash
ls -l
```

---

## See owner info

```bash
stat file.txt
```

---

## Check current user

```bash
whoami
```

---

# 17. Quick Mental Model

Think of Linux permissions as:

```text
WHO can do WHAT
```

Where:

| WHO    | WHAT               |
| ------ | ------------------ |
| owner  | read/write/execute |
| group  | read/write/execute |
| others | read/write/execute |

---

# 18. Practice Exercises

Try these:

---

## Exercise 1

Create a script and make it executable.

---

## Exercise 2

Create a private directory:

```bash
mkdir secret
chmod 700 secret
```

Test access from another user.

---

## Exercise 3

Create shared group file:

```bash
sudo chown mohammad:developers shared.txt
chmod 660 shared.txt
```

---

## Exercise 4

Try weird permissions:

```bash
chmod 000 file.txt
chmod 777 file.txt
```

Observe behavior.

---

# 19. Most Important Commands to Remember

```bash
chmod +x file
chmod 755 file
chmod 644 file
chown user file
chown user:group file
```

These are used daily by Linux admins and backend developers.
