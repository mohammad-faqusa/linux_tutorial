## 254. Manual Drive Mounting: Enhancing Flexibility

# Why Manual Mounting Matters

On desktop Linux:

* USB drives are often mounted automatically

But on:

* servers
* cloud VMs
* rescue environments
* minimal Linux systems

you usually need to mount drives manually.

This is extremely important for:

* Linux administration
* backups
* troubleshooting
* Docker storage
* server management

---

# Step 1 — Identify the Drive

## Using `lsblk -f`

```bash id="l0tdur"
lsblk -f
```

Explanation:

* `lsblk`

  * list block devices

* `-f`

  * show filesystem information

---

# Example Output

```bash id="2x0dfk"
NAME   FSTYPE LABEL UUID                                 MOUNTPOINT
sda
├─sda1 ext4         1234-5678                            /
└─sda2 swap         abcd-efgh                            [SWAP]

sdb
└─sdb1 ext4 backups 1111-2222                            /mnt/backups
```

---

# Important Columns

## NAME

Device name:

```bash id="gjv0xv"
/dev/sdb1
```

---

## FSTYPE

Filesystem type:

* ext4
* xfs
* vfat
* ntfs

---

## LABEL

Human-readable label.

Example:

```bash id="p03bji"
backups
```

---

## UUID

Unique filesystem identifier.

Useful for:

* permanent mounting in `/etc/fstab`

---

## MOUNTPOINT

Current mount location.

Example:

```bash id="tw91zv"
/mnt/backups
```

---

# Step 2 — Create Mount Directory

Before mounting:

* create a folder where the filesystem will appear

Example:

```bash id="2tr8d2"
sudo mkdir -p /mnt/backups
```

Explanation:

* `/mnt`

  * standard location for manual mounts

* `-p`

  * create parent directories if needed

---

# Step 3 — Mount the Drive

## Basic Mount

```bash id="70v4uw"
sudo mount /dev/sdb1 /mnt/backups
```

Explanation:

* `/dev/sdb1`

  * source filesystem

* `/mnt/backups`

  * destination mountpoint

---

# What Happens Internally

Linux attaches:

```bash id="wdv6x7"
/dev/sdb1
```

to:

```bash id="ll3h0h"
/mnt/backups
```

Now files become accessible through:

```bash id="f9jylz"
/mnt/backups
```

---

# Step 4 — Verify Mount

## Using `mount`

```bash id="d9ql1f"
mount
```

Shows all mounted filesystems.

---

## Using `df -h`

```bash id="wt18jv"
df -h
```

Explanation:

* `-h`

  * human-readable sizes

Example:

```bash id="sdl9ea"
Filesystem      Size  Used Avail Mounted on
/dev/sdb1       100G   10G   85G /mnt/backups
```

---

# Specifying Filesystem Type

Normally Linux auto-detects the filesystem.

But you can manually specify it:

```bash id="qbrfmr"
sudo mount -t ext4 /dev/sdb1 /mnt/backups
```

Explanation:

* `-t`

  * filesystem type

Useful when:

* auto-detection fails
* troubleshooting
* mounting special filesystems

---

# Mounting Read-Only

## Read-only mount

```bash id="rk5nkn"
sudo mount -o ro /dev/sdb1 /mnt/backups
```

Explanation:

* `-o`

  * mount options

* `ro`

  * read-only

Useful for:

* recovery
* forensics
* protecting damaged filesystems
* preventing accidental writes

---

# Common Mount Options

## Read-write (default)

```bash id="3wkl9d"
-o rw
```

---

## Read-only

```bash id="yyr4x0"
-o ro
```

---

## No execution

```bash id="m6g6gx"
-o noexec
```

Prevents executable files from running.

---

## No automatic mounting

```bash id="b6nsf7"
-o noauto
```

---

# Unmounting Drives

## Basic Unmount

```bash id="3nkx6q"
sudo umount /mnt/backups
```

or:

```bash id="7i61z0"
sudo umount /dev/sdb1
```

---

# Why Unmounting Is Important

Unmounting:

* flushes cached writes
* prevents corruption
* safely disconnects storage

Never physically disconnect storage before unmounting.

---

# Common Error: “target is busy”

Example:

```bash id="1gmsd9"
umount: target is busy
```

Reason:

* files still open
* terminal currently inside mount directory
* running process using the filesystem

---

# Fixing Busy Mounts

## Leave the directory

```bash id="i8bq7r"
cd ~
```

---

## Find processes using the mount

```bash id="0v87yz"
sudo lsof /mnt/backups
```

or:

```bash id="3v7nqj"
sudo fuser -m /mnt/backups
```

---

# Temporary vs Permanent Mounts

## Manual mount

Exists only until:

* reboot
* unmount

---

## Permanent mount

Configured in:

```bash id="lp2ylf"
/etc/fstab
```

This will be covered later.

---

# Real-World Server Usage

Manual mounting is commonly used for:

* backup drives
* additional storage volumes
* cloud block storage
* recovery environments
* mounting damaged systems
* rescue mode troubleshooting

---

# Important Docker Relation

These Linux concepts directly relate to:

* Docker volumes
* bind mounts
* persistent storage

Example:

```bash id="jlwm8t"
docker run -v /host/data:/data
```

This works because Docker relies heavily on Linux mount mechanics.

---

# Practical Example Workflow

## Detect drive

```bash id="rjlwmv"
lsblk -f
```

---

## Create mountpoint

```bash id="2mdlo0"
sudo mkdir -p /mnt/backups
```

---

## Mount filesystem

```bash id="3h3u30"
sudo mount /dev/sdb1 /mnt/backups
```

---

## Verify

```bash id="18yn9t"
df -h
```

---

## Access files

```bash id="l16z1d"
cd /mnt/backups
ls
```

---

## Unmount

```bash id="gw71y8"
sudo umount /mnt/backups
```
