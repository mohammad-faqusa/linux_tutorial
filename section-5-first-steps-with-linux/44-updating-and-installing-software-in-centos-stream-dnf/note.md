Good question—but “**all commands**” for DNF package manager is unrealistic (DNF has dozens of subcommands + plugins).

Instead, I’ll give you a **complete practical set (95% of real usage)**—this is exactly what you need for interviews + real work.

---

# 🔥 Core DNF Commands (with examples)

## 📦 1. Install packages

```bash
sudo dnf install nginx
```

Install multiple:

```bash
sudo dnf install git vim curl
```

---

## ❌ 2. Remove packages

```bash
sudo dnf remove nginx
```

---

## 🧹 3. Autoremove (clean unused dependencies)

```bash
sudo dnf autoremove
```

---

## 🔄 4. Update system

```bash
sudo dnf update
```

Update specific package:

```bash
sudo dnf update nginx
```

---

## 🔍 5. Search for packages

```bash
dnf search nginx
```

---

## 📋 6. List packages

List installed:

```bash
dnf list installed
```

List available:

```bash
dnf list available
```

---

## 📖 7. Get package info

```bash
dnf info nginx
```

---

## 📂 8. Check dependencies

```bash
dnf deplist nginx
```

---

## 🧠 9. Find which package provides a file

```bash
dnf provides /usr/bin/nginx
```

---

## 🔁 10. Reinstall package

```bash
sudo dnf reinstall nginx
```

---

## 📥 11. Download package (without installing)

```bash
dnf download nginx
```

_(may require plugin)_

---

## 🧹 12. Clean cache

```bash
sudo dnf clean all
```

---

## 📦 13. Check updates (without installing)

```bash
dnf check-update
```

---

## 🔒 14. List security updates

```bash
dnf updateinfo list security
```

---

## 🕓 15. View history

```bash
dnf history
```

Undo a transaction:

```bash
sudo dnf history undo 5
```

---

## 📦 16. Group install (very important)

```bash
dnf group list
```

Install group:

```bash
sudo dnf group install "Development Tools"
```

---

## ❌ 17. Remove group

```bash
sudo dnf group remove "Development Tools"
```

---

## 📌 18. Mark package (manual/auto)

Mark as manual:

```bash
dnf mark install nginx
```

Mark as dependency:

```bash
dnf mark remove nginx
```

---

## 🔍 19. List enabled repositories

```bash
dnf repolist
```

---

## 📂 20. Add repository

```bash
sudo dnf config-manager --add-repo <repo_url>
```

---

## 🔐 21. Enable / Disable repo

```bash
sudo dnf config-manager --enable repo-name
sudo dnf config-manager --disable repo-name
```

---

## 📦 22. Upgrade system (same as update)

```bash
sudo dnf upgrade
```

---

## 🔁 23. Downgrade package

```bash
sudo dnf downgrade nginx
```

---

## 📊 24. Check system problems

```bash
dnf check
```

---

## 🔎 25. List dependencies no longer needed

```bash
dnf repoquery --unneeded
```

---

# 🧠 Important Concepts (you MUST know for interviews)

### ✔ Dependency management

DNF automatically installs:

- Required libraries
    
- Sub-packages
    

---

### ✔ Transaction system

Every action is logged:

```bash
dnf history
```

---

### ✔ RPM-based system

DNF works on top of:  
👉 RPM Package Manager

---

# ⚡ Real-world usage (what you’ll actually do daily)

As a backend / SRE:

- Install tools → `dnf install`
    
- Update servers → `dnf update`
    
- Debug missing binaries → `dnf provides`
    
- Cleanup → `dnf autoremove`
    
- Check logs/issues → `dnf history`
    

---

# 🚀 If you want next step (very useful for you)

I can teach you:

- Difference between **dnf vs apt vs yum**
    
- OR simulate **real interview questions about package managers**
    

Just tell me 👍


Perfect—that’s exactly the right mindset 👍  
Let’s turn this into a **hands-on mini course** so you _learn by doing_, not just reading.

---

# 🚀 DNF Crash Course (Learn Everything in 1 Session)

## 🎯 Goal

By the end, you will:

- Install / remove / debug packages
    
- Understand dependencies
    
- Work like a real Linux backend/SRE engineer
    

---

# 🧱 Step 0 — Safe Environment (VERY IMPORTANT)

Do this in:

- VM (VirtualBox) ✅
    
- Not your main system ❌
    

---

# 🧪 Step 1 — Explore your system

```bash
dnf repolist
dnf list installed | head
dnf history
```

👉 You learn:

- Where packages come from (repos)
    
- What’s installed
    
- What happened before
    

---

# 🔍 Step 2 — Search & inspect packages

```bash
dnf search nginx
dnf info nginx
dnf provides /usr/sbin/nginx
```

👉 Think like:

> “I don’t know the package name → how do I find it?”

---

# 📦 Step 3 — Install packages

```bash
sudo dnf install nginx
```

Now verify:

```bash
nginx -v
```

---

# 🧠 Step 4 — Understand dependencies

```bash
dnf deplist nginx
```

👉 This is **VERY IMPORTANT for interviews**

---

# 📋 Step 5 — List packages

```bash
dnf list installed nginx
dnf list available nginx
```

---

# 🔄 Step 6 — Update system

```bash
sudo dnf check-update
sudo dnf update
```

---

# 🔁 Step 7 — Reinstall (simulate fixing issues)

```bash
sudo dnf reinstall nginx
```

👉 Use case:

> Broken binary / corrupted install

---

# ❌ Step 8 — Remove package

```bash
sudo dnf remove nginx
```

---

# 🧹 Step 9 — Clean unused dependencies

```bash
sudo dnf autoremove
```

---

# 🧠 Step 10 — Find unused packages

```bash
dnf repoquery --unneeded
```

---

# 🧼 Step 11 — Clean cache

```bash
sudo dnf clean all
```

---

# 📦 Step 12 — Group packages (very important)

```bash
dnf group list
```

Install dev tools:

```bash
sudo dnf group install "Development Tools"
```

---

# ❌ Step 13 — Remove group

```bash
sudo dnf group remove "Development Tools"
```

---

# 🕓 Step 14 — History & rollback

```bash
dnf history
```

Undo something:

```bash
sudo dnf history undo 1
```

---

# 🔐 Step 15 — Security updates

```bash
dnf updateinfo list security
```

---

# 📊 Step 16 — Check system health

```bash
dnf check
```

---

# 🏁 Final Challenge (VERY IMPORTANT 🔥)

Try this without looking:

### 🧪 Scenario:

1. Install `htop`
    
2. Check its info
    
3. Find its dependencies
    
4. Remove it
    
5. Clean unused dependencies
    
6. Check history
    
7. Undo removal
    

👉 Commands you should use:

- `install`
    
- `info`
    
- `deplist`
    
- `remove`
    
- `autoremove`
    
- `history`
    
- `undo`
    

---

# 🧠 What you just learned (REAL SRE skills)

You can now:

- Debug missing tools
    
- Manage production servers
    
- Clean systems safely
    
- Rollback mistakes
    

---

# ⚡ Pro Tip (from your interview experience)

They LOVE questions like:

👉 “What happens when you install a package?”  
👉 “How does Linux resolve dependencies?”  
👉 “How do you rollback a broken update?”

You now have **real answers**, not theory.

---

# 🚀 Next Level (tell me when ready)

I’ll take you deeper into:

- `rpm` low-level system (VERY important)
    
- How DNF resolves dependencies internally
    
- Real production debugging scenarios
    

Or we can do:  
👉 **Mock interview (Linux + SRE)** based on what you learned**

Just say: _interview me_ 😄