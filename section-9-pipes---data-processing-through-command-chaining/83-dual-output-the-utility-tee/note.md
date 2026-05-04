## 83. Dual Output: the Utility `tee`
Great—now you’re stepping into **real Linux power tools**.

## 🔹 What is `tee`?

The `tee` command lets you:

> **send output to a file AND still display it on the terminal**

Normally:

* `>` → sends output to file (and hides it from terminal)
* `|` → sends output to another command

👉 But `tee` does **both at the same time**

---

## 🔹 Basic Syntax

```bash
command | tee file.txt
```

---

## 🔹 Example 1: Save + Display

```bash
ls | tee files.txt
```

### What happens?

* You see the output in terminal ✅
* It is saved in `files.txt` ✅

---

## 🔹 Example 2: With a long-running command

```bash
ping google.com | tee ping.log
```

👉 Useful because:

* You watch output live
* You keep a log for later

---

## 🔹 Example 3: Append instead of overwrite

```bash
command | tee -a file.txt
```

* `-a` = append (don’t overwrite)

Example:

```bash
echo "Hello" | tee -a log.txt
```

---

## 🔹 Example 4: Use with pipes (very powerful 🔥)

```bash
ps aux | tee processes.txt | grep java
```

### Flow:

1. `ps aux` → list processes
2. `tee` → saves ALL processes
3. `grep java` → filters only Java processes

👉 Result:

* File = full process list
* Terminal = only Java processes

---

## 🔹 Example 5: Save errors + output

```bash
command 2>&1 | tee output.log
```

👉 Explanation:

* `2>&1` → merge **stderr + stdout**
* `tee` → save everything

---

## 🔹 Real-world use (important for you 💡)

### 1. Debugging backend apps

```bash
java -jar app.jar | tee app.log
```

### 2. API testing

```bash
curl api.com | tee response.json
```

### 3. Docker logs

```bash
docker logs container | tee logs.txt
```

---

## 🔹 Why `tee` is important

Because without it:

```bash
command > file.txt
```

❌ You lose terminal output

With `tee`:

```bash
command | tee file.txt
```

✅ You keep both

---

## 🔹 Mental Model

Think of `tee` like a **splitter**:

```text
          → file
command → tee
          → terminal
```

---

## 🔹 Summary

* `|` → pass output forward
* `>` → save to file
* `tee` → split output (file + screen)

---

If you want next level:
👉 I can show you how `tee` is used in **DevOps pipelines, CI/CD logs, and real production debugging** (this is exactly what SREs do daily).
