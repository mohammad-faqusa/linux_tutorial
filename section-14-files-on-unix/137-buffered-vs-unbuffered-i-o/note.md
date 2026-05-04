## 137. Buffered vs. unbuffered I/O

Great topic—this shows up in performance, logs, and real backend behavior 👇

---

# 🔹 What is I/O?

**I/O (Input/Output)** = reading or writing data:

* from/to files
* network
* terminal (stdout/stderr)

---

# 🔹 The Core Idea

The difference is **how data moves between your program and the destination**.

---

# 🔥 1. Buffered I/O

👉 Data is first stored in **memory (buffer)**, then written/read in chunks.

---

## 🧠 How it works

```text
Program → Buffer (RAM) → Disk / Terminal
```

Instead of writing immediately, the system waits until:

* buffer is full, OR
* you flush it, OR
* program ends

---

## 🔹 Example

```bash
echo "Hello" > file.txt
```

👉 It may not be written instantly to disk
👉 It goes to buffer first

---

## 🔹 Advantages

* ⚡ Faster (fewer system calls)
* Efficient for large data
* Better performance

---

## 🔹 Disadvantages

* ❗ Delay before data appears
* ❗ Risk of data loss if crash happens before flush

---

---

# 🔥 2. Unbuffered I/O

👉 Data is written/read **immediately**

---

## 🧠 How it works

```text
Program → Disk / Terminal (directly)
```

No waiting, no batching

---

## 🔹 Example

```bash
echo "Hello" > /dev/tty
```

Or in programming:

* using low-level system calls (`write()`)

---

## 🔹 Advantages

* ✅ Immediate output
* ✅ Useful for real-time systems

---

## 🔹 Disadvantages

* 🐢 Slower (many system calls)
* Less efficient

---

# 🔥 Real Difference (Simple Table)

| Feature    | Buffered           | Unbuffered       |
| ---------- | ------------------ | ---------------- |
| Speed      | Fast ⚡             | Slower           |
| Timing     | Delayed            | Immediate        |
| Efficiency | High               | Low              |
| Risk       | Data loss on crash | Safer            |
| Use case   | Files, logs        | Real-time output |

---

# 🔥 Real Linux Behavior (VERY IMPORTANT)

### Terminal output:

```bash
printf "Hello"
```

👉 Usually **line-buffered** (flushes on newline)

---

### File output:

```bash
./program > file.txt
```

👉 Usually **fully buffered**

---

### stderr:

```bash
echo "error" >&2
```

👉 **Unbuffered by default** ⚡

---

# 🔥 Types of Buffering

| Type           | Behavior               |
| -------------- | ---------------------- |
| Fully buffered | Wait until buffer full |
| Line buffered  | Flush on newline `\n`  |
| Unbuffered     | Immediate              |

---

# 🔥 Real Problem (You WILL face this)

You run:

```bash
./app | grep something
```

👉 Output is delayed 😡

Why?

👉 Because stdout is now **buffered**

---

# 🔧 Solution

Use:

```bash
stdbuf -o0 ./app
```

👉 disables buffering

---

# 🔥 Backend Example (VERY IMPORTANT for YOU)

Spring Boot logs:

* When writing to file → buffered
* When printing to console → may be line buffered

👉 Logs may **not appear instantly**

---

# 🔥 When to use what?

### Use Buffered:

* file writing
* large data processing
* performance-critical systems

---

### Use Unbuffered:

* real-time logs
* debugging
* interactive programs

---

# 🔥 Summary

* Buffered → fast, delayed
* Unbuffered → immediate, slower
* Controlled by system + program

---

# 🔥 Interview Answer

> Buffered I/O temporarily stores data in memory before performing read/write operations to improve efficiency, while unbuffered I/O performs operations immediately, offering real-time behavior at the cost of performance.

---

If you want next level 🚀

I can show:

* how buffering affects pipes (`|`) deeply
* why logs disappear in Docker sometimes
* how Java / Spring Boot handles buffering internally

Just tell me 👍
