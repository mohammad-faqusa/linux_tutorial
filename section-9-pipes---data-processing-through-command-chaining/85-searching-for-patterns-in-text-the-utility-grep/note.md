## 85. Searching for Patterns in Text: the Utility `grep`

Now you’re learning one of the **most important Linux commands ever**: `grep` 🔥
This is used daily by backend engineers, DevOps, and SREs.

---

# 🔹 What is `grep`?

> **`grep` searches for patterns (words, text, regex) inside files or command output**

---

## 🔹 Basic Syntax

```bash
grep "pattern" file.txt
```

---

## 🔹 Example

### File (`file.txt`)

```text
apple
banana
orange
apple pie
```

### Command

```bash
grep "apple" file.txt
```

### Output

```text
apple
apple pie
```

👉 It prints **lines that contain "apple"**

---

# 🔹 Most Important Options

## 🔸 1. Case-insensitive search

```bash
grep -i "apple" file.txt
```

👉 Matches `Apple`, `APPLE`, etc.

---

## 🔸 2. Show line numbers

```bash
grep -n "apple" file.txt
```

---

## 🔸 3. Count matches

```bash
grep -c "apple" file.txt
```

---

## 🔸 4. Invert match (NOT)

```bash
grep -v "apple" file.txt
```

👉 Shows lines that **do NOT contain "apple"**

---

## 🔸 5. Recursive search (folders)

```bash
grep -r "error" .
```

👉 Search inside all files in current directory

---

## 🔸 6. Match whole word only

```bash
grep -w "cat" file.txt
```

👉 Matches `cat` but not `catalog`

---

---

# 🔹 Using `grep` with pipes (VERY IMPORTANT 🔥)

## Example 1: Filter processes

```bash
ps aux | grep java
```

---

## Example 2: Search logs

```bash
cat app.log | grep ERROR
```

---

## Example 3: Combine with previous tools

```bash
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr | grep "192.168"
```

---

# 🔹 Regex (basic idea)

`grep` supports **regular expressions** (patterns)

## Example:

```bash
grep "^a" file.txt
```

👉 Lines starting with `a`

```bash
grep "e$" file.txt
```

👉 Lines ending with `e`

---

# 🔹 Real-world use (VERY IMPORTANT for you 💡)

## 🔸 1. Debugging backend apps

```bash
grep "Exception" app.log
```

---

## 🔸 2. Find errors in logs

```bash
grep -i "error" server.log
```

---

## 🔸 3. Monitor live logs

```bash
tail -f app.log | grep ERROR
```

👉 Real-time debugging 🔥

---

## 🔸 4. Search API responses

```bash
curl api.com | grep "success"
```

---

# 🔹 Mental Model

```text
Input → grep → filter matching lines
```

---

# 🔹 Summary

| Option | Meaning          |
| ------ | ---------------- |
| `-i`   | Ignore case      |
| `-n`   | Show line number |
| `-c`   | Count matches    |
| `-v`   | NOT match        |
| `-r`   | Recursive        |

---

# 🔥 Pro Insight (important for your career)

You will use `grep` for:

* Debugging production systems
* Analyzing logs
* Filtering API responses
* Monitoring services

👉 Combined with:

* `sort`
* `uniq`
* `cut`
* `tee`

= **You can analyze any system like a pro**

---

If you want next step:
👉 I’ll teach you **`awk` (next level)** — it replaces `cut`, `grep`, and even parts of `sort` in many cases 🚀

