## 122. Word splitting & the variable IFS

This is one of the **most critical Bash topics** — it controls *how the shell interprets everything*.

If you master quoting, you avoid **real production bugs**.

---

# 🧠 The 3 Types of Quoting

| Type              | Behavior                  |
| ----------------- | ------------------------- |
| No quotes         | Everything is interpreted |
| `'single quotes'` | Nothing is interpreted    |
| `"double quotes"` | Partial interpretation    |

---

# ⚡ 1. No Quotes (❌ Dangerous)

👉 Bash performs:

* Variable expansion `$var`
* Word splitting (IFS)
* Globbing (`*`, `?`)
* Command substitution `$(...)`

---

## Example:

```bash
name="mohammad faqusa"
echo $name
```

👉 Bash splits:

```bash
echo mohammad faqusa
```

👉 Output:

```
mohammad faqusa
```

But internally → **2 arguments (danger)**

---

## ❌ Problem:

```bash
file="my file.txt"
ls $file
```

👉 Becomes:

```bash
ls my file.txt
```

👉 ❌ ERROR

---

# 🔒 2. Single Quotes `'...'` (Strongest Protection)

👉 NOTHING is interpreted inside

---

## Example:

```bash
name="mohammad"
echo '$name'
```

👉 Output:

```
$name
```

---

## Even this is literal:

```bash
echo '$(date)'
```

👉 Output:

```
$(date)
```

---

## ✅ Use when:

* You want exact text
* No variables
* No expansions

---

# ⚖️ 3. Double Quotes `"..."` (Most Important)

👉 Allows:

* Variable expansion `$var`
* Command substitution `$(...)`

👉 Prevents:

* Word splitting
* Globbing

---

## Example:

```bash
name="mohammad faqusa"
echo "$name"
```

👉 Output:

```
mohammad faqusa
```

👉 Treated as **ONE argument** ✔️

---

## Another example:

```bash
echo "Today is $(date)"
```

👉 Output:

```
Today is Sun May 3 ...
```

---

# 🔥 Side-by-Side Comparison

```bash
file="my file.txt"
```

### ❌ No quotes

```bash
ls $file
```

👉 ERROR

---

### ❌ Single quotes

```bash
ls '$file'
```

👉 looks for file literally named `$file`

---

### ✅ Double quotes

```bash
ls "$file"
```

👉 Correct ✔️

---

# 🧪 Globbing Example

```bash
echo *.txt
```

👉 Expands to filenames

---

```bash
echo "*.txt"
```

👉 Output:

```
*.txt
```

👉 No expansion

---

# 🔥 Freelancer-Level Rule

👉 **ALWAYS use double quotes for variables**

```bash
"$var"
```

---

# ⚠️ Common Real Bugs

## ❌ Bad script:

```bash
for file in $(ls); do
  echo $file
done
```

👉 Breaks on spaces

---

## ✅ Correct:

```bash
ls | while read -r file; do
  echo "$file"
done
```

---

# 🧠 Mental Model

| Type      | Think of it as  |
| --------- | --------------- |
| No quotes | “Do everything” |
| `'...'`   | “Do nothing”    |
| `"..."`   | “Safe mode”     |

---

# 🎯 Summary

| Feature          | No quotes | `'...'` | `"..."` |
| ---------------- | --------- | ------- | ------- |
| Variables `$var` | ✅         | ❌       | ✅       |
| Word splitting   | ✅         | ❌       | ❌       |
| Globbing `*`     | ✅         | ❌       | ❌       |
| Command `$(...)` | ✅         | ❌       | ✅       |

---

# 🧭 What’s next?

You now completed:

* Globbing
* Tilde expansion
* Variables `${}`
* Word splitting
* Quoting

👉 This is the **core of Bash mastery**

---

# 🚀 If you want next level

I can give you:
👉 A **real broken script with all these mistakes**, and we fix it like a DevOps engineer

This will level you up FAST.
