Here’s a **clean, comprehensive guide** you can save as a `.md` file and reuse anytime 👇

---

# 🐧 CentOS Stream 9 + VirtualBox Setup Guide

### (Auto Resize Screen • Mouse Integration • Copy/Paste)

---

## 🎯 Goal

After this guide, your VM will have:

* ✅ Smooth mouse (no capture/release)
* ✅ Auto screen resize
* ✅ Copy & paste between Windows ↔ VM
* ✅ Better overall performance

---

## 🧱 Requirements

* Host: **VirtualBox**
* Guest OS: **CentOS Stream 9**
* Internet connection inside VM

---

# ⚙️ 1. Configure VirtualBox (IMPORTANT)

Before starting the VM:

### System

* RAM: **4 GB minimum (8 GB recommended)**
* CPU: **2 cores minimum**

### Display

* Graphics Controller: **VMSVGA**
* Video Memory: **128 MB**
* ❌ Disable **3D Acceleration**

### Pointing Device

* System → Motherboard → **USB Tablet**

---

# 🚀 2. Install Guest Additions

## Step 1: Install required packages

Open terminal inside CentOS:

```bash
sudo dnf update -y
sudo dnf install -y gcc kernel-devel kernel-headers make perl elfutils-libelf-devel bzip2
```

---

## Step 2: Reboot (IMPORTANT)

```bash
sudo reboot
```

---

## Step 3: Insert Guest Additions CD

From VirtualBox menu:

👉 **Devices → Insert Guest Additions CD Image**

---

## Step 4: Mount and install

```bash
sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
sudo sh VBoxLinuxAdditions.run
```

👉 Watch for errors (especially kernel headers)

---

## Step 5: Reboot again

```bash
sudo reboot
```

---

# 🖱️ 3. Enable Mouse Integration

After reboot:

* Mouse should move smoothly between host and VM
* No need to press **Right Ctrl**

If needed:

* VirtualBox menu → **Input → Mouse Integration (enabled)**

---

# 🖥️ 4. Enable Auto Screen Resize

In VirtualBox menu:

👉 **View → Auto-resize Guest Display**

Now:

* Resize window → VM screen adjusts automatically ✅

---

# 📋 5. Enable Copy & Paste (Clipboard)

## Step 1: Enable from VirtualBox

* **Devices → Shared Clipboard → Bidirectional**

(Optional)

* **Devices → Drag and Drop → Bidirectional**

---

## Step 2: Test clipboard

Inside VM:

* Paste in terminal:
  👉 `Ctrl + Shift + V`

---

# ⚠️ 6. Fix Clipboard Issues (Wayland problem)

CentOS uses **Wayland**, which may break clipboard.

## Disable Wayland

```bash
sudo nano /etc/gdm/custom.conf
```

Edit:

```ini
[daemon]
WaylandEnable=false
```

Save and reboot:

```bash
sudo reboot
```

---

## Verify

```bash
echo $XDG_SESSION_TYPE
```

👉 Expected:

```
x11
```

---

# 🔧 7. Manual Fix (if clipboard still not working)

Run:

```bash
VBoxClient --clipboard
VBoxClient --draganddrop
```

---

## Optional: Auto-start clipboard

```bash
mkdir -p ~/.config/autostart
nano ~/.config/autostart/vboxclient.desktop
```

Paste:

```ini
[Desktop Entry]
Type=Application
Exec=VBoxClient --clipboard
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=VBox Clipboard
```

---

# 🔍 8. Verify Installation

Run:

```bash
lsmod | grep vbox
```

👉 Expected:

* `vboxguest`
* `vboxsf`
* `vboxvideo`

---

# 🚨 Troubleshooting

## ❌ Mouse stuck

* Press **Right Ctrl** (Host key)
* Ensure **USB Tablet** is enabled

---

## ❌ Screen not resizing

* Check: View → Auto-resize Guest Display
* Reinstall Guest Additions if needed

---

## ❌ Clipboard not working

* Ensure Wayland is disabled
* Run:

```bash
VBoxClient --clipboard
```

---

## ❌ Installation failed

* Kernel headers mismatch → run:

```bash
uname -r
sudo dnf install kernel-devel-$(uname -r)
```

---

# 🚀 Pro Tips (for backend/SRE)

* Use terminal more than GUI
* Prefer:

    * SSH
    * Git
    * Shared folders

---

# 📦 Optional: Enable Shared Folder (better than copy/paste)

In VirtualBox:

* Settings → Shared Folders → Add folder

Inside VM:

```bash
sudo usermod -aG vboxsf $USER
reboot
```

---

# ✅ Final Result

You now have:

* Smooth mouse ✅
* Auto-resize screen ✅
* Working clipboard ✅
* Stable Linux VM ✅

---

# 🔥 Recommendation

For best experience:

* Use **CentOS Stream 9 / Rocky Linux**
* Avoid newer Wayland-heavy systems in VM

---

If you want next step 👉
I can help you set up:

* Docker environment
* Backend dev setup
* SRE tools inside this VM 💪
