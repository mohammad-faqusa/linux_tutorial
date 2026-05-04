## 82. What is a Pipe (`|`)?

The `|` (pipe) in Linux is one of the most powerful concepts you’ll use in the terminal.

### 🔹 What is a pipe?

A **pipe (`|`) takes the output of one command and sends it as input to another command**.

Think of it like a connection between commands:

```
Command1 → (pipe) → Command2
```

---

## 🔹 Basic Example

```bash
ls | wc -l
```

### What happens here?

* `ls` → lists files
* `wc -l` → counts lines

👉 So this means:

> “Count how many files are in this directory”

---

## 🔹 Why is pipe powerful?

Because you can **chain commands together** instead of doing everything manually.

---

## 🔹 Real Examples

### 1. Search inside output

```bash
ls | grep ".txt"
```

👉 Lists only `.txt` files

---

### 2. View long output page by page

```bash
dmesg | less
```

👉 Useful when output is too long

---

### 3. Find running process

```bash
ps aux | grep nginx
```

👉 Shows only processes related to nginx

---

### 4. Sort results

```bash
cat file.txt | sort
```

👉 Sorts file content

---

### 5. Combine multiple pipes

```bash
ps aux | grep java | wc -l
```

👉 Count how many Java processes are running

---

## 🔹 Important Concept (VERY IMPORTANT ⚠️)

Without pipe:

```bash
ls
wc -l
```

❌ These are separate commands (no connection)

With pipe:

```bash
ls | wc -l
```

✅ Now they work together

---

## 🔹 Pipe vs Redirection (`>`)

* `|` → sends output to **another command**
* `>` → sends output to **a file**

Example:

```bash
ls > files.txt
```

👉 saves output to a file

---

## 🔹 Mental Model (remember this)

Imagine:

* Each command = a machine
* Pipe = a conveyor belt between machines

---

## 🔹 Pro Tip (for you as backend dev 🔥)

Pipes are essential when working with:

* logs (`cat logs.txt | grep ERROR`)
* APIs (`curl ... | jq`)
* debugging systems (very useful in Linux + Docker)

---

If you want, next step I can teach you:
👉 advanced pipes (`xargs`, `tee`, `|&`, chaining for real-world debugging)

This is where you move from beginner → real Linux engineer 🚀
