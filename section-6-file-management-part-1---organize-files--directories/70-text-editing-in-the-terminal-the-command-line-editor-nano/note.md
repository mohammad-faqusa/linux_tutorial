## 70. Text Editing in the Terminal: the Command-Line-Editor nano
`nano` is one of the simplest and most beginner-friendly **terminal text editors** in Linux. You’ll use it a lot for editing configs, scripts, and quick notes.

---

# 🔹 What is `nano`?

👉 A **command-line text editor**
👉 Easy alternative to editors like `vim` or `vi`

---

# 🔹 Open a file

```bash
nano file.txt
```

* If the file exists → opens it
* If not → creates a new file

---

# 🔹 Nano interface (important)

When you open `nano`, you’ll see:

* Text area (where you type)
* At the bottom:

  ```
  ^O Write Out   ^X Exit   ^K Cut   ^U Paste
  ```

👉 `^` means **Ctrl**

---

# 🔹 Basic shortcuts (VERY important)

## Save file

```
Ctrl + O   (Write Out)
```

Then press:

```
Enter
```

---

## Exit nano

```
Ctrl + X
```

---

## Save + Exit quickly

```
Ctrl + O → Enter → Ctrl + X
```

---

## Cut line

```
Ctrl + K
```

---

## Paste

```
Ctrl + U
```

---

## Search

```
Ctrl + W
```

---

## Undo (if supported)

```
Alt + U
```

---

## Redo

```
Alt + E
```

---

# 🔹 Editing tips

* Use **arrow keys** to move
* Start typing directly
* Backspace works normally

---

# 🔹 Open with line number

```bash
nano +10 file.txt
```

👉 Opens at line 10

---

# 🔹 Show line numbers

```bash
nano -l file.txt
```

---

# 🔹 Open multiple files

```bash
nano file1.txt file2.txt
```

Switch between them:

```
Alt + >   (next)
Alt + <   (previous)
```

---

# 🔹 Run as root (edit system files)

```bash
sudo nano /etc/nginx/nginx.conf
```

---

# 🔹 Real-world examples

### Edit config file

```bash
sudo nano /etc/hosts
```

---

### Create script

```bash
nano script.sh
```

Then:

```bash
chmod +x script.sh
```

---

# 🔴 Important behavior

When exiting:

```
Ctrl + X
```

You may see:

```
Save modified buffer? (Y/N)
```

* Press `Y` → save
* Press `N` → discard

---

# 🧠 Mental model

Think of `nano` as:

> “Notepad inside terminal”

---

# 🔥 Nano vs Vim (quick idea)

| Feature        | nano    | vim       |
| -------------- | ------- | --------- |
| Easy           | ✔️ very | ❌ harder  |
| Learning curve | low     | high      |
| Power          | medium  | very high |

👉 For now: **nano is perfect for you**

---

# 💡 Pro tips

### Always check before saving:

```
Ctrl + W → search
```

---

### Use for quick edits:

* config files
* scripts
* logs

---

# 🔥 Summary

| Action | Shortcut |
| ------ | -------- |
| Save   | Ctrl + O |
| Exit   | Ctrl + X |
| Cut    | Ctrl + K |
| Paste  | Ctrl + U |
| Search | Ctrl + W |

---

## 🚀 If you want next level

I can teach you:

* how to use `vim` like a pro (very important for SRE jobs)
* or how to configure nano with syntax highlighting

Just tell me 👍


