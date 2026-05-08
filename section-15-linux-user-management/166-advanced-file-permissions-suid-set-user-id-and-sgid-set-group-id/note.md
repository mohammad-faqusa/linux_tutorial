## 166. Advanced File Permissions: SUID (Set User ID) and SGID (Set Group ID)

Linux has 3 special permission bits:

| Bit | Name       |
| --- | ---------- |
| `4` | SUID       |
| `2` | SGID       |
| `1` | Sticky Bit |

You already learned sticky bit.

Now the important advanced ones:

* SUID
* SGID

These are heavily used in Linux systems.

---

# 1. SUID — Set User ID

SUID means:

```text id="jlwm179"
run executable as FILE OWNER
instead of current user
```

Very important concept.

---

# 2. Normal Execution

Suppose:

```text id="jlwm180"
Owner: root
File: app
Permissions: normal executable
```

When `ahmad` runs it:

```text id="jlwm181"
program runs as ahmad
```

Normal behavior.

---

# 3. With SUID

If SUID is enabled:

```text id="’wini182"
program runs as OWNER
```

even when another user executes it.

---

# 4. Famous Example — `passwd`

Check:

```bash id="’wini183"
ls -l /usr/bin/passwd
```

Usually:

```text id="’wini184"
-rwsr-xr-x
```

Notice:

```text id="’wini185"
s
```

instead of:

```text id="’wini186"
x
```

---

# 5. Why `passwd` Needs SUID

Changing passwords requires writing to:

```text id="’wini187"
/etc/shadow
```

Normal users cannot modify that file.

But users CAN change their passwords using:

```bash id="’wini188"
passwd
```

How?

Because:

```text id="’wini189"
passwd runs as root temporarily
```

via SUID.

---

# 6. Setting SUID

## Symbolic

```bash id="’wini190"
chmod u+s app
```

---

## Numeric

SUID uses leading:

```text id="’wini191"
4
```

Example:

```bash id="’wini192"
chmod 4755 app
```

Breakdown:

| Part  | Meaning            |
| ----- | ------------------ |
| `4`   | SUID               |
| `755` | normal permissions |

---

# 7. Viewing SUID

Example:

```text id="’wini193"
-rwsr-xr-x
```

The owner execute bit becomes:

```text id="’wini194"
s
```

---

# 8. Lowercase `s` vs Uppercase `S`

---

## Lowercase `s`

```text id="’wini195"
rws
```

means:

```text id="’wini196"
SUID + execute permission exists
```

---

## Uppercase `S`

```text id="’wini197"
rwS
```

means:

```text id="’wini198"
SUID exists BUT executable bit missing
```

Usually useless.

---

# 9. SGID — Set Group ID

SGID has TWO meanings:

| Applied To       | Meaning                 |
| ---------------- | ----------------------- |
| executable files | run with file group     |
| directories      | inherit directory group |

---

# 10. SGID on Executables

Example:

```text id="’wini199"
-rwxr-sr-x
```

Program runs with:

```text id="’wini200"
group permissions of file
```

Less common than SUID.

---

# 11. SGID on Directories (Very Important)

This is VERY common.

Suppose:

```bash id="’wini201"
mkdir shared
chown :developers shared
chmod 2775 shared
```

---

# 12. Meaning of `2775`

| Part  | Meaning            |
| ----- | ------------------ |
| `2`   | SGID               |
| `775` | normal permissions |

---

# 13. What SGID Directory Does

Normally:

new files inherit creator's default group.

BUT with SGID:

```text id="’wini202"
new files inherit DIRECTORY group
```

Perfect for teams.

---

# 14. Example

Directory:

```text id="’wini203"
drwxrwsr-x
```

Notice:

```text id="’wini204"
s
```

in group execute position.

---

Suppose:

```text id="’wini205"
Group = developers
```

Then any new file created inside automatically becomes:

```text id="’wini206"
group = developers
```

even if creator’s primary group differs.

---

# 15. Real-World Uses

SGID directories used heavily for:

* shared repositories
* web projects
* team collaboration
* Docker shared volumes
* company shared folders

---

# 16. Remove SUID / SGID

---

## Remove SUID

```bash id="’wini207"
chmod u-s file
```

---

## Remove SGID

```bash id="’wini208"
chmod g-s file
```

---

# 17. Finding SUID Files

Very useful security command:

```bash id="’wini209"
find / -perm -4000 2>/dev/null
```

Finds all SUID files.

---

# 18. Finding SGID Files

```bash id="’wini210"
find / -perm -2000 2>/dev/null
```

---

# 19. Security Importance

SUID programs are security-sensitive.

Why?

Because they execute with elevated permissions.

Badly written SUID programs can become:

```text id="’wini211"
privilege escalation vulnerabilities
```

Huge security topic.

---

# 20. Why SUID on Scripts Is Usually Disabled

Linux usually ignores SUID on shell scripts.

Reason:

```text id="’wini212"
security risks
```

Race conditions and interpreter attacks.

SUID mainly works reliably with compiled binaries.

---

# 21. Combined Special Bits

Leading digit combines:

| Digit | Meaning |
| ----- | ------- |
| `4`   | SUID    |
| `2`   | SGID    |
| `1`   | Sticky  |

Example:

```bash id="’wini213"
chmod 6755 file
```

Means:

| Part  | Meaning            |
| ----- | ------------------ |
| `6`   | SUID + SGID        |
| `755` | normal permissions |

---

# 22. Visual Summary

| Permission | Appearance             |
| ---------- | ---------------------- |
| SUID       | `rws`                  |
| SGID       | `rws` in group section |
| Sticky     | `t`                    |

---

# 23. Important Mental Models

---

## SUID

```text id="’wini214"
Run as OWNER
```

---

## SGID on executable

```text id="’wini215"
Run as GROUP
```

---

## SGID on directory

```text id="’wini216"
inherit directory group
```

---

## Sticky Bit

```text id="’wini217"
protect deletion in shared dirs
```

---

# 24. Practice Exercises

---

## Check passwd SUID

```bash id="’wini218"
ls -l /usr/bin/passwd
```

---

## Create SGID directory

```bash id="’wini219"
mkdir shared
chmod 2775 shared
ls -ld shared
```

---

## Find SUID programs

```bash id="’wini220"
find / -perm -4000 2>/dev/null
```

---

# 25. Commands to Memorize

```bash id="’wini221"
chmod 4755 file
chmod 2755 dir
chmod u+s file
chmod g+s dir
find / -perm -4000
find / -perm -2000
```

These are extremely important in Linux administration, security, DevOps, and backend infrastructure.
