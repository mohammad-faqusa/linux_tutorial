Nice — let’s compress everything into a clean **cheat sheet** you can remember for interviews and real work 👇

---

# 🧠 🔥 Linux User & Group Commands (Summary)

## 👤 User Management

### ➕ Create user

```bash
sudo useradd username
```

---

### ❌ Delete user

```bash
sudo userdel username        # keep files
sudo userdel -r username     # delete user + home directory
```

---

### 🔍 Check user

```bash
id username
```

---

## 👥 Group Management

### ➕ Add user to group

👉 On Ubuntu/Debian:

```bash
sudo usermod -aG sudo username
```

👉 On CentOS/Rocky:

```bash
sudo usermod -aG wheel username
```

---

### ❌ Remove user from group (safe way)

```bash
sudo gpasswd -d username group
```

---

### 🔍 Check groups

```bash
groups username
```

---

## ⚙️ Important Options (VERY IMPORTANT)

### `usermod`

- `-G` → set groups (REPLACES all groups ❌)
    
- `-aG` → append group (SAFE ✅)
    

---

### `gpasswd`

- `-a` → add user to group
    
- `-d` → delete user from group
    

---

## 🔑 Sudo Concept

```bash
sudo command
```

👉 Run command as **root (admin)**

---

## ⚠️ System Differences

|System|Admin Group|
|---|---|
|Ubuntu / Debian|`sudo`|
|CentOS / Rocky|`wheel`|

---

## 🔄 Apply changes

After modifying groups:

```bash
su - username
```

or logout/login

---

## 🧠 Golden Rules

- ✅ Always use `-aG` (never just `-G`)
    
- ✅ Use `gpasswd -d` to remove safely
    
- ❌ Don’t edit `/etc/sudoers` without `visudo`
    
- ❌ Don’t delete users with `-r` unless sure
    

---

## 🔥 Interview One-Liner

> “I manage users with `useradd`, `usermod`, `userdel`, and handle group membership safely using `-aG` and `gpasswd`.”

---

If you want next, I can give you a **real-world scenario (like fixing permissions on a server)** — that’s exactly what they ask in SRE/backend interviews 🔥