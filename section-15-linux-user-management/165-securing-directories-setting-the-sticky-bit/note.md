## 165. Securing Directories: Setting the Sticky Bit

The **sticky bit** is a special permission mainly used on **shared directories**.

It solves this problem:

```text id="x0d1bm"
How can many users write into the same directory
WITHOUT deleting each other’s files?
```

---

# 1. The Problem Without Sticky Bit

Suppose directory permissions are:

```text id="jlwm145"
drwxrwxrwx
```

(`777`)

Everyone can:

* enter
* create files
* delete files

Dangerous.

Example:

```text id="jlwm146"
User ahmad deletes mohammad's file
```

because directory write permission allows deletion.

---

# 2. Sticky Bit Solution

Sticky bit changes deletion behavior:

```text id="jlwm147"
Users can delete ONLY:
- their own files
- or if they are root
- or directory owner
```

Perfect for shared directories.

---

# 3. How Sticky Bit Appears

Example:

```text id="jlwm148"
drwxrwxrwt
```

Notice:

```text id="jlwm149"
t
```

at the end.

That means sticky bit is enabled.

---

# 4. Most Famous Example — `/tmp`

Check:

```bash id="’wini150"
ls -ld /tmp
```

Usually:

```text id="’wini151"
drwxrwxrwt
```

Meaning:

| Permission | Meaning                           |
| ---------- | --------------------------------- |
| `777`      | everyone can write                |
| `t`        | users cannot delete others' files |

---

# 5. Why `/tmp` Needs Sticky Bit

All applications use:

```text id="’wini152"
/tmp
```

for temporary files.

Without sticky bit:

```text id="’wini153"
any user could delete all temporary files
```

Huge security issue.

---

# 6. Setting Sticky Bit

## Symbolic Method

```bash id="’wini154"
chmod +t shared
```

---

## Numeric Method

Sticky bit uses leading:

```text id="’wini155"
1
```

Example:

```bash id="’wini156"
chmod 1777 shared
```

Breakdown:

| Part  | Meaning            |
| ----- | ------------------ |
| `1`   | sticky bit         |
| `777` | normal permissions |

---

# 7. Remove Sticky Bit

```bash id="’wini157"
chmod -t shared
```

or:

```bash id="’wini158"
chmod 0777 shared
```

---

# 8. Real Experiment

Create shared directory:

```bash id="’wini159"
mkdir shared
chmod 777 shared
```

Now all users can delete each other's files.

---

Enable sticky bit:

```bash id="’wini160"
chmod +t shared
```

Check:

```bash id="’wini161"
ls -ld shared
```

Result:

```text id="’wini162"
drwxrwxrwt
```

Now deletion becomes restricted.

---

# 9. Lowercase `t` vs Uppercase `T`

---

## Lowercase `t`

```text id="’wini163"
drwxrwxrwt
```

means:

```text id="’wini164"
sticky bit + execute permission exists
```

---

## Uppercase `T`

```text id="’wini165"
drwxrwxrwT
```

means:

```text id="’wini166"
sticky bit exists BUT execute permission missing
```

Usually not useful.

---

# 10. Important Detail About Deleting Files

In Linux:

```text id="’wini167"
Deleting depends on DIRECTORY permissions
NOT file permissions
```

Even if file is:

```text id="’wini168"
-r--------
```

you can still delete it if directory allows.

This surprises many beginners.

---

# 11. Sticky Bit on Files (Old Behavior)

Historically sticky bit on executable files meant:

```text id="’wini169"
keep program in swap memory
```

Modern Linux ignores this behavior for normal files.

Today sticky bit is mainly meaningful on directories.

---

# 12. Common Special Permissions

| Special Bit | Numeric | Meaning            |
| ----------- | ------- | ------------------ |
| SUID        | 4       | run as owner       |
| SGID        | 2       | inherit group      |
| Sticky      | 1       | protected deletion |

These become leading digit in chmod.

---

# 13. Combined Example

```bash id="’wini170"
chmod 2775 shared
```

Meaning:

| Part  | Meaning   |
| ----- | --------- |
| `2`   | SGID      |
| `775` | rwxrwxr-x |

Files inherit group.

---

Another:

```bash id="’wini171"
chmod 1777 public
```

Meaning:

| Part  | Meaning         |
| ----- | --------------- |
| `1`   | sticky          |
| `777` | everyone access |

---

# 14. Viewing Special Permissions

Example:

```bash id="’wini172"
ls -ld /tmp
```

Output:

```text id="’wini173"
drwxrwxrwt
```

The last character indicates sticky bit.

---

# 15. Real-World Usage

Sticky bit commonly used for:

| Directory                 | Why                    |
| ------------------------- | ---------------------- |
| `/tmp`                    | shared temp files      |
| public upload dirs        | prevent cross-deletion |
| shared collaboration dirs | protect user files     |

---

# 16. Practice Exercises

---

## Exercise 1

Create test directory:

```bash id="’wini174"
mkdir teststicky
chmod 777 teststicky
```

---

## Exercise 2

Enable sticky bit:

```bash id="’wini175"
chmod +t teststicky
```

---

## Exercise 3

Inspect:

```bash id="’wini176"
ls -ld teststicky
```

---

# 17. Important Mental Model

Sticky bit means:

```text id="’wini177"
shared writing
WITHOUT shared deletion
```

---

# 18. Commands to Memorize

```bash id="’wini178"
chmod +t dir
chmod 1777 dir
chmod -t dir
ls -ld dir
```

These are extremely important for Linux administration and multi-user systems.
