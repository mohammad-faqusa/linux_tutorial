## 182. The `kill` Command vs the Program `/usr/bin/kill`

This is one of those Linux topics that feels confusing until you realize a key idea:

> **`kill` is a shell built-in *and* also an external program (`/usr/bin/kill`) — but they are not the same thing in practice.**

---

# 🟣 1. `kill` (shell built-in)

When you type:

```bash id="a1k9dp"
kill 1234
```

you are usually using the **shell built-in version** (from Bash or Zsh).

## 💡 What it does:

* Sends signals to processes (SIGTERM by default)
* Works very fast (no need to start a new program)
* Supports job control (like `%1`)

### Example:

```bash id="k2m8qz"
kill -9 1234
```

---

## 🧠 Why built-in exists?

Because the shell already tracks:

* jobs
* background processes
* process groups

So it can handle signals efficiently.

---

# 🔵 2. `/usr/bin/kill` (external program)

This is a real executable file:

```bash id="v7x2ld"
which kill
```

Usually:

```
/usr/bin/kill
```

## 💡 What it does:

* Same core function: send signals
* But runs as a **separate process**

### Example:

```bash id="p9d3ka"
/usr/bin/kill -9 1234
```

---

# ⚖️ Key difference

| Feature            | Shell `kill`     | `/usr/bin/kill`         |
| ------------------ | ---------------- | ----------------------- |
| Type               | built-in command | external binary         |
| Speed              | faster           | slower (spawns process) |
| Job control (`%1`) | supported        | not supported           |
| Availability       | always in shell  | depends on PATH         |
| Behavior           | shell-aware      | simple tool             |

---

# 🧠 Most important difference (real-life)

## Shell kill can do this:

```bash id="m8q2xn"
kill %1
```

👉 kills a **job in background**

## `/usr/bin/kill` cannot:

* it does NOT understand shell jobs like `%1`

---

# 🔥 How to see both

```bash id="c4p8ld"
type kill
```

Output:

```
kill is a shell builtin
```

To force external:

```bash id="z2k9qa"
command kill 1234
```

or:

```bash id="n7v3mp"
/usr/bin/kill 1234
```

---

# 🧠 Simple mental model

> `kill` (builtin) = smart shell controller
> `/usr/bin/kill` = simple signal sender tool

---

# ⚡ When does it matter?

In 95% of cases:
👉 they behave the same

But differences matter when:

* using job control (`%1`, `%2`)
* writing scripts that depend on shell behavior
* debugging process management issues

---

# 🚀 Bonus insight

Linux follows a common pattern:

| Concept | Built-in | External tool           |
| ------- | -------- | ----------------------- |
| `echo`  | yes      | `/bin/echo`             |
| `kill`  | yes      | `/usr/bin/kill`         |
| `cd`    | yes      | ❌ (no external version) |

---

If you want, I can next explain:
👉 how signals travel from `kill` → kernel → process (very important for exams and real system understanding)

