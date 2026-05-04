## 124. Caution: Common Pitfalls in Shell Expansions

This topic is gold. If you understand these pitfalls, you jump from “I know Bash” to **“I don’t break production”**.

I’ll give you the **real mistakes engineers make** (and how to avoid them).

---

# ⚠️ 1. Unquoted Variables (BIGGEST BUG SOURCE)

## ❌ Wrong:

```bash
file="my file.txt"
rm $file
```

👉 Expands to:

```bash
rm my file.txt
```

👉 Deletes wrong things or fails

---

## ✅ Correct:

```bash
rm "$file"
```

---

## 🔥 Rule:

> Always write: `"${var}"`

---

# ⚠️ 2. Word Splitting with Command Substitution

## ❌ Wrong:

```bash
files=$(ls)
for f in $files; do
  echo $f
done
```

👉 Breaks on spaces/newlines

---

## ✅ Correct:

```bash
ls | while read -r f; do
  echo "$f"
done
```

---

# ⚠️ 3. Globbing Accidents (`*`)

## ❌ Dangerous:

```bash
rm *
```

👉 Deletes EVERYTHING

---

## ❌ Worse:

```bash
rm $dir/*
```

👉 If `$dir` is empty → becomes:

```bash
rm /*
```

💀 System destruction

---

## ✅ Safe:

```bash
rm "$dir"/*
```

(or better: validate variable first)

---

# ⚠️ 4. Empty Variables

## ❌ Example:

```bash
rm "$dir"/*
```

If:

```bash
dir=""
```

👉 Becomes:

```bash
rm /*
```

---

## ✅ Safe check:

```bash
[ -n "$dir" ] && rm "$dir"/*
```

---

# ⚠️ 5. Using `ls` in Scripts

## ❌ Wrong:

```bash
for f in $(ls *.txt); do
  echo "$f"
done
```

👉 Breaks on spaces

---

## ✅ Correct:

```bash
for f in *.txt; do
  echo "$f"
done
```

---

# ⚠️ 6. Misunderstanding Quotes

## ❌ Wrong:

```bash
echo '$HOME'
```

👉 Output:

```
$HOME
```

---

## ✅ Correct:

```bash
echo "$HOME"
```

---

# ⚠️ 7. Tilde Not Expanding in Quotes

## ❌ Wrong:

```bash
echo "~"
```

👉 Output:

```
~
```

---

## ✅ Correct:

```bash
echo ~
```

---

# ⚠️ 8. IFS Side Effects

## ❌ Problem:

```bash
IFS=","
for x in $data; do ...
```

👉 If not reset → breaks other parts

---

## ✅ Fix:

```bash
IFS=","
...
unset IFS
```

or:

```bash
IFS=$' \t\n'
```

---

# ⚠️ 9. Missing `-r` in read

## ❌ Wrong:

```bash
read file
```

👉 Backslashes get interpreted

---

## ✅ Correct:

```bash
read -r file
```

---

# ⚠️ 10. Using Relative Paths Carelessly

## ❌ Problem:

```bash
rm *.log
```

👉 Depends on current directory

---

## ✅ Better:

```bash
rm /var/log/app/*.log
```

---

# 🔥 Freelancer-Level Mindset

When writing Bash:

👉 Always ask:

* What if variable is empty?
* What if filename has spaces?
* What if pattern matches nothing?
* What if this runs on production?

---

# 🧠 Golden Rules (Memorize These)

1. Always quote variables → `"${var}"`
2. Never parse `ls`
3. Validate variables before dangerous commands
4. Test with `echo` before `rm`
5. Assume filenames contain spaces

---

# 🎯 Summary

| Pitfall            | Fix                    |
| ------------------ | ---------------------- |
| Unquoted variables | `"${var}"`             |
| `$(ls)` usage      | use globbing or `read` |
| `rm *` danger      | test first             |
| Empty variables    | validate               |
| Quotes misuse      | understand `'` vs `"`  |

---

# 🧭 Where You Are Now

You just finished:

* Globbing
* Tilde
* Variables `${}`
* Word splitting
* Quoting
* Pitfalls

👉 This is **advanced Bash foundation**

---

# 🚀 Next Level

Now you’re ready for:

* Command substitution `$(...)`
* Pipes & redirection (advanced)
* Writing real scripts
* Automating deployments (Docker + Linux)

---

If you want:
👉 I’ll give you a **real broken deployment script** (Docker + Linux)
You fix it step by step like a DevOps engineer

This will make everything click.
