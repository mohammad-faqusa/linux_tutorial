## 257. Efficient Drive Mounting with `/etc/fstab`

# What is `/etc/fstab`?

`/etc/fstab` stands for:

```bash id="jlwm11"
filesystem table
```

It is a Linux configuration file that:

* defines filesystems
* defines mount behavior
* controls automatic mounting during boot

Linux reads this file:

* during startup
* when mounting with `mount -a`

---

# Why `/etc/fstab` Is Important

Without `/etc/fstab`:

* mounts are temporary
* disappear after reboot

With `/etc/fstab`:

* filesystems mount automatically
* mount options remain persistent

This is essential for:

* servers
* backup drives
* Docker storage
* cloud volumes
* production systems

---

# Location

```bash id="jlwm12"
/etc/fstab
```

---

# Viewing The File

```bash id="
```


```bash
sudo nano /etc/fstab
```

---

# Structure of `/etc/fstab`

Each line represents:

* one filesystem
* one mount rule

General format:

```bash
<filesystem> <mountpoint> <type> <options> <dump> <pass>
```

Fields separated by:

* spaces
* tabs

---

# Example Entry

```bash
UUID=1234-5678 /mnt/backups ext4 defaults,nosuid,noexec 0 2
```

---

# Field-by-Field Explanation

---

# 1. Filesystem Identifier

Specifies:

* which filesystem/device to mount

Examples:

## UUID (recommended)

```bash
UUID=1234-5678
```

More stable because:

* device names may change
* UUID remains constant

---

## Device Path

```bash
/dev/sdb1
```

Less reliable.

Why?
Because:

* Linux may reorder disks during boot

---

# Getting UUIDs

```bash
lsblk -f
```

or:

```bash
sudo blkid
```

---

# 2. Mount Point

Where filesystem appears in directory tree.

Example:

```bash
/mnt/backups
```

Must already exist:

```bash
sudo mkdir -p /mnt/backups
```

---

# 3. Filesystem Type

Examples:

```bash
ext4
xfs
exfat
vfat
ntfs
swap
```

Example:

```bash
ext4
```

---

# 4. Mount Options

Controls filesystem behavior.

Example:

```bash
defaults,nosuid,noexec
```

Options separated with commas.

---

# Important Default Options

`defaults` includes:

```bash
rw,suid,dev,exec,auto,nouser,async
```

---

# Meaning of Common Defaults

## `rw`

Read-write access.

---

## `suid`

Allow SUID/SGID behavior.

---

## `exec`

Allow executable files.

---

## `auto`

Mount automatically during boot.

---

## `nouser`

Only root can mount.

---

## `async`

Asynchronous reads/writes.

Improves:

* performance

Potential downside:

* slightly higher data-loss risk during sudden power loss

---

# Additional Security Options

## `nosuid`

Ignore SUID/SGID bits.

Improves security.

---

## `noexec`

Prevent direct execution of binaries/scripts.

Useful for:

* USB drives
* backup storage
* untrusted media

---

# Example Combined Options

```bash
defaults,nosuid,noexec
```

---

# 5. Dump Field

Legacy backup utility option.

Usually:

```bash
0
```

Meaning:

* do not use dump backups

Rarely used today.

---

# 6. Filesystem Check Order (`fsck`)

Controls boot-time filesystem checking order.

---

# Root Filesystem

Usually:

```bash
1
```

Highest priority.

---

# Non-root Filesystems

Usually:

```bash
2
```

Checked after root.

---

# Disable Filesystem Checks

```bash
0
```

No automatic fsck.

---

# Example Breakdown

```bash
UUID=1234 /mnt/backups ext4 defaults,nosuid,noexec 0 2
```

| Field                  | Meaning         |
| ---------------------- | --------------- |
| UUID=1234              | filesystem      |
| /mnt/backups           | mountpoint      |
| ext4                   | filesystem type |
| defaults,nosuid,noexec | mount options   |
| 0                      | no dump         |
| 2                      | fsck order      |

---

# Practice Workflow

---

# 1. Unmount Current Mount

```bash
sudo umount /mnt/backups
```

---

# 2. Edit `/etc/fstab`

```bash
sudo nano /etc/fstab
```

Add line:

```bash
UUID=... /mnt/backups ext4 defaults,nosuid,noexec 0 2
```

---

# 3. Save and Exit

Nano:

* `CTRL + O`
* Enter
* `CTRL + X`

---

# 4. Apply Mounts

```bash
sudo mount -a
```

Explanation:

* mounts everything defined in `/etc/fstab`
* does NOT require reboot

---

# VERY IMPORTANT ADMIN HABIT

Always run:

```bash
sudo mount -a
```

after editing `/etc/fstab`.

Why?
Because broken `fstab` entries can:

* break boot process
* enter emergency mode
* prevent successful startup

---

# Verifying Mount

## Using `mount`

```bash
mount | grep backups
```

---

## Using `df -h`

```bash
df -h
```

---

# Common Errors

---

# Wrong Filesystem Type

Example:

```bash
wrong fs type
```

Possible causes:

* wrong filesystem type in `fstab`
* corrupted filesystem
* missing drivers/packages

---

# Missing Mount Directory

Example:

```bash
mount point does not exist
```

Fix:

```bash
sudo mkdir -p /mnt/backups
```

---

# Wrong UUID

Verify:

```bash
lsblk -f
```

or:

```bash
sudo blkid
```

---

# systemd Cache Hint

Sometimes after editing:

```bash
/etc/fstab
```

systemd may warn:

```bash
systemctl daemon-reload
```

Run:

```bash
sudo systemctl daemon-reload
```

---

# Important Production Insight

On real Linux servers:

* almost all persistent storage is managed through `/etc/fstab`

Including:

* backup drives
* cloud block volumes
* Docker storage
* network shares
* NFS mounts
* RAID/LVM volumes

This is core Linux administration knowledge.
