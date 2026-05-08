## 163. Managing Permissions and Ownerships for Directories


Directories in Linux behave differently from files.

Understanding directory permissions is extremely important for:

* Linux administration
* Backend deployment
* Docker volumes
* Web servers
* Shared project folders
* Databases
* AWS/Linux servers

---

# 1. Directory Permissions Overview

Directories use the same permissions:

| Permission | Meaning in Directories     |
| ---------- | -------------------------- |
| `r`        | list directory contents    |
| `w`        | create/delete/rename files |
| `x`        | enter directory (`cd`)     |

This is VERY important.

---

# 2. The Execute Permission (`x`) Is Special

For directories:

```text id="9llr9m"
x = permission to ENTER the directory
```

Without execute permission:

```bash id="69xzln"
cd mydir
```

fails even if you can read files.

---

# 3. Example Directory

Create:

```bash id="mvd0se"
mkdir project
touch project/file1.txt
```

Check:

```bash id="mn6w0w"
ls -ld project
```

Example:

```text id="sqvfxn"
drwxr-xr-x
```

Notice:

```text id="j8y7rz"
d
```

at beginning means:

```text id="qjlwm0"
this is a directory
```

---

# 4. Meaning of Directory Permissions

Example:

```text id="1r5i9x"
drwxr-x---
```

Breakdown:

| Part  | Meaning                |
| ----- | ---------------------- |
| `d`   | directory              |
| `rwx` | owner full access      |
| `r-x` | group can list + enter |
| `---` | others no access       |

---

# 5. Directory Permission Experiments

---

# Case 1 — Read Without Execute

```bash id="p7zhp6"
chmod 400 mydir
```

Meaning:

```text id="n6d92h"
r--------
```

You may list names:

```bash id="6je9rj"
ls mydir
```

But cannot enter:

```bash id="63dby8"
cd mydir
```

fails.

---

# Case 2 — Execute Without Read

```bash id="nhh4h3"
chmod 100 mydir
```

Meaning:

```text id="94e1rl"
--x------
```

You can enter:

```bash id="eb7nl5"
cd mydir
```

But cannot list files:

```bash id="sv25qs"
ls
```

fails.

Interesting Linux behavior.

---

# Case 3 — Write Without Execute

```bash id="lfdr3m"
chmod 200 mydir
```

Usually not useful.

Because without execute permission you cannot access contents.

---

# 6. Most Common Directory Permissions

| Permission | Usage                   |
| ---------- | ----------------------- |
| `755`      | normal public directory |
| `700`      | private directory       |
| `775`      | shared group directory  |
| `777`      | dangerous/public write  |

---

# 7. `755` Directory

```bash id="fhvd8y"
chmod 755 project
```

Result:

```text id="jlwmj2"
drwxr-xr-x
```

Meaning:

| User   | Permissions  |
| ------ | ------------ |
| Owner  | full control |
| Group  | read + enter |
| Others | read + enter |

Most common web/server directory permission.

---

# 8. `700` Directory

```bash id="f9tl5n"
chmod 700 secret
```

Result:

```text id="bbh2k9"
drwx------
```

Only owner can access.

Used for:

* `.ssh`
* private configs
* credentials
* backups

---

# 9. `775` Shared Directory

```bash id="0gb5tw"
chmod 775 shared
```

Result:

```text id="oefmfa"
drwxrwxr-x
```

Group members can collaborate.

Very common in teams.

---

# 10. Ownership of Directories

Check ownership:

```bash id="y8e0k0"
ls -ld project
```

Example:

```text id="8oq3q0"
drwxr-xr-x 2 mohammad developers
```

Meaning:

| Field        | Meaning |
| ------------ | ------- |
| `mohammad`   | owner   |
| `developers` | group   |

---

# 11. Change Directory Owner

```bash id="67ocmy"
sudo chown ahmad project
```

---

# 12. Change Owner and Group

```bash id="jlwm5t"
sudo chown ahmad:developers project
```

---

# 13. Recursive Ownership Changes

Very common:

```bash id="qmw2cr"
sudo chown -R www-data:www-data /var/www/myapp
```

Used in:

* Nginx
* Apache
* Docker volumes
* uploads directories

---

# 14. Recursive Permission Changes

```bash id="mb9m7h"
chmod -R 755 project
```

Applies to everything inside.

Be careful:

This changes BOTH:

* files
* directories

Sometimes not ideal.

---

# 15. Better Real-World Practice

Usually:

Directories:

```bash id="klffae"
find project -type d -exec chmod 755 {} \;
```

Files:

```bash id="sotjvh"
find project -type f -exec chmod 644 {} \;
```

This is professional practice.

Because:

* directories need execute
* files usually do NOT

---

# 16. Shared Group Collaboration

Suppose:

```text id="n5s0hj"
Group: developers
```

Add users to group:

```bash id="e8th02"
sudo usermod -aG developers ahmad
```

Then set shared directory:

```bash id="6ag86g"
sudo chown -R mohammad:developers shared
chmod -R 775 shared
```

Now group members collaborate.

Very common in companies.

---

# 17. Sticky Bit (`t`) for Shared Directories

Example:

```text id="fc8i4l"
drwxrwxrwt
```

Seen in:

```bash id="k5gc9u"
/tmp
```

Sticky bit means:

```text id="qf8gik"
users can only delete their OWN files
```

Without it, users could delete each other’s files.

---

# 18. Example: `/tmp`

Check:

```bash id="jlwm50"
ls -ld /tmp
```

Usually:

```text id="1h3l9q"
drwxrwxrwt
```

---

# 19. Secure Web Upload Directory Example

Bad:

```bash id="79v4bh"
chmod 777 uploads
```

Better:

```bash id="nmkhl8"
sudo chown www-data:www-data uploads
chmod 755 uploads
```

More secure.

---

# 20. Viewing Permissions Clearly

Use:

```bash id="30z7yy"
ls -ld directory
```

NOT:

```bash id="jlwm51"
ls -l
```

because `-d` shows directory itself.

---

# 21. Important Real-World Linux Directories

| Directory    | Typical Permissions |
| ------------ | ------------------- |
| `/home/user` | `700` or `755`      |
| `/tmp`       | `1777`              |
| `/var/www`   | `755`               |
| `.ssh`       | `700`               |

---

# 22. Numeric Permission Reminder

| Number | Meaning |
| ------ | ------- |
| 7      | rwx     |
| 6      | rw-     |
| 5      | r-x     |
| 4      | r--     |

---

# 23. Important Commands to Memorize

```bash id="jlwm52"
chmod 755 dir
chmod 700 dir
chown user dir
chown user:group dir
chmod -R 755 dir
chown -R user:group dir
```

---

# 24. Practice Exercises

---

## Exercise 1

Create private directory:

```bash id="jlwm53"
mkdir private
chmod 700 private
```

---

## Exercise 2

Create shared directory:

```bash id="jlwm54"
mkdir team
chmod 775 team
```

---

## Exercise 3

Experiment:

```bash id="jlwm55"
chmod 100 testdir
chmod 400 testdir
```

Observe differences.

---

# 25. Professional Mental Model

For directories:

```text id="jlwm56"
r = can SEE names
w = can MODIFY directory contents
x = can ENTER directory
```

This model explains nearly all Linux directory permission behavior.
