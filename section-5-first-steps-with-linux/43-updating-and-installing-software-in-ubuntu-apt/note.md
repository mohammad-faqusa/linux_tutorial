Perfect—let’s do the **APT version of your crash course** in the same practical style 🔥  
This is for APT package manager (Ubuntu/Debian).

---

# 🚀 APT Crash Course (Hands-on)

## 🎯 Goal

You’ll be able to:

- Install / remove packages
    
- Manage updates correctly
    
- Debug dependency issues
    
- Think like an SRE on Ubuntu systems
    

---

# 🧪 Step 1 — Explore system

```bash
apt list --installed | head
apt list --upgradable
```

👉 See:

- Installed packages
    
- What can be upgraded
    

---

# 🔍 Step 2 — Search & inspect

```bash
apt search nginx
apt show nginx
```

👉 Same idea as `dnf search` / `dnf info`

---

# 📦 Step 3 — Install

```bash
sudo apt install nginx
```

---

# 🧠 Step 4 — Dependencies

```bash
apt depends nginx
```

👉 Interview-important

---

# 📋 Step 5 — List packages

```bash
apt list nginx
apt list --installed nginx
```

---

# 🔄 Step 6 — Update system (IMPORTANT DIFFERENCE)

```bash
sudo apt update
```

👉 Refresh package list (metadata)

Then:

```bash
sudo apt upgrade
```

👉 Upgrade installed packages

---

# ⚡ Full upgrade (important)

```bash
sudo apt full-upgrade
```

👉 Can:

- Install/remove packages to complete upgrade
    
- Used for major upgrades
    

---

# ❌ Step 7 — Remove package

```bash
sudo apt remove nginx
```

---

# 🧹 Step 8 — Remove with config files

```bash
sudo apt purge nginx
```

👉 Removes:

- Package
    
- Config files
    

---

# 🧹 Step 9 — Clean unused dependencies

```bash
sudo apt autoremove
```

👉 Same concept as DNF

---

# 🧼 Step 10 — Clean cache

```bash
sudo apt clean
```

👉 Removes downloaded `.deb` files

---

# 🔎 Step 11 — Check updates

```bash
apt list --upgradable
```

👉 Equivalent to:

- `dnf check-update`
    

---

# 🔁 Step 12 — Reinstall

```bash
sudo apt install --reinstall nginx
```

---

# 📥 Step 13 — Download without install

```bash
apt download nginx
```

---

# 📊 Step 14 — Fix broken packages

```bash
sudo apt --fix-broken install
```

👉 VERY important in real life

---

# 📂 Step 15 — Find package by file

```bash
apt-file search /usr/bin/nginx
```

👉 (requires `apt-file`)

---

# 🕓 Step 16 — History (logs)

APT doesn’t have `dnf history`, but:

```bash
cat /var/log/apt/history.log
```

---

# 🏁 Final Challenge (same pattern)

### Scenario:

1. Install `htop`
    
2. Check its info
    
3. Check dependencies
    
4. Remove it
    
5. Purge it
    
6. Autoremove unused deps
    
7. Check upgrades
    

👉 Use:

- `install`
    
- `show`
    
- `depends`
    
- `remove`
    
- `purge`
    
- `autoremove`
    
- `list --upgradable`
    

---

# 🧠 Key Differences vs DNF

| Concept        | APT                | DNF                     |
| -------------- | ------------------ | ----------------------- |
| Refresh repos  | `apt update`       | `dnf makecache`         |
| Upgrade system | `apt upgrade`      | `dnf update`            |
| Full upgrade   | `apt full-upgrade` | (same as update mostly) |
| Remove config  | `apt purge`        | (manual)                |
| History        | logs file          | `dnf history`           |

---

# 🔥 Real-world usage (SRE mindset)

On Ubuntu server:

```bash
sudo apt update
sudo apt upgrade
```

Debug:

```bash
sudo apt --fix-broken install
```

Cleanup:

```bash
sudo apt autoremove
```

---

# 🚀 Next step (for your level)

Now you’ve learned:

- DNF ✅
    
- APT ✅
    

Next powerful move:

👉 I can simulate:  
**“Production server broken after update—fix it”**

or

👉 Teach:  
**How package managers resolve dependencies internally (deep SRE level)**

Just tell me 👍