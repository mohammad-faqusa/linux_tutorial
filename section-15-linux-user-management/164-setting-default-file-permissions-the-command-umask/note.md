## 164. Setting Default File Permissions: the Command `umask`

When you create a new file or directory in Linux, permissions are NOT chosen randomly.

Linux uses something called:

```text
umask
```

to determine the **default permissions**.

---

# 1. What Is `umask`?

`umask` means:

```text
User file-creation mode mask
```

It REMOVES permissions from default values.

Important:

```text
umask does NOT add permissions
umask REMOVES permissions
```

---

# 2. Default Linux Creation Permissions

Linux starts with these defaults:

| Type        | Default Base Permissions |
| ----------- | ------------------------ |
| Files       | `666`                    |
| Directories | `777`                    |

Why files are not `777`?

Because executable permission should not automatically be given to new files.

---

# 3. How `umask` Works

Formula:

```text
final_permissions = default - umask
```

Example:

```text
Directories: 777
Files:       666
```

Suppose:

```bash
umask 022
```

Then:

---

## Directories

```text
777 - 022 = 755
```

Result:

```text
rwxr-xr-x
```

---

## Files

```text
666 - 022 = 644
```

Result:

```text
rw-r--r--
```

---

# 4. Check Current `umask`

Run:

```bash id="jlwm91"
umask
```

Example:

```text id="jlwm92"
0022
```

---

# 5. Symbolic View

Better display:

```bash id="jlwm93"
umask -S
```

Example:

```text id="jlwm94"
u=rwx,g=rx,o=rx
```

Meaning:

```text
group and others lose write permission
```

---

# 6. Real Example

Check current mask:

```bash id="jlwm95"
umask
```

Suppose:

```text id="jlwm96"
0022
```

Create file:

```bash id="jlwm97"
touch file.txt
```

Check:

```bash id="jlwm98"
ls -l file.txt
```

Result:

```text id="jlwm99"
-rw-r--r--
```

Why?

```text
666 - 022 = 644
```

---

# 7. Directory Example

```bash id="jlwm100"
mkdir project
ls -ld project
```

Result:

```text id="jlwm101"
drwxr-xr-x
```

Why?

```text
777 - 022 = 755
```

---

# 8. Changing `umask`

Example:

```bash id="’wini102"
umask 077
```

Now create files:

```bash id="’wini103"
touch secret.txt
mkdir secretdir
```

Check:

```bash id="’wini104"
ls -l
```

Result:

```text id="’wini105"
-rw-------
drwx------
```

Very private.

---

# 9. Common `umask` Values

| umask | Files | Directories | Usage          |
| ----- | ----- | ----------- | -------------- |
| `022` | 644   | 755         | normal systems |
| `002` | 664   | 775         | shared groups  |
| `077` | 600   | 700         | highly private |

---

# 10. Very Common Server Setup

Developers team:

```bash id="’wini106"
umask 002
```

Then:

| Created Item | Permissions |
| ------------ | ----------- |
| files        | `664`       |
| dirs         | `775`       |

Group collaboration becomes easier.

---

# 11. Why `umask` Is Important

Used heavily in:

* backend servers
* Docker containers
* shared projects
* deployment scripts
* CI/CD pipelines
* SSH
* databases

Bad `umask` settings can create security problems.

---

# 12. Temporary vs Permanent

---

## Temporary

```bash id="’wini107"
umask 077
```

Only affects current shell session.

---

## Permanent

Add to:

```text
~/.bashrc
```

or:

```text
~/.profile
```

Example:

```bash id="’wini108"
echo 'umask 077' >> ~/.bashrc
```

Then reload:

```bash id="’wini109"
source ~/.bashrc
```

---

# 13. Important Security Example

SSH requires strict permissions.

Example:

```bash id="’wini110"
chmod 600 ~/.ssh/id_rsa
chmod 700 ~/.ssh
```

A secure `umask` helps avoid insecure file creation.

---

# 14. Understanding the Logic

Suppose:

```bash id="’wini111"
umask 027
```

Meaning:

| Digit | Removes            |
| ----- | ------------------ |
| 0     | nothing from owner |
| 2     | write from group   |
| 7     | all from others    |

Result:

---

## Files

```text
666 - 027 = 640
```

---

## Directories

```text
777 - 027 = 750
```

---

# 15. Important Concept

`umask` does NOT subtract mathematically like decimal numbers.

It removes permission bits.

Think:

```text
permissions AND NOT umask
```

---

# 16. Practice Exercises

---

## Exercise 1

Check current mask:

```bash id="’wini112"
umask
umask -S
```

---

## Exercise 2

Set private mode:

```bash id="’wini113"
umask 077
touch secret.txt
mkdir secretdir
```

Inspect permissions.

---

## Exercise 3

Set collaborative mode:

```bash id="’wini114"
umask 002
touch shared.txt
mkdir shared
```

Inspect permissions.

---

# 17. Quick Mental Model

```text
Default permissions
        ↓
      umask removes permissions
        ↓
Final created permissions
```

---

# 18. Most Important Defaults to Remember

| Created Item | Base Permission |
| ------------ | --------------- |
| File         | 666             |
| Directory    | 777             |

Then `umask` removes permissions from them.

---

# 19. Real-World Typical Settings

| Environment            | Typical umask |
| ---------------------- | ------------- |
| Personal Linux machine | `022`         |
| Shared developer team  | `002`         |
| Secure server          | `077`         |

---

# 20. Commands to Memorize

```bash id="’wini115"
umask
umask -S
umask 022
umask 077
```

