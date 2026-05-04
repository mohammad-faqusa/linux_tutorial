## 95. The Environment Variables HOME, PWD & USER

## 🔹 Core Environment Variables: `HOME`, `PWD`, `USER`

![Image](https://images.openai.com/static-rsc-4/fJ9DaiZo3IpegaaYrAK2vyXXhIDSreMKtZeWgiREGY7-CTiOyhwiNqsrTwCS8YhVSQYICld5zCq6dgnCGy5nLjvQD1FGweQkVIpjPyMOWZxlKH7-PEtrqujP9HLvuWM3G31xpCjcbA0BIZaAZI54aMy0qekA6wlYqckG21PElUbsYRroX6_u4eVqWeEO8TN1?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/qp7WHE49yTxo4vwbiN-bLo3f0biw1BtktL4AMVvtQ2-VTBWRi4Bto5YUpWWRJ_oKNB_vso1YGzjVP9a59VrLsgc5ESpEEu-v7OhRTPl9HTfuqVxPIrMjdZ3JJ_gIg6aifQFM_C7Z8uQZ6zaZYkvOWcsCiTsSzk96sUxQ0g3jnnDuX178IXwNnVmWqtMbaX9P?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/2M2CZAINU6987jkURVjpVfWb170CoNJ_XyEIMpfKrX6uoE86UZS6OnhtncmMKulbQHzvnIGB0PO7ntBmS7iKNIR4OZirSldx-M8Sh66iFqFL7Ta6BTa11jwnMnYS58f5Lp3jmF2dAHA1HEguVhstXGJQ8uOShyTlXjEMFIp36jJHGqTM_BvFGyhydkwQ_liO?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/7zxrq_WgI6RkWbLhK0WMf3ucyrEF1kJm55fXu85BAH4_WKyt2wFAnRI6_kEwuY7PGsqVrjy1WsDIDVbq3Gqii8N1j9cV_cAnvpAGe1B4qzwPSEcJYQJZd4u6pGHuIlnyCjByhc3KFK5TU2nMraHep-Aam9juaI2DmbY4cFXi2RvNKqnijq9nFCtrI6sVvebp?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/MwJzrg_Fy0lmaOCqkoWvgcVJJ5kbg12FR6PhNUT6yfWgA-H3EcgloS4BSCaFnExZCjNib-w_l2YYwbpFUo-c98ueRCcECQHyRb5N_ZlgKLdmOygqCN_5nw1cnYCQX9lv5MCg1duQHtXfNGJHuzLQn0fwKpwvXiX_bivicCJ8lTFUsY8n145JfzGP01gUD8J_?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/CpKlcut_Nhyj3cU5nidIf93AlZg9NCOMFY8TrVSiDqeMFG5o3ugrHj7ZPYke6A3E9baeRlDQ659Vg3zpB0sKd_hSX015Q7RbxTVx1cQjM7k_vef4FLShONZbsbMj3rdAGtMOsS048uz3lLOggC5MKGrYVVCse83Hmt_TUOrLW4i1qcuZ25UrRyg1UzSi-aMs?purpose=fullsize)

These three variables are **fundamental in every Linux shell session**.

---

# 🔸 1. `$HOME` — Your Home Directory

> **The default directory for your user**

---

## 🔹 Check it

```bash
echo $HOME
```

👉 Example:

```text
/home/mohammad
```

---

## 🔹 Why it matters

* Where your personal files live
* Where configs are stored (`.bashrc`, `.ssh`, etc.)

---

## 🔹 Shortcut

```bash
cd ~
```

👉 `~` = `$HOME`

---

## 🔹 Real use

```bash
cd $HOME/projects
```

---

# 🔸 2. `$PWD` — Present Working Directory

> **The directory you are currently in**

---

## 🔹 Check it

```bash
echo $PWD
```

👉 Same as:

```bash
pwd
```

---

## 🔹 Example

```bash
cd /etc
echo $PWD
```

👉 Output:

```text
/etc
```

---

## 🔹 Why it matters

* Used in scripts
* Helps track current location
* Useful for relative paths

---

# 🔸 3. `$USER` — Current User

> **The username of the logged-in user**

---

## 🔹 Check it

```bash
echo $USER
```

👉 Example:

```text
mohammad
```

---

## 🔹 Alternative

```bash
whoami
```

---

## 🔹 Why it matters

* Permissions
* File ownership
* Security

---

# 🔹 Putting them together 🔥

```bash
echo "User: $USER"
echo "Home: $HOME"
echo "Current Dir: $PWD"
```

---

# 🔹 Real-world examples (IMPORTANT 💡)

## 🔸 1. Create user-specific file

```bash
touch /home/$USER/myfile.txt
```

---

## 🔸 2. Navigate safely

```bash
cd $HOME
```

---

## 🔸 3. Use in scripts

```bash
#!/bin/bash
echo "Hello $USER, you are in $PWD"
```

---

# 🔹 Mental Model

```text
USER → who you are
HOME → where you belong
PWD  → where you are now
```

---

# 🔹 Summary

| Variable | Meaning             |
| -------- | ------------------- |
| `$HOME`  | Your home directory |
| `$PWD`   | Current directory   |
| `$USER`  | Current user        |

---

# 🔥 Pro Insight (for your career)

You’ll use these constantly in:

* Shell scripts
* Docker containers
* Deployment scripts
* Backend environments

👉 Especially `$HOME` and `$PWD` when handling file paths

---

## 🚀 Next Step

You’re now ready for:

* `$PATH` deep dive (very important 🔥)
* Shell variables vs environment variables
* Writing real shell scripts

Just tell me 👍
