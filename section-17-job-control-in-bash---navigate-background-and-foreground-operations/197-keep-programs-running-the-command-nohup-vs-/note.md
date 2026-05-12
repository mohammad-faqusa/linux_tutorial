## 197. Keep Programs Running: the Command `nohup` vs `&`

# 197. Keep Programs Running: `nohup` vs `&`

This topic is very important in Linux process management.

We will learn:

* What `&` does
* What `nohup` does
* Why they are often used together
* What happens when the terminal closes
* How Linux signals affect processes

---

# 1. Running a Program in the Background with `&`

When you add `&` at the end of a command:

```bash
ping google.com &
```

the shell says:

> Start this process in the background and immediately return control to me.

Example output:

```bash
[1] 12345
```

* `[1]` → job number
* `12345` → process ID (PID)

---

# What Actually Happens?

The process is still attached to the current terminal session.

If you close the terminal:

❌ the process will usually terminate.

Why?

Because the shell sends the signal:

```bash
SIGHUP
```

to its child processes when the terminal closes.

---

# Example

Start a background process:

```bash
sleep 300 &
```

Check jobs:

```bash
jobs
```

Or check processes:

```bash
ps -ef | grep sleep
```

Now close the terminal.

Open a new terminal and run:

```bash
pgrep sleep
```

Usually the process is gone.

---

# 2. What is `nohup`?

`nohup` means:

> no hang up

It prevents a process from being terminated when the terminal closes.

---

# Basic Example

```bash
nohup sleep 300
```

Output:

```bash
nohup: ignoring input and appending output to 'nohup.out'
```

Now even if you close the terminal:

✅ the process continues running.

---

# Why?

Because `nohup` makes the process ignore the signal:

```bash
SIGHUP
```

---

# Where Does the Output Go?

By default:

```bash
nohup.out
```

Example:

```bash
nohup ping google.com
```

Then:

```bash
cat nohup.out
```

You will see the output there.

---

# 3. Why `nohup` is Usually Combined with `&`

`nohup` alone does NOT put the process in the background.

So this:

```bash
nohup python app.py
```

still runs in the foreground.

The common usage is:

```bash
nohup python app.py &
```

or:

```bash
nohup java -jar app.jar &
```

This gives you BOTH:

* process survives terminal closing
* shell returns immediately

---

# Understanding the Difference

| Feature                        | `&`       | `nohup` |
| ------------------------------ | --------- | ------- |
| Runs in background             | ✅         | ❌       |
| Survives terminal close        | ❌ usually | ✅       |
| Ignores SIGHUP                 | ❌         | ✅       |
| Redirects output automatically | ❌         | ✅       |

---

# Professional Logging Example

Instead of using `nohup.out`:

```bash
nohup java -jar app.jar > app.log 2>&1 &
```

---

# Understanding This Command

## `> app.log`

Redirects standard output (`stdout`) to `app.log`

---

## `2>&1`

Redirects standard error (`stderr`) to the same destination as stdout.

So both go into:

```bash
app.log
```

---

# Real-World Example

Starting a Spring Boot app on a server:

```bash
nohup java -jar admin-portal.jar > app.log 2>&1 &
```

Check logs live:

```bash
tail -f app.log
```

This is extremely common on Linux servers.

---

# Important Concept

`nohup` does NOT create a real daemon/service.

It simply:

* ignores `SIGHUP`
* detaches from terminal input

The process is still a normal Linux process.

---

# Monitoring the Process

Find it:

```bash
ps -ef | grep java
```

or:

```bash
pgrep -a java
```

---

# Stopping the Process

Normal kill commands still work:

```bash
kill PID
```

or:

```bash
pkill -f app.jar
```

---

# Important Signal Relationship

When a terminal closes:

```text
Terminal closes
    ↓
Shell receives SIGHUP
    ↓
Shell sends SIGHUP to child processes
    ↓
Processes terminate
```

But with `nohup`:

```text
Process ignores SIGHUP
    ↓
Process survives
```

---

# Modern Alternatives

Today many systems prefer:

* `systemd`
* `tmux`
* `screen`
* Docker
* Kubernetes

But understanding `nohup` is still foundational Linux knowledge.

---

# Preview: `disown`

Sometimes you already started a process:

```bash
python app.py &
```

and later decide you want it to survive terminal closing.

You can detach it from the shell using:

```bash
disown
```

This is closely related to `nohup` and job control.
