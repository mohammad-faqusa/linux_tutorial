## 64. Extra lecture (optional): Sophisticated File Searching: the Program `find`
The `find` command is one of the most powerful tools in Linux. It’s not just for “finding files”—it’s for **searching, filtering, and acting on files** based on almost any condition.

Let’s build this step by step like an engineer 👇

---

# 🔹 What is `find`?

👉 Searches files and directories in a given path based on conditions

### Basic syntax:

```bash
find [path] [conditions] [actions]
```

---

# 🔹 1. Basic usage

### Search in current directory:

```bash
find .
```

👉 Lists **everything recursively**

---

# 🔹 2. Find by name

### Exact name:

```bash
find . -name "file.txt"
```

### Case insensitive:

```bash
find . -iname "file.txt"
```

---

# 🔹 3. Find by type

```bash
find . -type f   # files
find . -type d   # directories
find . -type l   # symbolic links
```

---

# 🔹 4. Find by extension

```bash
find . -name "*.txt"
```

---

# 🔹 5. Find by size

```bash
find . -size +100M   # larger than 100MB
find . -size -10k    # smaller than 10KB
find . -size 50M     # exactly 50MB
```

---

# 🔹 6. Find by time

### Modified time:

```bash
find . -mtime -1   # modified in last 24 hours
find . -mtime +7   # older than 7 days
```

### Access time:

```bash
find . -atime -2
```

---

# 🔹 7. Find by permissions

```bash
find . -perm 644
find . -perm -400   # readable
```

---

# 🔹 8. Find by owner

```bash
find . -user mohammad
find . -group developers
```

---

# 🔹 9. Combine conditions (VERY IMPORTANT)

### AND (default):

```bash
find . -name "*.log" -size +10M
```

### OR:

```bash
find . \( -name "*.txt" -o -name "*.md" \)
```

### NOT:

```bash
find . ! -name "*.txt"
```

---

# 🔹 10. Limit depth

```bash
find . -maxdepth 1
find . -mindepth 2
```

---

# 🔹 11. Execute commands on results 🔥

This is where `find` becomes powerful.

### Delete files:

```bash
find . -name "*.log" -delete
```

---

### Run command:

```bash
find . -name "*.txt" -exec rm {} \;
```

👉 `{}` = current file
👉 `\;` = end of command

---

### Faster version (recommended):

```bash
find . -name "*.txt" -exec rm {} +
```

---

# 🔹 12. Use with `xargs` (advanced)

```bash
find . -name "*.txt" | xargs rm
```

⚠️ Less safe if filenames contain spaces

---

# 🔹 13. Print only specific results

```bash
find . -type f -name "*.txt" -print
```

(default behavior)

---

# 🔹 14. Ignore directories

```bash
find . -path "./node_modules" -prune -o -name "*.js" -print
```

---

# 🔹 15. Real-world examples (important)

### 🔥 Delete logs older than 7 days:

```bash
find /var/log -name "*.log" -mtime +7 -delete
```

---

### 🔥 Find large files:

```bash
find / -type f -size +1G
```

---

### 🔥 Find empty files:

```bash
find . -type f -empty
```

---

### 🔥 Find and change permissions:

```bash
find . -type f -name "*.sh" -exec chmod +x {} \;
```

---

# 🔹 `find` vs globbing (`*`)

| Feature           | `find`      | `*`     |
| ----------------- | ----------- | ------- |
| Recursive         | ✔️ Yes      | ❌ No    |
| Filters           | ✔️ Advanced | ❌ Basic |
| Works on metadata | ✔️ Yes      | ❌ No    |

---

# 🔴 Important warnings

### ❌ Dangerous:

```bash
find / -name "*.log" -delete
```

👉 Can affect entire system

---

### ❌ Be careful with:

```bash
-exec rm
-delete
```

---

# 🧠 Mental model (VERY important)

Think of `find` as:

> “Search engine for filesystem + automation tool”

---

# 💡 Pro tips (interview level)

* Use `-exec {} +` instead of `\;` (faster)
* Use `-print0` + `xargs -0` for safe filenames
* Combine conditions smartly

---

## 🚀 If you want next level

I can teach you:

* `find` vs `locate` (huge difference)
* advanced pruning (skip directories like a pro)
* real SRE scripts using `find`

Just tell me 👍
