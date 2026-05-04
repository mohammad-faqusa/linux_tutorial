## 121. Accessing and Manipulating Values: Variable and Parameter Expansions `${...}`

Excellent — this is where Bash becomes **powerful, scriptable, and professional-level**.

---

# 🧠 What is `${...}` (Parameter Expansion)?

👉 `${...}` is how Bash:

* **reads variables**
* **modifies values**
* **applies logic to strings**

Think of it as:

> “Use and transform variable values inside the shell”

---

# ⚡ Basic Usage

## 🔹 Define a variable

```bash
name="mohammad"
```

## 🔹 Access it

```bash
echo $name
```

or (better):

```bash
echo ${name}
```

👉 Output:

```
mohammad
```

---

# 🔥 Why `${}` is Better than `$var`

Because it avoids ambiguity.

## ❌ Problem:

```bash
echo $name123
```

👉 Bash looks for variable `name123` (wrong)

---

## ✅ Correct:

```bash
echo ${name}123
```

👉 Output:

```
mohammad123
```

---

# 🧰 Powerful Expansions (Core Tools)

---

## 🟢 1. Default Value (if variable is empty)

```bash
echo ${name:-"default"}
```

👉 If `name` is empty → prints `"default"`

---

## 🔵 2. Assign Default Value

```bash
echo ${name:="default"}
```

👉 If `name` is empty:

* assigns `"default"`
* prints it

---

## 🔴 3. Error if not set

```bash
echo ${name:?"name is required"}
```

👉 If empty → script stops with error

---

# ✂️ String Manipulation

---

## 🟡 4. Get Length

```bash
echo ${#name}
```

👉 Number of characters

---

## 🟣 5. Substring

```bash
echo ${name:0:4}
```

👉 First 4 characters

---

## 🟠 6. Remove Prefix

```bash
file="test.txt"
echo ${file#*.}
```

👉 Output:

```
txt
```

---

## 🔵 7. Remove Suffix

```bash
echo ${file%.txt}
```

👉 Output:

```
test
```

---

## 🔥 8. Replace text

```bash
echo ${file/txt/log}
```

👉 Output:

```
test.log
```

---

# ⚙️ Real-World Usage (Freelancer Level)

---

## 🧪 Example: Safe environment variable

```bash
DB_HOST=${DB_HOST:-localhost}
```

👉 If not set → use `localhost`

---

## 🐳 Docker Example

```bash
docker run -e DB_NAME=${DB_NAME:-mydb} app
```

---

## 📦 Script Example

```bash
filename="backup.tar.gz"
echo ${filename%.gz}
```

👉 Output:

```
backup.tar
```

---

# ⚠️ Important Rules

## 1. Always use quotes in scripts

```bash
echo "${name}"
```

👉 Prevents bugs with spaces

---

## 2. Variables are case-sensitive

```bash
name != NAME
```

---

# 🧠 Mental Model

When you see:

```bash
${...}
```

Think:

👉 “Take a variable and transform it safely”

---

# 🎯 Summary

| Pattern           | Meaning           |
| ----------------- | ----------------- |
| `${var}`          | value of variable |
| `${#var}`         | length            |
| `${var:-default}` | default if empty  |
| `${var:=default}` | assign default    |
| `${var:0:3}`      | substring         |
| `${var%.ext}`     | remove suffix     |
| `${var#pattern}`  | remove prefix     |
| `${var/old/new}`  | replace           |

---

# 🧭 What’s next?

The next powerful concept is:

👉 Command substitution:

```bash
$(command)
```

👉 This is heavily used in:

* scripts
* Docker
* automation

---

If you want:
👉 I can give you a **real DevOps-style script using `${}`, `find`, and Docker together**
This will push you to the next level fast.
