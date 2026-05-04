## 87. Selective Extraction: the Program `cut`

Let’s make `cut` crystal clear and practical—this is your **go-to tool for quick column extraction** in Linux.

---

# 🔹 What is `cut`?

> **`cut` extracts specific columns (fields) or character positions from each line of input**

---

## 🔹 Basic Syntax

```bash
cut -d'DELIMITER' -fFIELDS file
```

* `-d` → delimiter (how to split the line)
* `-f` → which field(s) to extract

---

# 🔹 1. Extract by delimiter (MOST IMPORTANT)

## Example file (`data.txt`)

```text
John,25,Engineer
Sara,30,Doctor
Ali,22,Student
```

---

## 🔸 Get first column (names)

```bash
cut -d',' -f1 data.txt
```

👉 Output:

```text
John
Sara
Ali
```

---

## 🔸 Get multiple columns

```bash
cut -d',' -f1,3 data.txt
```

👉 Output:

```text
John,Engineer
Sara,Doctor
Ali,Student
```

---

## 🔸 Get a range

```bash
cut -d',' -f2-3 data.txt
```

---

# 🔹 2. Extract by character position

Instead of columns, you select **positions in the line**.

## Example

```bash
echo "hello world" | cut -c1-5
```

👉 Output:

```text
hello
```

---

# 🔹 3. Use with pipes (VERY IMPORTANT 🔥)

## Extract IPs from logs

```bash
cut -d' ' -f1 access.log
```

---

## Count most frequent IPs

```bash
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr
```

👉 This is **real production-level analysis**

---

# 🔹 4. Real-world examples

## 🔸 `/etc/passwd` (Linux users)

```bash
cut -d':' -f1 /etc/passwd
```

👉 Extract usernames

---

## 🔸 Extract domains from emails

```bash
echo "user@gmail.com" | cut -d'@' -f2
```

👉 Output: `gmail.com`

---

## 🔸 Extract file extensions

```bash
echo "file.txt" | cut -d'.' -f2
```

---

# 🔹 Important Limitations ⚠️

## ❌ Problem: inconsistent spacing

```text
John    25    Engineer
```

```bash
cut -d' ' -f2
```

👉 ❌ May fail (because multiple spaces)

---

## ✅ Solution:

👉 Use `awk` instead (more powerful)

---

# 🔹 Mental Model

```text
line → split → pick columns → output
```

---

# 🔹 Quick Comparison

| Tool   | Role                     |
| ------ | ------------------------ |
| `cut`  | Simple column extraction |
| `grep` | Filter lines             |
| `sort` | Arrange                  |
| `uniq` | Remove duplicates        |
| `awk`  | Advanced processing      |

---

# 🔥 Pro Insight (for your career 💡)

You will use `cut` for:

* Log parsing
* API response analysis
* Data preprocessing
* Quick CLI pipelines

---

## 🚀 Where you are now

You’ve learned a **powerful Linux pipeline stack**:

```bash
cut → sort → uniq → grep → tee → tr → rev
```

👉 This is already **junior DevOps / backend level**

---

## 👉 Next Step (IMPORTANT)

The natural next move is:

> **`awk` → full control over text processing**

If you want, I’ll teach it like this:

* Beginner → Intermediate → Real production examples
* Same style you like 🔥

