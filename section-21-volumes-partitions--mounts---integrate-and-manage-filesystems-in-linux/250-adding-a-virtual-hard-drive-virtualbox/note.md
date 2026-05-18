# 250. Adding a Virtual Hard Drive [VirtualBox]

## goal

add an additional virtual hard drive to a VirtualBox VM.

this simulates:

* adding a new SSD/HDD to a real Linux machine

useful for practicing:

* partitions
* filesystems
* mounts
* LVM
* `/etc/fstab`

---

# important requirement

before modifying storage:

```text id="vbox001"
the VM must be fully powered off
```

not:

* saved state
* paused

must be:

```text id="vbox002"
Shutdown
```

---

# adding a new virtual disk

## open VirtualBox

select your VM.

---

## open settings

```text id="vbox003"
Settings → Storage
```

---

# storage controllers

inside:

```text id="vbox004"
Storage
```

you will see:

* controllers
* attached virtual disks

examples:

```text id="vbox005"
SATA Controller
IDE Controller
NVMe Controller
```

---

# adding a disk

select:

```text id="vbox006"
Controller
```

then click:

```text id="vbox007"
Add Hard Disk
```

icon usually looks like:

```text id="vbox008"
small disk with plus sign
```

---

# create new disk

choose:

```text id="vbox009"
Create
```

---

# select disk file type

common options:

## VDI

```text id="vbox010"
VirtualBox Disk Image
```

native VirtualBox format

recommended for most cases.

---

## VMDK

VMware-compatible format

---

## VHD

Hyper-V compatible format

---

# storage allocation type

## dynamically allocated

recommended for most users.

advantages:

* disk file grows as data is added
* saves host storage space

example:

* 100GB virtual disk initially may consume:

```text id="vbox011"
few MB only
```

---

## pre-allocate full size

NOT usually recommended.

if selected:

* full disk size reserved immediately on host disk

example:

* 100GB virtual disk instantly occupies:

```text id="vbox012"
100GB
```

advantages:

* slightly better performance
* less fragmentation

disadvantages:

* wastes space
* slower creation

---

# choose disk size

example:

```text id="vbox013"
50GB
```

or:

```text id="vbox014"
20GB
```

---

# choose disk location

example:

```text id="vbox015"
/home/mohammad/VirtualBox VMs/ubuntu/data.vdi
```

---

# attach the disk

after creation:

* attach it to controller

then:

```text id="vbox016"
OK
```

---

# start the VM

boot Linux normally.

---

# verify new disk inside Linux

after boot:

```bash id="vbox017"
lsblk
```

example output:

```text id="vbox018"
sda    100G
├─sda1
└─sda2

sdb     50G
```

new disk often appears as:

```text id="vbox019"
/dev/sdb
```

---

# additional useful commands

## show disks

```bash id="vbox020"
sudo fdisk -l
```

---

## show filesystem info

```bash id="vbox021"
blkid
```

---

## graphical partition tool

```bash id="vbox022"
sudo gparted
```

---

# important naming convention

## first disk

```text id="vbox023"
/dev/sda
```

---

## second disk

```text id="vbox024"
/dev/sdb
```

---

## partitions

```text id="vbox025"
/dev/sdb1
/dev/sdb2
```

---

# typical workflow after adding disk

1. add virtual disk in VirtualBox
2. boot Linux
3. detect disk:

```bash id="vbox026"
lsblk
```

4. create partition table
5. create partitions
6. create filesystem
7. mount filesystem
8. configure `/etc/fstab`

---

# important warning

be careful NOT to modify:

```text id="vbox027"
/dev/sda
```

if that is your system disk.

practice on:

```text id="vbox028"
/dev/sdb
```

instead.

---

# VirtualBox storage concepts

## virtual disk file

on host machine:

```text id="vbox029"
.vdi
```

acts like:

* simulated physical HDD/SSD

---

## guest OS sees it as real hardware

Linux inside VM treats it like:

* actual block device

---

# recommended practice setup

example:

| Disk       | Purpose       |
| ---------- | ------------- |
| `/dev/sda` | Linux system  |
| `/dev/sdb` | practice disk |

---

# useful commands summary

show block devices:

```bash id="vbox030"
lsblk
```

show partitions:

```bash id="vbox031"
sudo fdisk -l
```

open partition editor:

```bash id="vbox032"
sudo gparted
```

show filesystem UUIDs:

```bash id="vbox033"
blkid
```

show mounted filesystems:

```bash id="vbox034"
mount
```
