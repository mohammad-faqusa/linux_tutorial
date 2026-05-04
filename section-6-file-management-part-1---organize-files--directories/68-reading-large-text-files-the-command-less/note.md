## 68. Reading Large Text Files: the Command `less`
The `wc` command (short for **word count**) is simple but very powerful—you’ll use it a lot for logs, files, and pipelines.

---

# 🔹 What is `wc`?

👉 Counts:

* lines
* words
* characters/bytes

### Basic syntax:

```bash
wc [options] file
```

---

# 🔹 Default behavior

```bash
wc file.txt
```

Output:

```text
10  50  300 file.txt
```

👉 Meaning:

```
lines  words  bytes
```

---

# 🔹 Most important options

## 1. Count lines

```bash
wc -l file.txt
```

➡️ Number of lines

---

## 2. Count words

```bash
wc -w file.txt
```

➡️ Number of words

---

## 3. Count characters

```bash
wc -m file.txt
```

➡️ Number of characters

---

## 4. Count bytes

```bash
wc -c file.txt
```

➡️ Number of bytes (important for file size)

---

## 5. Count longest line

```bash
wc -L file.txt
```

➡️ Length of longest line

---

# 🔹 Multiple files

```bash
wc file1.txt file2.txt
```

Output:

```text
10  50  300 file1.txt
5   20  100 file2.txt
15  70  400 total
```

---

# 🔹 Using with pipes (VERY IMPORTANT 🔥)

This is where `wc` becomes powerful.

---

## Count number of files

```bash
ls | wc -l
```

---

## Count matching files

```bash
find . -name "*.txt" | wc -l
```

---

## Count lines in logs

```bash
cat app.log | wc -l
```

👉 Better:

```bash
wc -l app.log
```

---

## Count processes

```bash
ps aux | wc -l
```

---

# 🔹 Read from stdin

```bash
echo "hello world" | wc
```

Output:

```text
1 2 12
```

👉 1 line, 2 words, 12 bytes

---

# 🔹 Real-world examples (important)

### 🔥 Count errors in logs

```bash
grep "ERROR" app.log | wc -l
```

---

### 🔥 Count Java files in project

```bash
find . -name "*.java" | wc -l
```

---

### 🔥 Count total lines of code

```bash
find . -name "*.java" -exec cat {} + | wc -l
```

---

# 🔴 Important notes

* `wc` counts **whitespace-separated words**
* Tabs, spaces, newlines affect results
* `-c` ≠ `-m` (bytes vs characters)

---

# 🧠 Mental model

Think of `wc` as:

> “counter tool for text streams”

---

# 💡 Pro tips (interview-level)

### Avoid useless `cat`

❌

```bash
cat file.txt | wc -l
```

✔️

```bash
wc -l file.txt
```

---

### Combine with `grep`

```bash
grep -c "ERROR" app.log
```

👉 faster than `grep | wc -l`

---

# 🔥 Summary

| Option | Meaning               |
| ------ | --------------------- |
| `wc`   | lines + words + bytes |
| `-l`   | lines                 |
| `-w`   | words                 |
| `-c`   | bytes                 |
| `-m`   | characters            |
| `-L`   | longest line          |

---

## 🚀 If you want next level

I can show you:

* how `wc` behaves with binary files
* how to use it in scripting (very important for backend/SRE)
* alternatives like `awk` for advanced counting

Just tell me 👍


The `du` command (**disk usage**) is essential in Linux for understanding **how much space files and directories are using**—especially useful for debugging storage issues 🔥

---

# 🔹 What is `du`?

👉 Shows disk usage of files and directories

### Basic syntax:

```bash
du [options] [path]
```

---

# 🔹 1. Basic usage

```bash
du
```

👉 Shows sizes of current directory **recursively** (in blocks, not human-readable)

---

# 🔹 2. Human-readable output

```bash
du -h
```

👉 Output like:

```
4.0K    ./dir1
12M     ./dir2
20M     .
```

✔️ Much easier to read (KB, MB, GB)

---

# 🔹 3. Show total only

```bash
du -sh
```

👉 Shows total size of current directory only:

```
20M     .
```

---

# 🔹 4. Check specific directory

```bash
du -sh /var/log
```

---

# 🔹 5. Show sizes of subdirectories

```bash
du -h --max-depth=1
```

👉 Example:

```
4.0K    ./dir1
12M     ./dir2
20M     .
```

---

# 🔹 6. Sort by size (VERY useful 🔥)

```bash
du -h --max-depth=1 | sort -h
```

👉 Helps you find largest folders

---

# 🔹 7. Find biggest files

```bash
du -ah | sort -h | tail -n 10
```

👉 Shows top 10 largest files

---

# 🔹 8. Include files (not just dirs)

```bash
du -ah
```

---

# 🔹 9. Exclude directories

```bash
du -h --exclude="node_modules"
```

---

# 🔹 10. Summarize multiple paths

```bash
du -sh dir1 dir2 file1
```

---

# 🔥 Real-world examples (important)

### 🔥 Check disk usage of project

```bash
du -sh .
```

---

### 🔥 Find what’s taking space

```bash
du -h --max-depth=1 | sort -hr
```

---

### 🔥 Analyze `/var`

```bash
du -h /var --max-depth=1
```

---

### 🔥 Find large logs

```bash
du -ah /var/log | sort -hr | head -n 10
```

---

# 🔴 Important notes

* `du` shows **actual disk usage**, not file size
* Hard links and sparse files affect results
* Different from `ls -lh`

---

# 🔹 `du` vs `ls`

| Command  | Shows      |
| -------- | ---------- |
| `du`     | disk usage |
| `ls -lh` | file size  |

👉 Example:

* A file might show `1GB` in `ls`
* But only use `100MB` in `du` (sparse file)

---

# 🧠 Mental model

Think of `du` as:

> “Where is my disk space going?”

---

# 💡 Pro tips (very important)

### ✔️ Always use:

```bash
du -h
```

### ✔️ Combine with sort:

```bash
du -h | sort -h
```

### ✔️ Use `-sh` for quick checks:

```bash
du -sh *
```

---

# ⚠️ Common mistake

```bash
du *
```

❌ Hard to read (not human-readable)

---

# 🔥 Summary

| Option        | Meaning         |
| ------------- | --------------- |
| `-h`          | human readable  |
| `-s`          | summary only    |
| `-a`          | include files   |
| `--max-depth` | limit recursion |
| `--exclude`   | ignore pattern  |

---

## 🚀 If you want next level

I can show you:

* how to debug “disk full” issues like an SRE
* difference between `du`, `df`, and inode usage
* real scripts to monitor disk automatically

Just tell me 👍
