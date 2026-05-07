## 150. Extra lecture (optional): How Password Expiration works

# 150. Extra Lecture: How Password Expiration Works

Linux can enforce password aging policies for security.

This helps:

* force periodic password changes
* disable forgotten accounts
* reduce risk of stolen passwords

Password expiration settings are mainly stored in:

```text id="j7j3v5"
/etc/shadow
```

---

# 1. The Relevant `/etc/shadow` Fields

Example:

```text id="90tw6i"
mohammad:$6$hash:20578:0:90:7:14::
```

Format:

```text id="2gqvfx"
username:hash:last:min:max:warn:inactive:expire:reserved
```

Important expiration fields:

| Field      | Meaning                            |
| ---------- | ---------------------------------- |
| `last`     | Last password change               |
| `min`      | Minimum days before changing again |
| `max`      | Maximum password age               |
| `warn`     | Warning days before expiration     |
| `inactive` | Disable account after expiration   |
| `expire`   | Absolute account expiration date   |

---

# 2. How Linux Calculates Expiration

Linux stores dates as:

> days since Jan 1, 1970

Example:

```text id="jpk18g"
20578
```

means:

* password last changed 20,578 days after Jan 1 1970

---

# 3. Example Expiration Flow

Suppose:

```text id="6bd0z7"
last = 20578
max  = 90
warn = 7
```

Meaning:

* password valid for 90 days
* warning begins 7 days before expiration

So:

| Day   | Result           |
| ----- | ---------------- |
| 20578 | password changed |
| 20661 | warning starts   |
| 20668 | password expires |

---

# 4. Check Password Aging — `chage`

Best command:

```bash id="vobaw1"
sudo chage -l mohammad
```

Example output:

```text id="zohmva"
Last password change                                    : May 5, 2026
Password expires                                        : Aug 3, 2026
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 90
Number of days of warning before password expires       : 7
```

---

# 5. Set Password Expiration

## Expire after 90 days

```bash id="8xxq0q"
sudo chage -M 90 mohammad
```

---

## Minimum 7 days before changing again

```bash id="z0dyfg"
sudo chage -m 7 mohammad
```

Prevents immediate password cycling.

---

## Warning 14 days before expiration

```bash id="9t36mj"
sudo chage -W 14 mohammad
```

---

# 6. Force Password Change At Next Login

Very common for new users:

```bash id="f0ifk0"
sudo passwd -e mohammad
```

or:

```bash id="39t0qt"
sudo chage -d 0 mohammad
```

Next login:

```text id="y0ibvl"
You are required to change your password immediately
```

---

# 7. Locking vs Expiring

These are different concepts.

---

## Lock Password

```bash id="3rj9cv"
sudo passwd -l mohammad
```

This disables password authentication.

Internally Linux adds:

```text id="oab0lw"
!
```

before the hash in `/etc/shadow`.

---

## Expire Password

Password becomes outdated and must be changed.

User may still log in temporarily to update it.

---

# 8. Account Expiration

Different from password expiration.

You can fully disable an account after a date.

Example:

```bash id="fjlwmj"
sudo chage -E 2026-12-31 mohammad
```

After Dec 31 2026:

* account login denied entirely

---

# 9. Disable Expiration

Common on personal machines:

```bash id="q5cnk3"
sudo chage -M 99999 mohammad
```

This effectively means:

* password never expires

Ubuntu desktop systems often use this by default.

---

# 10. Enterprise Linux Practice

Servers often enforce:

| Policy           | Example |
| ---------------- | ------- |
| Max password age | 90 days |
| Min age          | 1 day   |
| Warning          | 7 days  |
| Inactive timeout | 30 days |

Because:

* employees leave
* credentials leak
* compliance/security standards exist

---

# 11. Where Default Policies Come From

Defaults are often configured in:

```text id="g3b7ww"
/etc/login.defs
```

Example:

```text id="6mvgk3"
PASS_MAX_DAYS   90
PASS_MIN_DAYS   0
PASS_WARN_AGE   7
```

These apply to newly created users.

---

# 12. Common Admin Workflow

Create user:

```bash id="0eqot7"
sudo adduser developer
```

Force password reset:

```bash id="0otghv"
sudo passwd -e developer
```

Set expiration policy:

```bash id="sdny4u"
sudo chage -M 90 -W 7 developer
```

This is common in companies and production systems.
