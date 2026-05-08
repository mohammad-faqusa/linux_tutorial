## 156. Switching Users: the Command su

# 156. Switching Users: the Command `su`

The `su` command means:

> **substitute user**
> or historically:
> **switch user**

It allows you to temporarily become another user inside the current terminal session.

---

# Basic Syntax

```bash id="4m1q7v"
su username
```

Example:

```bash id="8m2q1v"
su ahmad
```

Linux asks for:

* ahmad’s password

If correct:

* shell switches to `ahmad`

---

# Verify Current User

```bash id="3q7m1v"
whoami
```

or:

```bash id="6m1q8v"
id
```

---

# 1. Switch To Root

Very common:

```bash id="2q4m1v"
su -
```

or:

```bash id="9m1q5v"
su root
```

This switches to:

* root user shell

Requires:

* root password

---

# IMPORTANT UBUNTU NOTE

Ubuntu usually disables direct root password login by default.

So:

```bash id="5v1m8q"
su -
```

often fails unless you explicitly set a root password:

```bash id="1q7m4v"
sudo passwd root
```

Ubuntu prefers:

* `sudo`
  instead of direct root login.

---

# 2. Difference Between `su` and `su -`

This is VERY important.

---

## `su username`

Example:

```bash id="8m4q1v"
su ahmad
```

Changes:

* effective user

BUT keeps much of current environment:

* current directory
* environment variables
* PATH settings

---

## `su - username`

Example:

```bash id="2v7m1q"
su - ahmad
```

Creates:

* full login shell

Meaning:

* loads user's environment
* changes home directory
* loads `.profile`, `.bashrc`, etc.

This behaves like:

> a fresh real login

---

# Example Difference

---

## Normal `su`

```bash id="6q1m8v"
pwd
/home/mohammad

su ahmad

pwd
/home/mohammad
```

Still in Mohammad's directory.

---

## Login shell `su -`

```bash id="1v4m7q"
su - ahmad

pwd
/home/ahmad
```

Now environment fully changed.

---

# 3. Verify Current Identity

Before:

```bash id="7m2q1v"
whoami
mohammad
```

After:

```bash id="4q1m8v"
su - ahmad

whoami
ahmad
```

---

# 4. Exit Back

To leave switched shell:

```bash id="1m7q4v"
exit
```

or:

```bash id="5v2m1q"
Ctrl + D
```

You return to original user.

---

# 5. Root Shell Example

```bash id="7m1q8v"
sudo su -
```

This is very common.

Flow:

| Step | Meaning                |
| ---- | ---------------------- |
| sudo | temporarily gain root  |
| su - | start root login shell |

Result:

* full interactive root shell

---

# 6. Difference Between `su` and `sudo`

Very important.

| `su`                           | `sudo`              |
| ------------------------------ | ------------------- |
| switches shell/user            | runs single command |
| often requires target password | uses your password  |
| persistent shell               | temporary elevation |
| less auditing                  | better auditing     |

---

# Example

## `sudo`

```bash id="2q7m1v"
sudo apt update
```

Only this command becomes root.

---

## `su -`

```bash id="4m1q7v"
su -
```

Entire shell becomes root until exit.

---

# 7. Security Philosophy

Modern Linux systems prefer:

* sudo
* temporary privilege escalation

instead of:

* permanent root shells

because:

* safer
* logged
* easier auditing
* less accidental damage

---

# 8. Using `su` As Root

Root can switch users WITHOUT passwords:

Example:

```bash id="8m2q1v"
sudo su -

su - mohammad
```

No password asked.

Because:

* root bypasses authentication checks.

---

# 9. Real-World Admin Usage

Admin troubleshooting another account:

```bash id="3q7m1v"
su - developer
```

Now admin sees:

* same environment
* same shell
* same permissions

as that user.

Very useful for debugging.

---

# 10. Environment Variables

With:

```bash id="6m1q8v"
su -
```

variables reload from:

* `.profile`
* `.bashrc`
* `/etc/profile`

Without `-`:

* many old variables remain.

This is why admins usually prefer:

```bash id="2q4m1v"
su -
```

---

# 11. Common Commands

---

## Become root

```bash id="9m1q5v"
sudo su -
```

---

## Switch to another user

```bash id="5v1m8q"
su - ahmad
```

---

## Return back

```bash id="1q7m4v"
exit
```

---

# 12. Historical Note

`su` is one of the oldest Unix commands and predates:

* sudo
* modern privilege systems

Early Unix admins often logged in directly as root using `su`.

Modern Linux evolved toward:

* sudo-based workflows
* least privilege security.
