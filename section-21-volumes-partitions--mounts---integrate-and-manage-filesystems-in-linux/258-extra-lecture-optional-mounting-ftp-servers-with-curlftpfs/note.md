## 258. Extra Lecture (Optional): Mounting FTP Servers with `curlftpfs`

# Important Context

This lecture mainly demonstrates:

* FUSE concepts
* mounting remote resources as filesystems

The FTP protocol itself is older and less commonly used today compared to:

* SFTP
* SCP
* cloud storage
* SSH-based transfers

Still, the Linux concepts here are VERY valuable.

---

# What is FTP?

FTP:

```bash id="njlwm1"
File Transfer Protocol
```

Used to:

* upload files
* download files
* manage remote files

between:

* client
* server

---

# FTP Characteristics

Default FTP:

* unencrypted
* insecure
* credentials transmitted in plaintext

This is dangerous on public networks.

---

# Safer Alternatives

---

# FTPS

```bash id="njlwm2"
FTP over SSL/TLS
```

Adds:

* encryption
* secure authentication

Still based on FTP protocol.

---

# SFTP

```bash id="njlwm3"
SSH File Transfer Protocol
```

Completely different protocol.

Uses:

* SSH
* encrypted communication

Very common today.

---

# What is FUSE?

FUSE:

```bash id="njlwm4"
Filesystem in Userspace
```

Allows normal userspace programs to:

* create virtual filesystems
* mount remote resources
* expose custom storage systems as directories

Without needing:

* kernel filesystem drivers

---

# Why FUSE Is Powerful

FUSE allows mounting:

* FTP servers
* cloud storage
* ZIP archives
* SSH servers
* encrypted containers
* object storage

as normal Linux directories.

---

# Installing Required Packages

## Ubuntu

```bash id="njlwm5"
sudo apt install fuse curlftpfs
```

---

# Package Roles

## `fuse`

Provides:

* userspace filesystem support

---

## `curlftpfs`

Allows:

* FTP servers to be mounted as filesystems

Uses:

* libcurl internally

---

# Creating Mount Directory

```bash id="njlwm6"
sudo mkdir -p /mnt/ftp
```

---

# Mounting FTP Server

## Basic Syntax

```bash id="njlwm7"
sudo curlftpfs 'ftp://user:password@server/path' /mnt/ftp
```

---

# Example

```bash id="njlwm8"
sudo curlftpfs 'ftp://john:mypass@example.com/public' /mnt/ftp
```

Now:

```bash id="njlwm9"
/mnt/ftp
```

behaves like:

* local filesystem

---

# Accessing Files

```bash id="njlwma"
cd /mnt/ftp
ls
```

You can:

* browse files
* upload
* download
* edit

depending on permissions.

---

# Debug Mode

## Verbose + Debug

```bash id="njlwmb"
sudo curlftpfs -d -v 'ftp://user:password@server/path' /mnt/ftp
```

---

# Meaning of Options

## `-d`

Debug mode.

Shows:

* internal operations
* errors
* protocol details

---

## `-v`

Verbose output.

Displays:

* connection details
* FTP communication

---

# FTPS Support

Some hosting providers require:

* encrypted FTP

Use:

```bash id="njlwmc"
-o ssl
```

Example:

```bash id="njlwmd"
sudo curlftpfs -d -v -o ssl 'ftp://user:password@server/path' /mnt/ftp
```

This enables:

* SSL/TLS encryption

---

# Unmounting FUSE Filesystems

FUSE mounts are unmounted differently.

Instead of:

```bash id="njlwme"
umount
```

commonly use:

```bash id="njlwmf"
sudo fusermount -u /mnt/ftp
```

Explanation:

* `-u`

  * unmount

---

# Why FUSE Uses `fusermount`

Because:

* FUSE filesystems run in userspace
* special handling required

---

# Real-World Importance

Even if you never use FTP professionally,
this lecture teaches an IMPORTANT Linux idea:

Linux can mount:

* remote resources
* virtual systems
* network services

directly into:

```bash id="njlwmg"
/
```

the filesystem hierarchy.

This is a core Linux philosophy.

---

# Security Warning

This syntax is dangerous:

```bash id="njlwmh"
ftp://user:password@server
```

because:

* password visible in shell history
* password visible in process list

Safer approaches:

* config files
* environment variables
* SSH/SFTP authentication

---

# Modern Alternatives

Today many admins prefer:

* SFTP
* SSHFS
* rsync
* SCP

instead of FTP.

---

# SSHFS (Very Important Modern Alternative)

Very similar concept:

```bash id="nجلسമി"
sshfs user@server:/remote/path /mnt/remote
```

Mounts:

* remote SSH server
  as:
* local filesystem

This is VERY common.

---

# Why This Matters For Your Future

This lecture is secretly teaching:

* virtual filesystems
* userspace filesystems
* remote mounting
* abstraction layers
* Linux filesystem architecture

These concepts become relevant later for:

* Docker
* Kubernetes
* cloud storage
* distributed systems
* object storage
* network filesystems
* Linux internals

Especially since you want to go deeply into Linux later, understanding FUSE is valuable.


That is actually an excellent hands-on exercise for your path.

You will practice:

* networking
* Linux services
* FTP/FTPS
* FUSE
* remote mounting
* VM communication
* filesystem abstraction

This is very real Linux administration practice.

---

# Recommended Setup

## Host Machine

Acts as:

* FTP server

## Ubuntu VM

Acts as:

* FTP client
* mounts remote filesystem

This is ideal.

---

# IMPORTANT FIRST STEP

Your VM networking must allow communication between:

* host
* VM

Best options:

* Bridged Adapter
  or
* NAT + port forwarding

For easiest local communication:
I recommend:

* Bridged Adapter

because both machines get IPs on same network.

---

# Step 1 — Install FTP Server On Host

I recommend:

```bash id="kjlwm1"
vsftpd
```

Install:

```bash id="kjlwm2"
sudo apt update
sudo apt install vsftpd
```

---

# Step 2 — Start Service

```bash id="kjlwm3"
sudo systemctl enable --now vsftpd
```

Verify:

```bash id="kjlwm4"
systemctl status vsftpd
```

---

# Step 3 — Check Host IP

On host:

```bash id="kjlwm5"
ip a
```

Look for something like:

```bash id="kjlwm6"
192.168.x.x
```

Example:

```bash id="kjlwm7"
192.168.1.50
```

---

# Step 4 — Test Connectivity From VM

Inside VM:

```bash id="kjlwm8"
ping 192.168.1.50
```

If ping works:

* networking is correct

---

# Step 5 — Install FTP Client Tools On VM

Inside VM:

```bash id="kjlwm9"
sudo apt update
sudo apt install fuse curlftpfs
```

---

# Step 6 — Create Mountpoint

Inside VM:

```bash id="kjlwma"
sudo mkdir -p /mnt/ftp
```

---

# Step 7 — Mount FTP Server

Inside VM:

```bash id="kjlwmb"
sudo curlftpfs ftp://YOUR_USERNAME:YOUR_PASSWORD@192.168.1.50 /mnt/ftp
```

Example:

```bash id="kjlwmc"
sudo curlftpfs ftp://mohammad:mypass@192.168.1.50 /mnt/ftp
```

---

# Step 8 — Access Files

```bash id="kjlwmd"
cd /mnt/ftp
ls
```

Now your VM accesses files from host.

This is the powerful Linux concept:

* remote filesystem appearing local

---

# Step 9 — Unmount

```bash id="kjlwme"
sudo fusermount -u /mnt/ftp
```

---

# VERY IMPORTANT VSFTPD CONFIGURATION

Sometimes Ubuntu blocks local user login by default.

Edit:

```bash id="krgctxmf"
sudo nano /etc/vsftpd.conf
```

Ensure these lines exist:

```bash id="kjlwmf"
local_enable=YES
write_enable=YES
```

Optional:

```bash id="kjlwmg"
chroot_local_user=YES
```

Then restart:

```bash id="kjlwmh"
sudo systemctl restart vsftpd
```

---

# Troubleshooting

---

# Check FTP Port

On host:

```bash id="k’wini9"
sudo ss -tuln | grep 21
```

Should show:

```bash id="k’winia"
:21
```

---

# Firewall

If needed:

```bash id="k’winib"
sudo ufw allow 21/tcp
```

---

# Debug FTP Mount

Inside VM:

```bash id="k’winic"
sudo curlftpfs -d -v ftp://user:pass@HOST_IP /mnt/ftp
```

Very useful for debugging.

---

# Why This Exercise Is REALLY Good For You

Because you are practicing simultaneously:

* Linux networking
* services
* authentication
* mounting
* FUSE
* remote filesystems
* VM networking
* debugging

This is EXACTLY the kind of systems-level understanding that later makes:

* Docker
* Kubernetes
* Linux administration
* distributed systems

much easier.
