## 120. Referencing the Home Directory: the Tilde expansion `~`

Great — this is another **fundamental Bash feature** you’ll use all the time.

---

# 🧠 What is `~` (Tilde Expansion)?

👉 `~` is a shortcut for your **home directory**

For example, if your username is `mohammad`, then:

```bash
~
```

👉 expands to:

```bash
/home/mohammad
```

---

# ⚡ Basic Usage

## 🔹 Go to home directory

```bash
cd ~
```

Same as:

```bash
cd /home/mohammad
```

---

## 🔹 Access files in home

```bash
ls ~/Desktop
```

👉 means:

```bash
ls /home/mohammad/Desktop
```

---

## 🔹 Create a file in home

```bash
touch ~/test.txt
```

---

# 🔥 Very Important Variations

## 🟢 `~` → Your home

```bash
echo ~
```

---

## 🔵 `~username` → Another user’s home

```bash
ls ~root
```

👉 expands to:

```bash
/root
```

---

## 🟡 `~+` → Current directory

```bash
echo ~+
```

👉 same as:

```bash
pwd
```

---

## 🟣 `~-` → Previous directory

```bash
echo ~-
```

👉 same as:

```bash
OLDPWD
```

---

# ⚠️ Important Rules

## ❌ Does NOT work in quotes:

```bash
echo "~"
```

👉 Output:

```
~
```

👉 No expansion happens

---

## ✅ Works without quotes:

```bash
echo ~
```

👉 Output:

```
/home/mohammad
```

---

# 🔥 Real Usage (Freelancer Level)

You will use `~` constantly in:

* Scripts
* Docker configs
* SSH commands
* File paths

---

## Example:

```bash
scp file.txt user@server:~/app/
```

👉 Sends file to:

```
/home/user/app/
```

---

# 🧠 Why it matters

Instead of writing:

```bash
/home/mohammad/projects/backend
```

You write:

```bash
~/projects/backend
```

👉 Shorter, cleaner, portable

---

# 🎯 Summary

| Symbol  | Meaning             |
| ------- | ------------------- |
| `~`     | your home directory |
| `~user` | another user’s home |
| `~+`    | current directory   |
| `~-`    | previous directory  |

---

# 🧭 What’s next?

After tilde expansion, the next important topics are:

* Variable expansion (`$HOME`, `$PATH`)
* Command substitution (`$(...)`)
* Brace expansion `{}`

---

If you want:
👉 I can give you a **mini challenge combining `~`, `find`, and globbing** (real-world level)
