## 53. Exercise Intro: Website File Management

In Linux, both `rmdir` and `rm` are used to delete things—but they are **not the same**. Let’s break them down clearly:

---

## 🔹 `rmdir` (Remove Directory)

👉 Used **only to delete empty directories**

### ✅ Syntax:

```bash
rmdir directory_name
```

### ✅ Example:

```bash
rmdir test_folder
```

### ⚠️ Important:

* ❌ Will **fail** if the directory is **not empty**
* ❌ Cannot delete files
* ✔️ Safe (because it only removes empty folders)

---

## 🔹 `rm` (Remove)

👉 Used to delete **files AND directories**

### ✅ Basic syntax:

```bash
rm file_name
```

### ✅ Example (delete file):

```bash
rm notes.txt
```

---

## 🔥 Deleting directories with `rm`

### 1. Remove empty directory:

```bash
rm -d folder_name
```

### 2. Remove **non-empty directory (recursively)**:

```bash
rm -r folder_name
```

### 3. Force delete (no confirmation):

```bash
rm -rf folder_name
```

---

## ⚠️ VERY IMPORTANT (Danger 🚨)

```bash
rm -rf /
```

❌ This command can **delete your entire system**

So always be careful with:

* `-r` (recursive)
* `-f` (force)

---

## 🧠 Summary

| Command | What it deletes        | Works on non-empty dir? | Safe?        |
| ------- | ---------------------- | ----------------------- | ------------ |
| `rmdir` | Empty directories only | ❌ No                    | ✔️ Very safe |
| `rm`    | Files + directories    | ✔️ Yes (with `-r`)      | ⚠️ Risky     |

---

## 💡 Pro Tip (for safety)

Use interactive mode:

```bash
rm -ri folder_name
```

➡️ It will ask before deleting each file.

---

If you want, I can give you **real practice exercises** (like a mini lab) to master these commands 🔥
