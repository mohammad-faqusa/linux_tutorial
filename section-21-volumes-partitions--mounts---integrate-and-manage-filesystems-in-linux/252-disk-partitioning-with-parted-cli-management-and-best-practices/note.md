## 252. Disk Partitioning with `parted`: CLI Management and Best Practices

### What is `parted`?

* `parted` is a CLI tool for:

  * creating partitions
  * deleting partitions
  * resizing partitions
  * managing partition tables

* commonly used on:

  * servers
  * rescue environments
  * remote systems without GUI

* supports:

  * GPT
  * MBR/MSDOS partition tables

---

# Why is this important?

Even if GUI tools like:

* GParted

are easier, CLI partitioning becomes critical when:

* working on headless servers
* recovering damaged systems
* using rescue mode
* managing cloud/VPS disks
* debugging boot/filesystem issues

---

# Important Concepts

## Partition Table (Disk Label)

Before creating partitions, the disk needs a partition table.

Common types:

### GPT

* modern standard
* supports large disks
* supports many partitions
* recommended for modern systems

### MBR / MSDOS

* older standard
* limited to 4 primary partitions
* limited disk size support

---

# Starting `parted`

```bash
sudo parted
```

This enters the interactive shell.

Prompt:

```bash
(parted)
```

---

# Useful Commands Inside `parted`

## Show help

```bash
help
```

---

## Print available disks

```bash
print devices
```

Example:

```bash
/dev/sda
/dev/sdb
```

---

## Select a disk

```bash
select /dev/sdb
```

VERY IMPORTANT:

* ensure correct disk selection
* wrong disk = data loss

---

## Show current partitions

```bash
print partitions
```

or simply:

```bash
print
```

Example:

```bash
Number  Start   End     Size    File system
 1      1049kB  500GB   500GB   ext4
```

---

# Creating a New Partition Table

## WARNING

This deletes existing partitions.

```bash
mklabel gpt
```

Confirmation:

```bash
Yes/No?
```

---

# Creating Partitions

## Incorrect alignment example

```bash
mkpart primary ext4 0 10000
```

Possible warning:

```bash
The resulting partition is not properly aligned
```

Reason:

* storage devices work best with aligned sectors

---

# Properly Aligned Partition

## Using sectors

```bash
mkpart primary ext4 2048s 50000s
```

Explanation:

* `2048s`

  * starts at sector 2048
  * common alignment standard

---

# Using Percentages

Example:

```bash
mkpart primary ext4 0% 100%
```

Useful for:

* using full disk
* easier sizing

---

# Naming a Partition

```bash
name 1 backups
```

Explanation:

* `1` = partition number
* `backups` = partition label

---

# Exiting `parted`

```bash
quit
```

---

# Running Commands Directly Without Interactive Mode

Example:

```bash
sudo parted /dev/sdb print
```

Useful for:

* scripting
* automation
* quick inspection

---

# Creating the Filesystem

IMPORTANT:
Creating a partition does NOT create a filesystem.

After partitioning:

```bash
sudo mkfs.ext4 /dev/sdb1
```

Explanation:

* `mkfs`

  * make filesystem

* `ext4`

  * filesystem type

* `/dev/sdb1`

  * first partition on `/dev/sdb`

---

# Common Filesystem Types

## ext4

```bash
mkfs.ext4 /dev/sdb1
```

## xfs

```bash
mkfs.xfs /dev/sdb1
```

## FAT32

```bash
mkfs.vfat /dev/sdb1
```

---

# Checking Block Devices

Useful commands:

## lsblk

```bash
lsblk
```

Shows:

* disks
* partitions
* mountpoints

---

## blkid

```bash
sudo blkid
```

Shows:

* UUIDs
* filesystem types

---

# Typical Real-World Flow

## 1. Detect disks

```bash
lsblk
```

## 2. Start parted

```bash
sudo parted /dev/sdb
```

## 3. Create GPT

```bash
mklabel gpt
```

## 4. Create partition

```bash
mkpart primary ext4 2048s 100%
```

## 5. Quit

```bash
quit
```

## 6. Create filesystem

```bash
sudo mkfs.ext4 /dev/sdb1
```

## 7. Mount partition

```bash
sudo mount /dev/sdb1 /mnt
```

---

# Important Distinction

## Partition

Logical division of a disk.

Example:

```bash
/dev/sdb1
```

---

## Filesystem

Structure used to store files.

Example:

* ext4
* xfs
* FAT32

Without filesystem:

* partition exists
* but files cannot be stored properly

---

# Why Alignment Matters

Proper alignment improves:

* SSD performance
* HDD efficiency
* filesystem performance
* lifespan

Modern tools usually align automatically.

---

# Safety Best Practices

## Before modifying disks:

```bash
lsblk
```

## Double-check target disk

Especially:

* `/dev/sda`
* `/dev/sdb`

---

## NEVER partition mounted system disks carelessly

---

## Backup important data first

Partitioning mistakes can permanently destroy data.
