## 128. Dynamic Input & Output: Process Substitution with `<(...)`& `>(...)`

This is one of the **most powerful Bash features** — and you’ll use it constantly in real work.

---

# 🧠 What is `$(...)` (Command Substitution)?

👉 It means:

> “Run a command, and use its output as a value”

---

# ⚡ Basic Example

```bash
echo $(date)
```

👉 Bash runs:

```bash
date
```

👉 Then replaces it:

```bash
echo Sun May 3 ...
```

---

# 🔥 Real Understanding

```bash
current=$(pwd)
echo "$current"
```

👉 You stored the output of `pwd` into a variable

---

# 🧪 More Examples

---

## 🔹 Store command output

```bash
files=$(ls)
echo "$files"
```

---

## 🔹 Use inside command

```bash
mkdir backup_$(date +%Y%m%d)
```

👉 Creates:

```
backup_20260503
```

---

## 🔹 Nested usage

```bash
echo "Today is $(date)"
```

---

# ⚠️ VERY IMPORTANT (Word Splitting Issue)

## ❌ Dangerous:

```bash
files=$(ls)
for f in $files; do
  echo "$f"
done
```

👉 Breaks on:

* spaces
* newlines

---

## ✅ Correct:

```bash
ls | while read -r f; do
  echo "$f"
done
```

---

# 🔥 Best Practice

👉 Always quote:

```bash
echo "$(date)"
```

---

# ⚠️ Old Syntax (Don’t Use)

```bash
echo `date`
```

❌ Hard to read
❌ Breaks with nesting

👉 Always use:

```bash
$(...)
```

---

# ⚙️ Real-World Use Cases

---

## 🟢 File processing

```bash
count=$(ls *.txt | wc -l)
echo "$count"
```

---

## 🟢 Docker

```bash
docker run -d --name app_$(date +%s) myapp
```

---

## 🟢 Logs

```bash
echo "Backup created at $(date)" >> log.txt
```

---

## 🟢 Environment usage

```bash
echo "Running on $(hostname)"
```

---

# 🧠 Advanced Insight

👉 Command substitution:

* Captures **stdout only**
* Removes trailing newline

---

## Example:

```bash
output=$(echo "hello")
```

👉 `output = "hello"` (no newline)

---

# ⚠️ Pitfalls

---

## ❌ Using with unsafe commands

```bash
rm $(ls *.txt)
```

👉 Dangerous if filenames have spaces

---

## ✅ Better:

```bash
rm *.txt
```

---

## ❌ Unquoted substitution

```bash
echo $(cat file.txt)
```

👉 May collapse spaces

---

## ✅ Safe:

```bash
echo "$(cat file.txt)"
```

---

# 🧠 Mental Model

When you see:

```bash
$(command)
```

Think:

👉 “Run this command FIRST, then replace it with its output”

---

# 🎯 Summary

| Pattern      | Meaning                    |
| ------------ | -------------------------- |
| `$(cmd)`     | run command and use output |
| `var=$(cmd)` | store output               |
| `"$(cmd)"`   | safe usage                 |
| nested       | allowed                    |

---

# 🧭 Where You Are Now

You’ve now covered:

* Globbing
* Tilde
* Variables `${}`
* Word splitting + IFS
* Quoting
* Escaping
* Brace expansion
* Command substitution

👉 This is **the full shell expansion system**

---

# 🚀 Next Step (VERY IMPORTANT)

Now stop theory.

👉 You’re ready to:

* Write real Bash scripts
* Automate Docker deployments
* Build Linux-based systems

---

# If you want real upgrade

I can give you:

👉 A **real-world script like:**

* Deploy Spring Boot with Docker
* Use `$(...)` for dynamic config
* Use all expansions together

Just say:

> give real script

This is a **power-user feature** in Bash — not always needed, but when you need it, it’s incredibly clean and elegant.

---

# 🧠 What is Process Substitution?

👉 It lets you treat the **output or input of a command like a file**

There are two forms:

| Syntax       | Meaning                              |
| ------------ | ------------------------------------ |
| `<(command)` | use command output as a file (input) |
| `>(command)` | send output to a command             |

---

# ⚡ 1. `<(command)` → Input substitution

👉 “Run a command and pretend its output is a file”

---

## 🔹 Example:

```bash
diff <(ls dir1) <(ls dir2)
```

👉 Instead of:

* creating temporary files
* saving outputs

👉 Bash does it automatically

---

## 🧪 What happens internally?

```bash
<(ls dir1)
```

👉 becomes something like:

```bash
/dev/fd/63
```

👉 A temporary file-like stream

---

# 🔥 Real Example

## Compare two commands:

```bash
diff <(sort file1.txt) <(sort file2.txt)
```

👉 No temp files needed ✔️

---

# ⚡ 2. `>(command)` → Output substitution

👉 “Send output to another command as if it’s a file”

---

## 🔹 Example:

```bash
echo "hello" > >(wc -c)
```

👉 Output:

```
6
```

👉 `echo` writes → `wc` reads

---

# 🔁 Combined Example

```bash
tee >(wc -l) >(wc -c) < file.txt
```

👉 Sends same input to:

* line count
* character count

---

# ⚙️ Real-World Use Cases

---

## 🟢 Compare logs

```bash
diff <(grep ERROR app1.log) <(grep ERROR app2.log)
```

---

## 🟢 Backup comparison

```bash
diff <(tar -tf backup1.tar) <(tar -tf backup2.tar)
```

---

## 🟢 Monitor output

```bash
command > >(tee log.txt)
```

👉 Output goes to:

* terminal
* file

---

## 🟢 Split output

```bash
echo "data" | tee >(cat > file1.txt) >(cat > file2.txt)
```

---

# ⚠️ Important Notes

---

## ❗ Requires Bash

👉 Not supported in `sh`

---

## ❗ Not real files

👉 These are **file descriptors**, not actual files

---

## ❗ Debugging is harder

👉 Since no physical files exist

---

# ⚠️ Common Pitfalls

---

## ❌ Forgetting quotes

```bash
diff <(cat file1) <(cat file2)
```

👉 OK

But mixing with variables:

```bash
diff <(cat "$file1") <(cat "$file2")
```

👉 Always quote variables

---

## ❌ Overusing it

👉 Sometimes simpler is better:

```bash
sort file1.txt > tmp1
sort file2.txt > tmp2
diff tmp1 tmp2
```

---

# 🧠 Mental Model

| Syntax   | Think                                 |
| -------- | ------------------------------------- |
| `<(cmd)` | “this command acts like a file input” |
| `>(cmd)` | “send output into this command”       |

---

# 🎯 Summary

| Pattern                                     | Meaning            |
| ------------------------------------------- | ------------------ |
| `<(cmd)`                                    | input from command |
| `>(cmd)`                                    | output to command  |
| avoids temp files                           | ✔️                 |
| works with tools like `diff`, `comm`, `tee` | ✔️                 |

---

# 🧭 Where You Are Now

You’ve just completed **advanced shell expansion & I/O control**:

* Command substitution `$(...)`
* Process substitution `<(...) >(...)`

👉 This is **upper-intermediate Bash (DevOps level)**

---

# 🚀 What’s Next (IMPORTANT)

Now you should STOP theory and move to:

👉 Real scripting:

* Deployment scripts
* Docker automation
* Log processing
* Backup systems

---

# If you want real upgrade

I can give you:

👉 A **real script like:**

* Deploy Spring Boot with Docker
* Use `<(...)`, `$(...)`, variables
* Production-style automation

Just say:

> give real script
