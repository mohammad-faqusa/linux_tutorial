## 84. Sorting and Removing Duplicates: the Commands `sort` and `uniq`

Now you’re entering a **very practical combo** in Linux: `sort` + `uniq`.
These are used everywhere (logs, data processing, debugging).

---

# 🔹 1. `sort` — Arrange data

## What it does:

> **Sorts lines of text (alphabetically or numerically)**

---

## 🔹 Basic example

```bash
sort file.txt
```

👉 Output: lines sorted alphabetically

---

## 🔹 Example

Input (`file.txt`):

```text
banana
apple
orange
```

Output:

```text
apple
banana
orange
```

---

## 🔹 Useful options

### 1. Reverse order

```bash
sort -r file.txt
```

---

### 2. Numeric sort

```bash
sort -n numbers.txt
```

👉 Important: without `-n`, numbers are treated like text
Example:

```
10
2
```

❌ Wrong (text sort): 10, 2
✅ Correct (`-n`): 2, 10

---

### 3. Sort by column

```bash
sort -k2 file.txt
```

👉 Sort based on **column 2**

---

### 4. Remove duplicates directly

```bash
sort -u file.txt
```

---

# 🔹 2. `uniq` — Remove duplicates

## What it does:

> **Removes duplicate lines**

⚠️ IMPORTANT:
👉 `uniq` only works on **adjacent duplicates**

---

## 🔹 Example (wrong usage ❌)

```text
apple
banana
apple
```

```bash
uniq file.txt
```

👉 Output (unchanged!):

```text
apple
banana
apple
```

---

## 🔹 Correct usage ✅

```bash
sort file.txt | uniq
```

👉 Output:

```text
apple
banana
```

---

# 🔹 Useful `uniq` options

### 1. Count duplicates

```bash
sort file.txt | uniq -c
```

👉 Output:

```text
2 apple
1 banana
```

---

### 2. Show only duplicates

```bash
sort file.txt | uniq -d
```

---

### 3. Show only unique (no duplicates)

```bash
sort file.txt | uniq -u
```

---

# 🔥 Real-world combos (IMPORTANT for you)

## 🔹 1. Count most frequent items

```bash
cat file.txt | sort | uniq -c | sort -nr
```

👉 Example:

* Count errors in logs
* Count IP addresses
* Count API calls

---

## 🔹 2. Analyze logs

```bash
cat access.log | grep "ERROR" | sort | uniq -c | sort -nr
```

👉 Shows most frequent errors

---

## 🔹 3. Unique users

```bash
cut -d' ' -f1 access.log | sort | uniq
```

---

# 🔹 Mental Model

* `sort` → organizes data
* `uniq` → removes duplicates
* Together → **data analysis pipeline**

---

# 🔹 Quick Comparison

| Command   | Purpose                    |
| --------- | -------------------------- |
| `sort`    | Arrange lines              |
| `uniq`    | Remove adjacent duplicates |
| `sort -u` | Sort + remove duplicates   |

---

# 🔹 Pro Insight (backend + SRE level 💡)

You will use this for:

* Log analysis (very important 🔥)
* Debugging production issues
* Monitoring systems
* Data cleaning

---

If you want next step:
👉 I can teach you **`cut`, `awk`, and `sed`** — these will turn you into a real Linux data-processing machine 🚀


Great question—this is a **very common log-processing command**.

---

## 🔹 The command

```bash
cut -d' ' -f1 access.log
```

---

## 🔹 What it does (simple)

> **Extracts the first column from each line in `access.log`, using space as the separator**

---

## 🔹 Break it down

### 1. `cut`

👉 A command used to **extract specific parts of each line**

---

### 2. `-d' '`

👉 Defines the **delimiter (separator)**

* `' '` = space
  So this means:

> “Split each line by spaces”

---

### 3. `-f1`

👉 Select **field (column) number 1**

* `-f1` = first column
* `-f2` = second column
* etc.

---

### 4. `access.log`

👉 The input file

---

## 🔹 Example

### Input (`access.log`)

```text
192.168.1.1 GET /index.html
10.0.0.5 POST /login
192.168.1.1 GET /home
```

---

### Command

```bash
cut -d' ' -f1 access.log
```

---

### Output

```text
192.168.1.1
10.0.0.5
192.168.1.1
```

---

## 🔹 Real-world meaning

👉 In most web server logs:

* **First column = IP address**

So this command:

> extracts all visitor IPs

---

## 🔥 Combine it (very important)

### Count unique visitors

```bash
cut -d' ' -f1 access.log | sort | uniq
```

---

### Count most frequent IPs

```bash
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr
```

👉 Output example:

```text
50 192.168.1.1
20 10.0.0.5
```

---

## 🔹 Mental Model

```text
Line → split by space → take column 1
```

---

## 🔹 Pro Tip (for you 💡)

As a backend/SRE engineer, this exact pattern is used to:

* Detect spam IPs
* Analyze traffic
* Debug APIs
* Monitor usage

---

If you want next step:
👉 I can show you how to do the same thing using `awk` (more powerful and flexible)

