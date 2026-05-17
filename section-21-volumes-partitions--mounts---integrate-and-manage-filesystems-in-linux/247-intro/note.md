# Section 21: Volumes, Partitions & Mounts - Integrate and Manage Filesystems in Linux

## 247. Introduction

### overview of this chapter

in this chapter, you will learn:

* how Linux filesystems work internally
* how storage devices are organized
* how partitions and volumes are managed
* how Linux attaches filesystems into the directory tree
* how persistent mounts work
* how to recover and inspect damaged filesystems

---

## topics covered

### filesystems

understanding:

* what a filesystem is
* how data is stored on disks
* metadata and inodes
* filesystem hierarchy

common Linux filesystems:

* ext4
* xfs
* btrfs
* vfat
* ntfs

---

## mounts

learn:

* how Linux mounts storage devices
* how external drives become accessible
* mount points
* temporary vs permanent mounts

examples:

* USB drives
* SSDs
* external HDDs
* network storage

---

## `/etc/fstab`

persistent filesystem configuration

you will learn:

* automatic mounting during boot
* mount options
* UUID usage
* boot-time mount behavior

important file:

```text id="mnt001"
/etc/fstab
```

---

## remote filesystem mounts

Linux can mount remote storage directly into local filesystem tree.

examples:

* NFS
* SMB/CIFS
* SSHFS
* FTP mounts

this allows:

* using remote files as if they were local

---

## broken filesystem recovery

important practical topic:

* recovering access to damaged filesystems

you will learn:

* checking filesystems
* repair tools
* read-only recovery mounting
* emergency access techniques

common tools:

```bash id="mnt002"
fsck
mount
lsblk
blkid
```

---

## key Linux concept

everything in Linux integrates into:

```text id="mnt003"
/
```

the root filesystem tree

Linux does not use:

```text id="mnt004"
C:
D:
E:
```

like Windows.

instead:

* all filesystems are mounted somewhere inside:

```text id="mnt005"
/
```

---

## examples of mount points

```text id="mnt006"
/home
/mnt/usb
/media/mohammad/MyDrive
/var
/boot
```

each may represent:

* different partitions
* different disks
* remote storage

---

## important commands preview

list block devices:

```bash id="mnt007"
lsblk
```

show mounted filesystems:

```bash id="mnt008"
mount
```

disk usage:

```bash id="mnt009"
df -h
```

filesystem identifiers:

```bash id="mnt010"
blkid
```

manual mounting:

```bash id="mnt011"
mount /dev/sdb1 /mnt/usb
```

unmounting:

```bash id="mnt012"
umount /mnt/usb
```

filesystem check:

```bash id="mnt013"
fsck /dev/sdb1
```

---

## practical importance

understanding mounts and filesystems is essential for:

* Linux administration
* servers
* Docker/Kubernetes storage
* cloud systems
* backup systems
* recovery troubleshooting
* external storage management
* virtualization

---

## real-world examples

### mounting USB drive

```bash id="mnt014"
sudo mount /dev/sdb1 /mnt/usb
```

---

### mounting remote server storage

```bash id="mnt015"
sshfs user@server:/data /mnt/server
```

---

### automatic mount at boot

configured inside:

```text id="mnt016"
/etc/fstab
```

---

### recovering damaged partition

```bash id="mnt017"
sudo fsck /dev/sdb1
```

---

## important conceptual distinction

### physical layer

actual hardware:

* SSD
* HDD
* NVMe
* USB

---

### partition layer

logical subdivisions:

```text id="mnt018"
/dev/sda1
/dev/sda2
```

---

### filesystem layer

how data is organized:

* ext4
* xfs
* ntfs

---

### mount layer

where filesystem appears:

```text id="mnt019"
/home
/mnt/data
```

---

## chapter outcome

after this chapter, you should understand:

* how Linux organizes storage
* how mounting works internally
* how to manage partitions and filesystems safely
* how Linux integrates multiple storage devices into one filesystem hierarchy
* how to recover access to storage problems safely
