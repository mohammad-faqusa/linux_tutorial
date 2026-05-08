## 157. Heads-up: EDITOR for visudo
This explanation is about how `visudo` chooses which text editor to open.

`visudo` is the safe editor for:

```text id="4m1q7v"
/etc/sudoers
```

the file controlling sudo permissions.

---

# The Problem

On some systems (especially older CentOS systems), running:

```bash id="8m2q1v"
sudo visudo
```

may open:

```text id="3q7m1v"
vi
```

instead of:

* nano

Many beginners are unfamiliar with `vi`.

---

# Why Does This Happen?

Programs often check environment variables like:

```text id="6m1q8v"
EDITOR
```

to decide which editor to use.

Example:

```bash id="2q4m1v"
echo $EDITOR
```

might show:

```text id="9m1q5v"
nano
```

---

# Setting EDITOR Normally

You can do:

```bash id="5v1m8q"
export EDITOR=nano
```

Now programs launched from this shell may use:

* nano

---

# But Why Doesn't This Work With sudo?

You might expect:

```bash id="1q7m4v"
export EDITOR=nano
sudo visudo
```

to work.

But `sudo` intentionally removes many environment variables.

This is called:

```text id="8m4q1v"
environment sanitization
```

---

# Why Does sudo Remove Variables?

Security.

Imagine dangerous variables like:

```text id="2v7m1q"
LD_PRELOAD
PATH
PYTHONPATH
EDITOR
```

If sudo inherited everything blindly:

* attackers could manipulate root commands.

So sudo keeps a cleaner environment.

---

# The Correct Solution

Pass the variable directly to the command:

```bash id="6q1m8v"
sudo EDITOR=nano visudo
```

Meaning:

| Part        | Meaning                             |
| ----------- | ----------------------------------- |
| sudo        | run as root                         |
| EDITOR=nano | temporary variable for this command |
| visudo      | launch visudo                       |

---

# Important Detail

This does NOT permanently change EDITOR.

It only affects THIS command execution.

Equivalent conceptually to:

```text id="1v4m7q"
Run visudo as root while temporarily setting EDITOR=nano
```

---

# Why `visudo` Exists

You should NEVER directly edit:

```text id="7m2q1v"
/etc/sudoers
```

with normal editors.

Bad example:

```bash id="4q1m8v"
sudo nano /etc/sudoers
```

because syntax mistakes may:

* break sudo entirely
* lock you out of admin access

---

# What `visudo` Does

`visudo`:

* locks file safely
* validates syntax before saving
* prevents corruption

Very important admin tool.

---

# About `vi`

If `vi` opens accidentally:

You can exit using:

```text id="1m7q4v"
:q
```

if no changes.

Or:

```text id="5v2m1q"
:q!
```

to force quit.

Or:

```text id="7m1q8v"
:wq
```

to save and quit.

---

# Understanding The Colon

In `vi`:

```text id="2q7m1v"
:
```

means:

> enter command mode

Then:

* `q` = quit
* `w` = write/save

---

# Real-World Admin Practice

Many admins permanently set editor:

Example:

```bash id="4m1q7v"
echo 'export EDITOR=nano' >> ~/.bashrc
```

or:

```bash id="8m2q1v"
echo 'export VISUAL=nano' >> ~/.bashrc
```

But sudo sanitization still applies unless configured otherwise.

---

# Important Security Concept

This lecture is actually teaching a deeper Linux idea:

> environment variables can influence program behavior

and:

> sudo intentionally limits inherited environment variables for security.
