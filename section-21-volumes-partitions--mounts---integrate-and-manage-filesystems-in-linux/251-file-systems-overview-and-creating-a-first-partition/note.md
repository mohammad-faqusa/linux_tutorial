# 251. File Systems Overview and Creating a First Partition

## what is a filesystem?

a filesystem is the software/data structure responsible for organizing and managing data on storage devices.

without a filesystem:

* the OS cannot properly store files
* the disk is just raw blocks of data

---

# relationship between disk, partition, and filesystem

typical structure:

```text id="fs001"
Physical Disk
   ↓
Partition Table
   ↓
Partitions
   ↓
Filesystem
   ↓
Files and Directories
```

---

# responsibilities of a filesystem

## data organization

organizes:

* files
* directories
* hierarchy

example:

```text id="fs002"
/home/mohammad/file.txt
```

---

## space allocation

tracks:

* free blocks
* used blocks

responsible for:

* allocating new space
* releasing space after deletion

---

## metadata management

stores metadata such as:

* permissions
* ownership
* timestamps
* file size
* inode information

examples:

```text id="fs003"
created at
modified at
last accessed
```

---

## data integrity

protects filesystem consistency.

includes:

* crash recovery
* journaling
* corruption detection

important after:

* power failure
* kernel crash
* forced shutdown

---

# journaling

many modern filesystems use:

```text id="fs004"
journaling
```

before changing filesystem data:

* operations are first recorded in journal/log

advantages:

* faster recovery
* less corruption risk

---

# common Linux filesystems

# ext3

## third extended filesystem

older Linux filesystem.

features:

* journaling
* stable
* reliable

still found in:

* older servers
* legacy systems

---

# ext4

## fourth extended filesystem

most common Linux filesystem.

default in:

* Ubuntu
* Debian
* many Linux distros

---

## ext4 features

### improved performance

faster than ext3.

---

### larger filesystem support

supports:

* larger partitions
* larger files

---

### journaling improvements

better recovery after:

* crashes
* sudden shutdowns

---

### extents

improves:

* fragmentation handling
* performance

---

## common ext4 usage

general-purpose Linux filesystem.

good for:

* desktops
* laptops
* servers
* VMs

---

# XFS

commonly used in:

* CentOS
* RHEL
* enterprise servers

default filesystem in many RedHat-based systems.

---

## XFS strengths

### large filesystems

excellent with:

* huge disks
* large files

---

### parallel I/O optimization

very efficient for:

* servers
* databases
* parallel workloads

---

### snapshots/reflinks

supports advanced storage features.

---

## common XFS usage

good for:

* enterprise servers
* large storage arrays
* heavy I/O workloads

---

# Btrfs

modern advanced Linux filesystem.

pronounced:

```text id="fs005"
Butter FS
```

---

## Btrfs features

### snapshots

easy filesystem snapshots.

very useful for:

* backups
* rollback
* recovery

---

### RAID support

built-in advanced RAID capabilities.

---

### checksums

better corruption detection.

---

## common Btrfs usage

popular in:

* advanced Linux systems
* snapshot-focused distros
* NAS systems

example:

* openSUSE

---

# common Windows/macOS filesystems

# FAT32

older filesystem.

advantages:

* extremely compatible

limitations:

* max file size:

```text id="fs006"
4GB
```

commonly used for:

* USB drives
* compatibility

---

# NTFS

main Windows filesystem.

features:

* permissions
* journaling
* compression
* encryption

Linux:

* usually supports reading
* writing support now generally works well too through `ntfs-3g`

---

# ReFS

newer Microsoft filesystem.

goal:

* successor to NTFS

focus:

* integrity
* scalability

mostly enterprise-oriented

---

# exFAT

designed for:

* flash drives
* SD cards
* external storage

advantages:

* supports large files
* cross-platform compatibility

Linux support improved after Microsoft published specifications.

---

# APFS

Apple filesystem.

used in:

* macOS
* iOS

features:

* snapshots
* encryption
* SSD optimization

---

# creating a first partition (practice)

## open GParted

```bash id="fs007"
sudo gparted
```

---

# select the new virtual disk

top-right dropdown:

* choose the new disk

example:

```text id="fs008"
/dev/sdb
```

NOT:

```text id="fs009"
/dev/sda
```

if `/dev/sda` is your system disk.

---

# create partition table

menu:

```text id="fs010"
Device → Create Partition Table
```

---

# choose partition table type

recommended:

```text id="fs011"
gpt
```

modern standard:

* supports large disks
* supports many partitions
* UEFI compatible

---

# create partition

right click:

```text id="fs012"
Unallocated Space
```

then:

```text id="fs013"
New
```

---

# choose filesystem type

common options:

* ext4
* xfs
* btrfs

recommended for practice:

```text id="fs014"
ext4
```

---

# choose partition size

example:

```text id="fs015"
10 GiB
```

---

# apply operations

click:

```text id="fs016"
Apply
```

important:

* GParted queues changes first
* nothing happens until applied

---

# result

example:

```text id="fs017"
/dev/sdb1
Filesystem: ext4
```

---

# verify from terminal

show partitions:

```bash id="fs018"
lsblk
```

example:

```text id="fs019"
sdb
└─sdb1 ext4
```

---

# show filesystem UUIDs

```bash id="fs020"
blkid
```

---

# mount the partition manually

create mount point:

```bash id="fs021"
sudo mkdir /mnt/data
```

mount:

```bash id="fs022"
sudo mount /dev/sdb1 /mnt/data
```

---

# verify mount

```bash id="fs023"
df -h
```

or:

```bash id="fs024"
mount | grep sdb1
```

---

# unmount

```bash id="fs025"
sudo umount /mnt/data
```

---

# important practical idea

partitioning and filesystems are separate steps:

## step 1

create partition:

```text id="fs026"
/dev/sdb1
```

---

## step 2

create filesystem:

```text id="fs027"
ext4
```

---

## step 3

mount filesystem:

```text id="fs028"
/mnt/data
```

---

# useful commands summary

open GParted:

```bash id="fs029"
sudo gparted
```

list disks:

```bash id="fs030"
lsblk
```

show detailed partition info:

```bash id="fs031"
sudo fdisk -l
```

show filesystem UUIDs:

```bash id="fs032"
blkid
```

mount filesystem:

```bash id="fs033"
sudo mount /dev/sdb1 /mnt/data
```

show mounted filesystems:

```bash id="fs034"
df -h
```

unmount:

```bash id="fs035"
sudo umount /mnt/data
```
