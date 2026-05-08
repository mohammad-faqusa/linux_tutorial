## 159. Executing Commands as Different User with `sudo -U`

There is an important distinction here:

* `sudo -u` (lowercase `u`) → run command AS another user
* `sudo -U` (uppercase `U`) → query/check sudo privileges FOR another user

They are completely different options.

---

# 1. `sudo -u` (lowercase)

This is the common one.

Syntax:

```bash id="4m1q7v"
sudo -u username command
```

Example:

```bash id="8m2q1v"
sudo -u postgres psql
```

Meaning:

> run `psql` AS user `postgres`

---

# Result

Inside the process:

```text id="3q7m1v"
effective UID = postgres
```

---

# Verify

```bash id="6m1q8v"
sudo -u postgres whoami
```

Output:

```text id="2q4m1v"
postgres
```

---

# 2. `sudo -U` (uppercase)

This does NOT run command as another user.

Instead it asks:

> "What sudo permissions does this user have?"

Usually used with:

```bash id="9m1q5v"
sudo -l -U username
```

---

# Example

```bash id="5v1m8q"
sudo -l -U mohammad
```

Meaning:

> list sudo permissions for user `mohammad`

---

# Example Output

```text id="1q7m4v"
User mohammad may run the following commands:
    (ALL : ALL) ALL
```

Meaning:

* mohammad has full sudo access.

---

# Real Enterprise Usage

Admins use:

```bash id="8m4q1v"
sudo -l -U employee
```

to audit:

* who can run what
* sudo policies
* restricted commands

---

# Compare Clearly

| Command                    | Meaning                            |
| -------------------------- | ---------------------------------- |
| `sudo -u postgres command` | execute AS postgres                |
| `sudo -U mohammad -l`      | inspect mohammad's sudo privileges |

---

# Example Scenario

Suppose admin wants to verify:

* can `ahmad` restart nginx?

Check:

```bash id="2v7m1q"
sudo -l -U ahmad
```

Possible output:

```text id="6q1m8v"
(ALL) /usr/bin/systemctl restart nginx
```

Meaning:

* ahmad may only restart nginx.

---

# Why Uppercase `-U` Exists

Large systems may have:

* hundreds of users
* complex sudo rules
* role-based restrictions

Admins need auditing tools.

`sudo -U` helps inspect policies safely.

---

# Another Important Command

Users can inspect THEIR OWN permissions:

```bash id="1v4m7q"
sudo -l
```

No uppercase `U`.

This shows:

* what YOU are allowed to do.

---

# Summary

| Option | Purpose                                |
| ------ | -------------------------------------- |
| `-u`   | run command as another user            |
| `-U`   | inspect another user's sudo privileges |

Lowercase:

```text id="7m2q1v"
execute AS user
```

Uppercase:

```text id="4q1m8v"
query privileges OF user
```
