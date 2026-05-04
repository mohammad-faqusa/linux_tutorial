## 86. Character Replacements and Reversal: the Utilities `tr` & `rev`

Now you’re getting into **text transformation tools**: `tr` and `rev`.
These are small, but **very powerful when combined with pipes**.

---

# 🔹 1. `tr` — Translate / Transform characters

## What it does:

> **Replaces, deletes, or squeezes characters from input**

⚠️ Important:
`tr` works on **characters**, not words.

---

## 🔹 Basic syntax

```bash
command | tr 'set1' 'set2'
```

---

## 🔹 Example 1: Replace characters

```bash
echo "hello world" | tr 'a-z' 'A-Z'
```

👉 Output:

```text
HELLO WORLD
```

---

## 🔹 Example 2: Replace spaces with dashes

```bash
echo "hello world" | tr ' ' '-'
```

👉 Output:

```text
hello-world
```

---

## 🔹 Example 3: Delete characters

```bash
echo "hello123" | tr -d '0-9'
```

👉 Output:

```text
hello
```

---

## 🔹 Example 4: Remove duplicate characters (squeeze)

```bash
echo "heyyy   broooo" | tr -s ' '
```

👉 Output:

```text
heyyy broooo
```

👉 `-s` = squeeze repeated characters into one

---

## 🔥 Real use cases

### Clean log data

```bash
cat file.txt | tr -d '\r'
```

👉 Removes Windows carriage return

---

### Normalize text

```bash
cat file.txt | tr 'A-Z' 'a-z'
```

👉 Convert everything to lowercase

---

---

# 🔹 2. `rev` — Reverse text

## What it does:

> **Reverses each line of text**

---

## 🔹 Example

```bash
echo "hello" | rev
```

👉 Output:

```text
olleh
```

---

## 🔹 Example with file

```bash
rev file.txt
```

👉 Each line is reversed

---

## 🔥 Useful trick

### Reverse twice (for processing)

```bash
echo "hello world" | rev | cut -d' ' -f1 | rev
```

👉 Output:

```text
world
```

### Why?

* `rev` → "dlrow olleh"
* `cut -f1` → "dlrow"
* `rev` → "world"

👉 Extract last word (smart trick 🔥)

---

# 🔹 Combining `tr` + `rev`

## Example

```bash
echo "hello world" | tr 'a-z' 'A-Z' | rev
```

👉 Output:

```text
DLROW OLLEH
```

---

# 🔹 Mental Model

### `tr`

```text
input → character transformation → output
```

### `rev`

```text
input → reverse each line → output
```

---

# 🔹 Summary

| Command | Purpose                           |
| ------- | --------------------------------- |
| `tr`    | Replace/delete/squeeze characters |
| `rev`   | Reverse text                      |

---

# 🔥 Pro Insight (important for you 💡)

You’ll use these in:

* Data cleaning pipelines
* Log preprocessing
* CLI automation scripts
* Text normalization before parsing (very useful with `grep`, `awk`)

---

## 🚀 Next Level

If you continue this path:

👉 `cut` → `tr` → `grep` → `sort` → `uniq` → `rev`
➡️ Next step is **`awk` + `sed`**

These two = **real Linux mastery**

---

If you want, I can now:
✅ Give you real exercises (like interview-level Linux tasks)
or
✅ Show you how all these commands combine in a real backend debugging scenario
