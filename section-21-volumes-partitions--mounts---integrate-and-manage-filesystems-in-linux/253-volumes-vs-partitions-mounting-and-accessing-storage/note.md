## 253. Volumes vs Partitions: Mounting and Accessing Storage

# What is a Partition?

A partition is:

* a physical section of a disk
* isolated from other sections

Example:

```bash id="xj1t90"
/dev/sda1
/dev/sda2
/dev/sdb1
```

Each partition:

* has its own filesystem
* can be mounted separately
* behaves almost like an independent disk

---

# What is a Volume?

A volume is:

* a logical storage unit
* presented to the operating system as usable storage

A volume may be:

* a single partition
* multiple combined partitions
* network storage
* encrypted storage
* RAID storage
* LVM logical volume

---

# Important Difference

## Partition

Physical/logical division of a disk.

Example:

```bash id="eqj7jd"
/dev/sdb1
```

---

## Volume

Storage abstraction used by the operating system.

Example:

* LVM volume
* mounted network storage
* RAID volume
* encrypted volume

---

# Real-World Examples

## Simple Case

One partition = one volume

```bash id="vc3qwl"
/dev/sdb1
```

formatted with:

```bash id="0e26wk"
ext4
```

mounted at:

```bash id="gy3y7m"
/mnt/data
```

---

# Advanced Case: LVM

Multiple partitions:

```bash id="y8h7rq"
/dev/sdb1
/dev/sdc1
```

combined into:

```bash id="e99d58"
/dev/vg_data/lv_storage
```

The OS sees:

* one large logical volume

This is common in:

* servers
* enterprise Linux systems
* cloud environments

---

# Network Volumes

A volume can even exist on another machine.

Examples:

* NFS
* SMB/CIFS
* FTP
* cloud storage

Mounted locally as if it were:

* a normal folder

---

# What is Mounting?

Mounting means:

* attaching a filesystem to the Linux directory tree

Linux uses:

* one unified filesystem hierarchy

Unlike Windows:

* no separate `C:` or `D:` drive system internally

Everything becomes part of:

```bash id="p0u4u5"
/
```

(the root filesystem)

---

# Mounting Concept

When mounted:

* files inside the filesystem become accessible
* programs can read/write normally

Example:

```bash id="ynqczr"
sudo mount /dev/sdb1 /mnt/data
```

Now:

```bash id="6bf1eq"
/mnt/data
```

contains files from:

```bash id="93ddw0"
/dev/sdb1
```

---

# Important Visualization

Before mount:

```bash id="w5rt8w"
/mnt/data
```

is just an empty folder.

After mount:

```bash id="q5w27q"
/dev/sdb1 ---> /mnt/data
```

Now accessing:

```bash id="g9wkkv"
/mnt/data
```

actually accesses the mounted filesystem.

---

# Common Mount Locations

## External removable media

Usually:

```bash id="3k8mya"
/media
```

Examples:

```bash id="gqkchf"
/media/mohammad/USB
/media/mohammad/BackupDrive
```

Desktop environments often auto-mount these.

---

# Temporary/internal mounts

Usually:

```bash id="ohhj48"
/mnt
```

Examples:

```bash id="ctzv5m"
/mnt/data
/mnt/storage
```

Common for:

* servers
* manual mounting
* temporary mounting

---

# Bind Mounts

Linux can mount folders into other folders.

Example:

```bash id="dxzmg3"
sudo mount --bind /var/log /mnt/logs
```

Now:

```bash id="d4q4ps"
/mnt/logs
```

shows:

```bash id="9cf3mt"
/var/log
```

Useful for:

* containers
* chroot
* Docker
* system administration

---

# Network Mount Examples

## NFS

```bash id="r2pwk4"
sudo mount server:/shared /mnt/shared
```

---

## CIFS / SMB (Windows shares)

```bash id="k0mymx"
sudo mount -t cifs //server/share /mnt/share
```

---

# Viewing Mounted Filesystems

## mount

```bash id="2fclkn"
mount
```

Shows all mounted filesystems.

---

## df -h

```bash id="9aw5dc"
df -h
```

Shows:

* mounted volumes
* disk usage
* free space

---

## lsblk

```bash id="3ct6jl"
lsblk
```

Shows:

* disks
* partitions
* mount points

Example:

```bash id="4l81zd"
sdb
└─sdb1   /mnt/data
```

---

# Mounting Workflow Example

## 1. Create partition

```bash id="0r9o2o"
sudo parted /dev/sdb
```

---

## 2. Create filesystem

```bash id="c4p5b2"
sudo mkfs.ext4 /dev/sdb1
```

---

## 3. Create mount directory

```bash id="bcnifj"
sudo mkdir /mnt/data
```

---

## 4. Mount filesystem

```bash id="y8k09m"
sudo mount /dev/sdb1 /mnt/data
```

---

## 5. Verify

```bash id="49vs6j"
df -h
```

or:

```bash id="luwl3r"
lsblk
```

---

# Unmounting

Before removing storage:

```bash id="y0zhhe"
sudo umount /mnt/data
```

or:

```bash id="ew9wsx"
sudo umount /dev/sdb1
```

---

# Important Notes

## Mounted filesystem hides folder contents

If:

```bash id="8s5owj"
/mnt/data
```

already had files before mounting,
they become temporarily hidden while mounted.

---

# Linux Philosophy

Linux treats:

* disks
* USB drives
* network shares
* virtual filesystems

all as part of:

```bash id="vjlwm4"
/
```

This unified design is one of Linux’s strongest architectural ideas.

---

# Relation to Docker

Mount concepts are VERY important later for:

* Docker volumes
* bind mounts
* persistent container storage

Example:

```bash id="q66lrk"
docker run -v /host/data:/container/data
```

This is directly related to Linux mounting concepts.

Understanding Linux mounts now will make Docker much easier later.
