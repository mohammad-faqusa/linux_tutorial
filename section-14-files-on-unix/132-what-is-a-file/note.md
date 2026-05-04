## 132. What is a File?


Great question—this is **core Linux knowledge** and very important for your backend + Linux mastery path. Let’s break it clearly 👇

---

# 🔹 What is a File in Linux?

In Linux, a **file** is simply a **container for data**.

This data could be:

* Text (like `.txt`)
* Program code (like `.java`, `.py`)
* Binary executable (`/bin/ls`)
* Even hardware devices!

👉 That’s why we say:

> **“In UNIX/Linux, everything is a file”**

---

# 🔹 Types of Files in Linux

You can check file type using:

```bash
ls -l
```

You’ll see something like:

```
-rw-r--r--  file.txt
drwxr-xr-x  myfolder
```

### Common file types:

| Symbol | Type             | Description                 |
| ------ | ---------------- | --------------------------- |
| `-`    | Regular file     | Text, binary, etc.          |
| `d`    | Directory        | Folder containing files     |
| `l`    | Symbolic link    | Shortcut                    |
| `c`    | Character device | Keyboard, terminal          |
| `b`    | Block device     | Disk (HDD/SSD)              |
| `p`    | Pipe             | Inter-process communication |
| `s`    | Socket           | Network communication       |

---

# 🔹 What is a Directory (Folder)?

A **directory is also a file** ❗

👉 But instead of storing data, it stores:

* Names of files
* References (inodes) to those files

So:

```
Directory = file that maps names → actual files
```

---

# 🔹 File Attributes (Metadata)

Every file has **attributes** (metadata), not just content.

Run:

```bash
ls -l
```

Example:

```
-rw-r--r-- 1 user group 1234 May 4  file.txt
```

### Attributes explained:

| Part        | Meaning            |
| ----------- | ------------------ |
| `-`         | File type          |
| `rw-r--r--` | Permissions        |
| `1`         | Number of links    |
| `user`      | Owner              |
| `group`     | Group              |
| `1234`      | Size (bytes)       |
| `May 4`     | Last modified date |
| `file.txt`  | File name          |

---

# 🔹 Permissions (Important)

Example:

```
rw-r--r--
```

Breakdown:

* Owner: `rw-` → read + write
* Group: `r--` → read only
* Others: `r--` → read only

---

# 🔹 How Files Are Stored (VERY IMPORTANT ⚡)

Linux uses a structure called:

👉 **inode (index node)**

Each file has an inode that stores metadata.

### 🔹 Inode contains:

* File size
* Permissions
* Owner
* Timestamps
* Pointers to data blocks

### 🔹 NOT stored in inode:

* ❌ File name

👉 File name is stored in the **directory**, not the inode!

---

# 🔹 How it actually works

When you access a file:

1. Directory maps:

```
file.txt → inode 12345
```

2. Inode 12345 contains:

* Metadata
* Location of actual data on disk

3. System reads data blocks from disk

---

# 🔹 Example (Real Concept)

```
/home/mohammad/file.txt
```

Flow:

```
Directory (/home/mohammad)
        ↓
maps "file.txt" → inode 123
        ↓
inode 123 → data blocks on disk
```

---

# 🔹 Why “Everything is a File”?

Linux treats everything using the same interface:

Examples:

```bash
/dev/sda      # hard disk
/dev/tty      # terminal
/dev/null     # black hole file
```

You can:

```bash
cat /dev/null
```

👉 Even devices behave like files!

---

# 🔹 Summary (Very Important 🔥)

* File = container for data
* Directory = special file mapping names → inodes
* Each file has:

  * Data
  * Metadata (attributes)
* Metadata stored in:
  👉 **inode**
* File name stored in:
  👉 **directory**
* Linux treats:
  👉 **everything as a file**

---

# 🔥 Interview Tip (IMPORTANT for you)

If interviewer asks:

👉 *“How Linux stores files?”*

Answer:

> Linux uses inodes to store file metadata and data block pointers, while directories map filenames to inode numbers.

---

If you want next level 🚀
I can explain:

* hard link vs symbolic link (very important)
* how `rm` actually deletes files internally
* filesystem structure (ext4, blocks, superblock)

Just tell me 👍

