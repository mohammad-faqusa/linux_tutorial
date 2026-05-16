## 232. The Service Management Tool: systemd

### Step 3 : systemd

* after the bootloader gives control to the kernel, the kernel initializes the system and starts the main process (PID = 1)

  * verify it:

```bash
ps -p 1
```

```bash
ls -l /proc/1/exe
```

* PID 1 is responsible for starting and managing the rest of the system processes

---

## the tool : systemd

* systemd is not just a single tool

  * it is a complete system and service manager
* the main systemd process:

```bash
/sbin/init
```

* in modern systems, `/sbin/init` is usually a symbolic link to systemd

* show all systemd-related processes:

```bash
ps -ef | grep systemd
```

---

# Main Goals of systemd

systemd helps us:

* start services automatically
* stop/restart services
* manage background daemons
* monitor processes
* schedule tasks
* handle system startup

---

# Example Problems systemd Solves

## 1. Launch a web server in the background

Example:

* nginx
* apache
* spring boot app

### start service

```bash
sudo systemctl start nginx
```

### stop service

```bash
sudo systemctl stop nginx
```

### restart service

```bash
sudo systemctl restart nginx
```

### check status

```bash
sudo systemctl status nginx
```

### enable automatic startup on boot

```bash
sudo systemctl enable nginx
```

### disable startup on boot

```bash
sudo systemctl disable nginx
```

---

# 2. Execute a command on every boot

systemd can automatically start:

* scripts
* applications
* custom commands

This is done using:

* service units

Example:

* create custom service:

```bash
sudo nano /etc/systemd/system/myscript.service
```

Example content:

```ini
[Unit]
Description=My Startup Script

[Service]
ExecStart=/home/mohammad/myscript.sh

[Install]
WantedBy=multi-user.target
```

### reload systemd

```bash
sudo systemctl daemon-reload
```

### enable on boot

```bash
sudo systemctl enable myscript.service
```

### start immediately

```bash
sudo systemctl start myscript.service
```

---

# 3. Run a command every few minutes

systemd can schedule recurring tasks using:

* systemd timers

This is similar to:

```bash
cron
```

Example use cases:

* backups
* cleanup
* monitoring scripts
* health checks

---

# Important Concepts

## service

* background application/process
* examples:

  * nginx
  * sshd
  * docker

---

## daemon

* background process running continuously

---

## unit

* configuration file used by systemd

Types:

* `.service`
* `.timer`
* `.mount`
* `.target`

---

## target

* group of units
* similar to runlevels in older Linux systems

Common targets:

* `multi-user.target`
* `graphical.target`

---

# Useful systemctl Commands

### list running services

```bash
systemctl
```

### list all services

```bash
systemctl list-units --type=service
```

### list failed services

```bash
systemctl --failed
```

### show boot logs

```bash
journalctl -b
```

### follow live logs

```bash
journalctl -f
```

### logs for specific service

```bash
journalctl -u nginx
```

### logs for current boot

```bash
journalctl -u nginx -b
```

---

# systemd Flow During Boot

```text id="7a6cbo"
BIOS/UEFI
→ Bootloader (GRUB2)
→ Linux Kernel
→ systemd (PID 1)
→ services + targets + login screen
```
