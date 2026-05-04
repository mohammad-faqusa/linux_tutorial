## 55. Solution: Website File Management

Great—this is exactly the level you need for real Linux work 👌
Let’s cover **ALL common globbing (wildcard) patterns in Bash** with clear examples.

---

# 🔹 1. `*` → match ANY characters

👉 Matches **0 or more characters**

### Example:

```bash
ls *.txt
```

Matches:

```
file.txt
notes.txt
a.txt
```

---

# 🔹 2. `?` → match ONE character

👉 Exactly **one character only**

### Example:

```bash
ls file?.txt
```

Matches:

```
file1.txt
fileA.txt
```

❌ Not:

```
file10.txt
```

---

# 🔹 3. `[abc]` → match ONE from set

👉 Any one character inside brackets

### Example:

```bash
ls file[123].txt
```

Matches:

```
file1.txt
file2.txt
file3.txt
```

---

# 🔹 4. `[a-z]` → match range

👉 Any character in range

### Example:

```bash
ls file[a-c].txt
```

Matches:

```
filea.txt
fileb.txt
filec.txt
```

---

# 🔹 5. `[!abc]` → NOT in set

👉 Matches any character **except** listed ones

### Example:

```bash
ls file[!1].txt
```

Matches:

```
file2.txt
fileA.txt
```

❌ Not:

```
file1.txt
```

---

# 🔹 6. `[!a-z]` → NOT in range

### Example:

```bash
ls file[!a-z].txt
```

Matches files where that position is NOT a lowercase letter.

---

# 🔹 7. `{}` → brace expansion (NOT globbing but very related)

👉 Expands into multiple patterns

### Example:

```bash
echo file{1,2,3}.txt
```

➡️ Expands to:

```
file1.txt file2.txt file3.txt
```

---

### Range with braces:

```bash
echo file{1..5}.txt
```

➡️

```
file1.txt file2.txt file3.txt file4.txt file5.txt
```

---

# 🔹 8. `**` → recursive match (globstar)

👉 Matches directories **recursively**

⚠️ Must enable first:

```bash
shopt -s globstar
```

### Example:

```bash
ls **/*.txt
```

➡️ Finds all `.txt` files in:

* current directory
* subdirectories
* nested folders

---

# 🔹 9. `~` → home directory expansion

👉 Expands to user home

### Example:

```bash
cd ~
```

➡️ `/home/username`

---

# 🔹 10. `.*` → hidden files

👉 Matches hidden files (starting with `.`)

### Example:

```bash
ls .*
```

---

# 🔥 Important combo examples

### Delete all `.log` files:

```bash
rm *.log
```

---

### Copy multiple types:

```bash
cp *.{jpg,png} /backup/
```

---

### Match complex:

```bash
ls file[1-3]?.txt
```

➡️ Examples:

```
file1a.txt
file2b.txt
file3x.txt
```

---

# 🔴 Critical warning (very important)

```bash
rm -rf *
```

➡️ Deletes EVERYTHING in current directory
(because `*` expands to all files)

---

# 🧠 Summary Table

| Pattern  | Meaning                   |
| -------- | ------------------------- |
| `*`      | Any characters            |
| `?`      | One character             |
| `[abc]`  | One from set              |
| `[a-z]`  | Range                     |
| `[!abc]` | Not in set                |
| `{a,b}`  | Multiple expansions       |
| `{1..5}` | Range expansion           |
| `**`     | Recursive (with globstar) |
| `~`      | Home directory            |
| `.*`     | Hidden files              |

---

# 💡 Pro Tip (interview-level insight)

👉 Globbing happens in the **shell**, not the command

Example:

```bash
rm *.txt
```

Actually becomes:

```bash
rm file1.txt file2.txt file3.txt
```

---

If you want next level 🔥
I can teach you:
👉 difference between globbing vs regex vs find (VERY important for SRE/backend interviews)
