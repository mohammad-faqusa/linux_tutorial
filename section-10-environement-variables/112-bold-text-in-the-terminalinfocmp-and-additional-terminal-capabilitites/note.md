## 112. Bold Text in the Terminal:`infocmp` and additional Terminal Capabilitites
## 🔹 Bold Text & Terminal Capabilities: `infocmp`, `tput`, and terminfo

![Image](https://images.openai.com/static-rsc-4/GHN0mzMZoPkSjG8xBM0A3XJQtRHY6i705rRK2biv2CCHmae0K29LR4rdkwj52EOfaXh83cn9D7hVvs3u4FulVbh8ec8AEvp2Xb-WOcQEAc3qMKiby59hGjQF-fWI39LvJ9Fm9AOFX2JRwc3wc183SwiM_JAIR0La1re0VwzDK_Wot9ef9UCLxUOrY99EED2T?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/XDRlolLsnsiQUFuiuhuPHOtdCzk2U4F5rRU4qCuPt4zHc6Qtpnn8ra-TyxT2P2V4kP0hTnaVryqJisnUgj_LMDU7nMwPrnL9g70aV6cQyXtgNmsGp2mDvNtUQt6wmXNa7mo_XM9n5LRcRGr_Es4IaG5TiksGD4lh0fPmb_62yxZL9o4ic0Vq-RCgVqMUOeoo?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/MxzLhgcSENGQmtYv1kfITrkHpPaeLKbyJdAQWx-RZlOFblvPK5jwXbCc0hjl9OzsfH1JTry3FydZHbjvZ5feHCjsG26uF6ZmYf-YA7PBhnaZ7AzvX9XqSfs8Guf_M5iUw8ubYpixplYHh3YcKv_ERe8eSuktTv7cSMQSZwJTFgOogu0S5LlxAtgTRDnt4BNd?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/trIMbiZ7xEUnwiCd-61TXMYOaBsbekv55wOTKrMM9jxovgbqeXX5uOapgZAAMWCIjtMM2uIUpn01L2fi3rO44QhC4_OK0OjoSOPxXU0m4w1i_bzKe9i6fWTuJNGOVxEfe8DuVoZM1Ru0ua3uqOSM4noLFOUQxD0vRvLbu6ioJzpaSt3gI29FEltPQyckEzht?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/u5iwXb44i9l-yLgsL_C1CoTZrrJoJZe4iRAmoSAODtGEdrYdNjscdpNA1Qi-KxAxjWhH0bHbrjTOwbwP9K44u1trplmQSCNETjcQ_y8Y2RhdnzOknpviq_r-jukxyALTB5FFrsVkH3QqRhCVWduK7GnjrZn72CRXAAimlxV_hUCUukCtoPfruQZh-Iw17JaG?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/FnWLuvNG6uN8ElJCuoCjTf3JLLkrndiivCOXhw7B69Pb_EDJPXngbbQanQw0Qs2Xr6lcHcIM1XkXfWAbHran7XXHD3cAM_TMiwPwwlRbVTcBbQuc2il1k7_tpsxNRaAGNAJdXmTJwns6XnH37YbHfiwhBoIX3b0-g0TNFMyYFuXzY5kzxu7npsgzXjdJxgCH?purpose=fullsize)

> Terminals support features (bold, colors, cursor movement) described in a **terminfo** database.
> Tools like `infocmp` (inspect) and `tput` (use) let you work with these features **portably**.

---

# 🔹 1) Quick win: print **bold** text

### Using ANSI (works almost everywhere)

```bash
echo -e "\e[1mBold text\e[0m"
```

* `\e[1m` → bold
* `\e[0m` → reset

---

### Using `tput` (portable ✔)

```bash
echo "$(tput bold)Bold text$(tput sgr0)"
```

* `tput bold` → turn bold on
* `tput sgr0` → reset all attributes

👉 Prefer `tput` in scripts for **better compatibility**.

---

# 🔹 2) What is `infocmp`?

> `infocmp` shows the **capabilities** of your current terminal type.

```bash
echo $TERM
```

Example:

```text
xterm-256color
```

```bash
infocmp
```

👉 You’ll see entries like:

```text
bold=\E[1m, sgr0=\E[0m, setaf=\E[3%p1%dm
```

* `bold` → sequence for bold
* `sgr0` → reset
* `setaf` → set foreground color

---

# 🔹 3) Use capabilities via `tput`

Instead of hardcoding `\e[...]`, use names:

```bash
tput bold      # bold on
tput sgr0      # reset
tput setaf 1   # red (foreground)
tput setab 4   # blue (background)
```

---

## 🔸 Example (bold + color)

```bash
echo "$(tput bold)$(tput setaf 2)SUCCESS$(tput sgr0)"
```

---

# 🔹 4) Why `tput` > raw ANSI (in scripts)

* Works across different `$TERM` types
* Handles terminals that don’t use standard ANSI
* More **portable** (important for servers, CI, SSH)

---

# 🔹 5) Common useful capabilities

| Command        | Meaning        |
| -------------- | -------------- |
| `tput bold`    | bold text      |
| `tput dim`     | dim text       |
| `tput smul`    | underline      |
| `tput rev`     | reverse colors |
| `tput sgr0`    | reset          |
| `tput setaf N` | set text color |
| `tput setab N` | set background |

---

# 🔹 6) Small script example (clean output)

```bash
#!/bin/bash

echo "$(tput bold)Starting script...$(tput sgr0)"

if mkdir test_dir; then
  echo "$(tput setaf 2)Success$(tput sgr0)"
else
  echo "$(tput setaf 1)Error$(tput sgr0)"
fi
```

---

# 🔹 7) Bonus: check terminal supports colors

```bash
tput colors
```

👉 Output:

* `8` → basic
* `256` → extended colors

---

# 🔹 Mental Model

```text
Terminal type ($TERM)
        ↓
terminfo database
        ↓
infocmp (inspect) / tput (use)
        ↓
formatted output (bold, color, etc.)
```

---

# 🔹 Common pitfalls ⚠️

* ❌ Hardcoding ANSI in scripts → may break on some terminals
* ❌ Forgetting reset (`sgr0`) → messy output
* ❌ Ignoring `$TERM` differences

---

# 🔥 Pro Insight (for your level 💡)

In real DevOps / backend tools:

* Use `tput` for logs and CLI tools
* Use bold + color to highlight:

  * errors 🔴
  * success 🟢
  * warnings 🟡

👉 Makes tools **professional and readable**

---

# 🔹 Summary

| Tool           | Purpose                                  |
| -------------- | ---------------------------------------- |
| `infocmp`      | inspect terminal capabilities            |
| `tput`         | use capabilities (portable)              |
| ANSI `\e[...]` | direct control (quick but less portable) |

---

## 🚀 Next Step

If you want, I can:

* Build a **professional CLI logger (INFO/WARN/ERROR with colors)**
* Show how tools like `docker`, `npm`, `git` use colors internally 🔥
