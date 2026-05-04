## 107. Fine-Tuning Shell Behavior (Bash): the Command `shopt`

## 🔹 `shopt` — Fine-tuning Bash behavior

![Image](https://images.openai.com/static-rsc-4/prXN9tlc0wbywrI0p0mnzyHq8a_6ExLae8qubzE0LIz1eZKm46gVf8cq0J3ob1pZYjsUEDV0FsTXMfB4TB96G3BPIGvPXUPtZ7p3fu9b1wTVg-DJa91gKGJZKAa_W24mFAbHn6iVkiuhdY2dsqaTh-F-FrForZ8AxeEtpWNdhO98axN-ees_hTAIqj7rNt31?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/q4rkIKOx4wJ36Ii9jlT07Nbnbt3erot8UG1AhCE8U75IzA0SF-nqlIBXxcR44LhH7CnRglP4jUPTG2Bkdey9OhuW_2imwkbqlYnoxFLelVopvNOZSSzQyJ7mhkH_Dp0hTcnljvqiAb0C3BQOZQVV5xNW6QTUnYoPpUafsQVGyfhbY30FBttN4zLm0y5AhdJd?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/2ZHZbqJt_Qcsx1tnR6BF4SRCpRlzbaMb0Axe_vlfNsZCTyGQG44MuSUFBPAjwl_vY3DTSOWBeYfXLgLZJ6zbfRc-L5lUEq6QzyLYIv3pSKd5QrAKHSlxvYmuGebmjTXJ9tFK_iFRDKEGmlZgKZOBB1uscK6eGZ3_KvwOpHuN4FkrCiqE9KVLEFPKGZKqtjQL?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/BaAjPxfFbAgebDrq5a0BwzYmXsZ_-zBloQZseOVytlHI74hm1ca5CJBcZooeqrk5WBqSGPMzJJYNi4AVDtVIK9PdxXu6FhUMXndSShy7F6LWiVjtLOMg9cavcySnYphG4dmfE3iDNCLFNs5sUbKFbdntL8v5X5ab8ecTiZNDN4laU3OXVm26YFssKyU0Pb27?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/7K00x9VoxjmhyNmcVNUzk1Sb_YqoJSCLnb0gnOs1YcQIRuvGZAQx8U2LMZHa0kTLOtlIIfZ1iber-sO_MciqaEuC5qp0IS72f4MaidVE0V8Fo7E9EpowpK4-hmF8hyBw4XgX5Gk8NTPtSNu5pu9LzDgk6nuvml1JTcGLhkX0JoQ_NMEoJKDph28Qq-VOeEL9?purpose=fullsize)

> `shopt` (**sh**ell **opt**ions) controls **Bash-specific features**—things that `set` doesn’t cover (mainly globbing, history, and interactive niceties).

---

# 🔹 1) See what’s available / enabled

```bash
shopt        # list all options with on/off
shopt -p     # print in a reusable form
shopt -s     # show only enabled
shopt -u     # show only disabled
```

---

# 🔹 2) Turn options ON / OFF

```bash
shopt -s option_name   # enable
shopt -u option_name   # disable
```

👉 Example:

```bash
shopt -s dotglob
shopt -u dotglob
```

---

# 🔹 3) Most useful options (you’ll actually use)

---

## 🔸 `dotglob` — include hidden files in globs

```bash
shopt -s dotglob
echo *     # now includes .env, .gitignore, etc.
```

👉 Normally `*` ignores files starting with `.`

---

## 🔸 `nullglob` — safer globbing

```bash
shopt -s nullglob
files=(*.log)
```

👉 If no `.log` files:

* ❌ without `nullglob` → `files=("*.log")`
* ✅ with `nullglob` → `files=()` (empty)

---

## 🔸 `globstar` — recursive globbing (VERY USEFUL 🔥)

```bash
shopt -s globstar
ls **/*.java
```

👉 Finds files in **all subdirectories**

---

## 🔸 `nocaseglob` — case-insensitive matching

```bash
shopt -s nocaseglob
ls *.TXT   # matches file.txt
```

---

## 🔸 `autocd` — cd by typing directory name

```bash
shopt -s autocd
projects   # same as: cd projects
```

---

## 🔸 `histappend` — don’t overwrite history

```bash
shopt -s histappend
```

👉 Keeps command history across sessions

---

## 🔸 `checkwinsize` — auto adjust terminal size

Usually enabled:

```bash
shopt -s checkwinsize
```

---

# 🔹 4) Example (real usage)

```bash
#!/bin/bash

shopt -s nullglob globstar

for file in **/*.log; do
  echo "Found: $file"
done
```

👉 Safe + recursive file search

---

# 🔹 5) Persist settings (IMPORTANT)

Add to your:

```bash
~/.bashrc
```

Example:

```bash
shopt -s globstar nullglob histappend
```

Then:

```bash
source ~/.bashrc
```

---

# 🔹 6) `shopt` vs `set`

| Tool    | Purpose                                 |
| ------- | --------------------------------------- |
| `set`   | core shell behavior (errors, debugging) |
| `shopt` | Bash features (globbing, UX)            |

---

# 🔹 Mental Model

```text
set   → safety & execution behavior
shopt → convenience & Bash features
```

---

# 🔥 Pro Insight (for your level 💡)

The combo used by pros:

```bash
set -euo pipefail
shopt -s nullglob globstar
```

👉 Result:

* Safe scripts
* Powerful file handling
* No silent bugs

---

# 🔹 Common pitfalls ⚠️

* Forgetting `nullglob` → loops break on missing files
* Not using `globstar` → writing complex `find` unnecessarily
* Not saving in `.bashrc` → settings lost

---

# 🔹 Summary

| Command    | Meaning              |
| ---------- | -------------------- |
| `shopt`    | list options         |
| `shopt -s` | enable               |
| `shopt -u` | disable              |
| `globstar` | recursive `**`       |
| `nullglob` | safe globbing        |
| `dotglob`  | include hidden files |

---

## 🚀 Next Step

If you want, I can:

* Give you **real scripting exercises** combining `set + shopt`
* Show when to use `find` vs `globstar`
* Build a **mini DevOps tool in bash** 🔥

Just tell me 👍
