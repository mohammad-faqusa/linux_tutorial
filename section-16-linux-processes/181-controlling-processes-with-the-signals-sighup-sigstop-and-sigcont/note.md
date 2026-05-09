## 181. Controlling Processes with the Signals SIGHUP, SIGSTOP and SIGCONT

In Linux, signals are how you **control processes from outside**. After SIGTERM and SIGKILL, the next very important ones are:

* **SIGHUP** → reload / “hang up”
* **SIGSTOP** → pause (freeze)
* **SIGCONT** → resume

These are essential for job control and server management.

---

# 🟣 1. SIGHUP (Signal 1) — “Hang up / reload”

## 💡 Meaning

Originally meant:

> terminal connection was closed (“hang up”)

Now it is widely used to:

> 🔄 tell a process to reload its configuration

---

## 🧪 Example

```bash id="h1k9dp"
kill -HUP <PID>
```

or:

```bash id="q8m2zn"
kill -1 <PID>
```

---

## 🧠 What happens?

Depends on the program:

* Some processes **terminate**
* Many modern services **reload config without stopping**

  * e.g., Nginx, Apache, system daemons

---

## 🧑‍💻 Real use case

```bash id="x7p2ld"
kill -HUP $(pgrep nginx)
```

👉 Nginx reloads config without downtime

---

# 🔵 2. SIGSTOP (Signal 19) — “Pause immediately”

## 💡 Meaning

* Immediately **pauses a process**
* Cannot be ignored or handled

---

## 🧪 Example

```bash id="k4n8sd"
kill -STOP <PID>
```

or:

```bash id="v2q9mx"
kill -19 <PID>
```

---

## 🧠 What happens?

* Process is **frozen in memory**
* CPU stops scheduling it
* It keeps its state exactly as-is

---

## 🧑‍💻 Think of it like:

> “Pause button that cannot be refused”

---

# 🟢 3. SIGCONT (Signal 18) — “Resume process”

## 💡 Meaning

* Resumes a process that was stopped with SIGSTOP

---

## 🧪 Example

```bash id="z9k3pw"
kill -CONT <PID>
```

or:

```bash id="t6m1qa"
kill -18 <PID>
```

---

## 🧠 What happens?

* Process continues exactly where it stopped
* No restart, no loss of state

---

## 🧑‍💻 Think of it like:

> “Play button after pause”

---

# 🔁 Full cycle example

```bash id="r3n8ld"
kill -STOP 1234   # pause process
kill -CONT 1234   # resume process
```

---

# 🎮 Real-world analogy

| Signal  | Meaning                 | Analogy              |
| ------- | ----------------------- | -------------------- |
| SIGHUP  | reload/restart behavior | refresh app settings |
| SIGSTOP | pause instantly         | freeze frame         |
| SIGCONT | resume                  | play button          |

---

# ⚠️ Important differences

## SIGSTOP vs SIGTERM vs SIGKILL

| Signal  | Can be ignored | Can resume     | Purpose       |
| ------- | -------------- | -------------- | ------------- |
| SIGTERM | Yes            | No             | graceful stop |
| SIGKILL | No             | No             | force kill    |
| SIGSTOP | No             | Yes (via CONT) | pause         |

---

# 🧠 Why this matters

These signals are used in:

* job control (`Ctrl+Z` = SIGSTOP)
* servers reloading configs (SIGHUP)
* debugging stuck processes
* system administration

---

# 🚀 Bonus (very useful command)

### Suspend job in terminal:

```bash id="b7k2xa"
Ctrl + Z
```

This sends:

```
SIGSTOP
```

Then resume:

```bash id="n5p8dw"
fg
```

or:

```bash id="m1x9qp"
bg
```

---

If you want, I can next explain:

* how `jobs`, `fg`, `bg` work together
* or how Linux internally queues and handles signals
* or real system examples (like stopping a server safely)
