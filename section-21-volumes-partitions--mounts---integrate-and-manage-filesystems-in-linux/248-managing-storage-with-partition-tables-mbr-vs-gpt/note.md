# 248. Managing Storage with Partition Tables: MBR vs GPT

## structure of a storage device

this lecture mainly refers to:

* HDDs
* SSDs
* NVMe drives
* USB drives

not covered here:

* optical discs
* tape storage
* cloud storage

---

## general storage structure

typical disk layout:

```text id="pt001"
Physical Disk
├── Partition Table
│   ├── Partition 1
│   ├── Partition 2
│   └── Partition 3
└── Filesystems inside partitions
```

---

# partition table

the partition table describes:

* where partitions start
* where partitions end
* partition types
* boot information

stored near the beginning of the disk

---

# main partition table types

## MBR (Master Boot Record)

older partitioning scheme

very common historically

---

## characteristics of MBR

### supports only 4 primary partitions

maximum:

```text id="pt002"
4 primary partitions
```

---

## workaround: extended partition

one primary partition can become:

```text id="pt003"
extended partition
```

inside it:

* multiple logical partitions

example:

```text id="pt004"
sda1 primary
sda2 primary
sda3 extended
 ├── sda5 logical
 ├── sda6 logical
```

---

## disk size limitation

maximum supported disk size:

```text id="pt005"
2 TiB
```

because:

* MBR uses 32-bit sector addressing

---

## boot information stored in MBR

MBR contains:

* partition table
* bootloader code

located in:

```text id="pt006"
first 512 bytes of disk
```

---

## disadvantages of MBR

* limited partitions
* limited disk size
* fragile single boot sector
* outdated design

---

# GPT (GUID Partition Table)

modern partitioning scheme

part of:

```text id="pt007"
UEFI standard
```

recommended for modern systems

---

## GPT features

### supports many partitions

typically:

```text id="pt008"
128 partitions
```

without extended partitions

---

## supports large disks

supports disks:

```text id="pt009"
larger than 2 TiB
```

theoretical limit:

* extremely large (zettabytes)

---

## redundancy and reliability

GPT stores:

* backup partition table
* CRC checksums

improves:

* corruption detection
* recovery capability

---

## unique partition identifiers

GPT uses:

```text id="pt010"
GUIDs
```

globally unique identifiers

---

# MBR vs GPT comparison

| Feature        | MBR       | GPT         |
| -------------- | --------- | ----------- |
| Max partitions | 4 primary | 128         |
| Max disk size  | 2 TiB     | Very large  |
| Boot system    | BIOS      | UEFI        |
| Redundancy     | No        | Yes         |
| Reliability    | Lower     | Higher      |
| Modern support | Legacy    | Recommended |

---

# modern Linux systems

most modern Linux installations use:

```text id="pt011"
GPT + UEFI
```

older systems:

```text id="pt012"
MBR + BIOS
```

---

# visualizing partitions with GParted

## GParted

graphical partition editor for Linux

can:

* create partitions
* resize partitions
* delete partitions
* format filesystems
* inspect partition tables

---

## install GParted

Ubuntu/Debian:

```bash id="pt013"
sudo apt install gparted
```

Fedora:

```bash id="pt014"
sudo dnf install gparted
```

---

## launch GParted

```bash id="pt015"
sudo gparted
```

or open from applications menu

---

## what you will see

example layout:

```text id="pt016"
/dev/sda
├── EFI partition
├── root partition
├── swap
└── home partition
```

shows:

* filesystem types
* partition sizes
* used/free space
* partition table type

---

# common Linux partition layout

example:

```text id="pt017"
/dev/sda1   EFI System Partition
/dev/sda2   Linux filesystem (/)
/dev/sda3   swap
/dev/sda4   /home
```

---

# EFI System Partition (ESP)

used on UEFI systems

contains:

* bootloaders
* EFI binaries

usually:

```text id="pt018"
FAT32
```

mounted at:

```text id="pt019"
/boot/efi
```

---

# checking partition tables from CLI

## list block devices

```bash id="pt020"
lsblk
```

---

## detailed partition info

```bash id="pt021"
sudo fdisk -l
```

shows:

* partitions
* sizes
* MBR/GPT type

example:

```text id="pt022"
Disklabel type: gpt
```

---

## parted utility

```bash id="pt023"
sudo parted -l
```

---

# LVM (Logical Volume Manager)

## what is LVM?

abstraction layer over physical disks

allows:

* combining disks
* resizing storage dynamically
* snapshots
* flexible volume management

---

# traditional partitioning

without LVM:

```text id="pt024"
Disk → Partition → Filesystem
```

fixed sizes

hard to resize later

---

# LVM structure

```text id="pt025"
Physical Disk
   ↓
Physical Volume (PV)
   ↓
Volume Group (VG)
   ↓
Logical Volume (LV)
   ↓
Filesystem
```

---

## advantages of LVM

### combine multiple disks

example:

* merge 2 disks into one logical volume

---

## dynamic resizing

grow/shrink volumes:

* often without reinstalling

---

## snapshots

useful for:

* backups
* VM systems
* rollback

---

## flexible storage management

much more powerful than static partitions

---

# recognizing LVM in Linux

you may see:

```text id="pt026"
/dev/mapper/
/dev/dm-0
```

or filesystem type:

```text id="pt027"
LVM2_member
```

---

# useful commands preview

show disks:

```bash id="pt028"
lsblk
```

show partition tables:

```bash id="pt029"
sudo fdisk -l
```

show filesystem UUIDs:

```bash id="pt030"
blkid
```

open partition editor:

```bash id="pt031"
sudo gparted
```

show LVM:

```bash id="pt032"
sudo pvs
sudo vgs
sudo lvs
```

---

# important practical idea

Linux separates:

1. physical storage
2. partitions
3. filesystems
4. mount points

this separation gives:

* flexibility
* scalability
* easier recovery
* advanced storage management
