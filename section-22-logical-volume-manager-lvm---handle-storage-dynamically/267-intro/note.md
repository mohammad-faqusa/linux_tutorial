# 267. Introduction to Logical Volume Manager (LVM)

## storage setup so far

Until now, our Linux storage structure looked like this:

```text id="lvm001"
Physical Disk
   ↓
Partitions
   ↓
Filesystems
   ↓
Mounted directories
```

Example:

```text id="lvm002"
/dev/sda
├── /dev/sda1
├── /dev/sda2
```

Each partition:

* fixed in size
* constrained by one physical disk

---

# limitation of traditional partitioning

Suppose:

```text id="lvm003"
/dev/sda2 = 50GB
```

If the disk becomes full:

* difficult to expand
* limited by physical disk size

Even if:

* another empty disk exists

traditional partitions cannot easily span disks.

---

# problem statement

## why can't one volume use multiple drives?

Example:

```text id="lvm004"
Disk A = 50GB
Disk B = 50GB
Disk C = 50GB
```

Traditional partitioning:

* each disk isolated

Wouldn't it be better if:

```text id="lvm005"
all disks behaved like one large storage pool?
```

That is exactly what LVM solves.

---

# what is LVM?

LVM stands for:

```text id="lvm006"
Logical Volume Manager
```

It adds an abstraction layer between:

* physical disks
  and:
* filesystems

---

# traditional storage vs LVM

## traditional

```text id="lvm007"
Disk → Partition → Filesystem
```

Rigid and static.

---

## LVM

```text id="lvm008"
Disk
  ↓
Physical Volume (PV)
  ↓
Volume Group (VG)
  ↓
Logical Volume (LV)
  ↓
Filesystem
```

Much more flexible.

---

# core LVM idea

Instead of:

* filesystem tied directly to one partition

LVM creates:

```text id="lvm009"
virtual/logical storage pools
```

---

# main LVM components

# Physical Volume (PV)

Real storage devices or partitions.

Examples:

```text id="lvm010"
/dev/sdb
/dev/sdc1
/dev/nvme0n1p3
```

converted into:

```text id="lvm011"
LVM physical volumes
```

---

# Volume Group (VG)

Pool of storage created from multiple PVs.

Example:

```text id="lvm012"
VG = 150GB
```

made from:

* 3 disks × 50GB

---

# Logical Volume (LV)

Virtual partitions created from VG.

Examples:

```text id="lvm013"
/dev/myvg/data
/dev/myvg/home
```

These behave like normal partitions.

---

# huge advantage

Logical volumes can:

* span multiple disks
* grow dynamically
* shrink dynamically
* move across disks

without major reconfiguration.

---

# example scenario

## 3 drives

```text id="lvm014"
Drive 1 = 50GB
Drive 2 = 50GB
Drive 3 = 50GB
```

LVM combines them:

```text id="lvm015"
VG total = 150GB
```

Then create:

## option 1

```text id="lvm016"
One LV = 150GB
```

---

## option 2

```text id="lvm017"
Two LVs = 75GB each
```

---

# why this is powerful

You can:

* add new disks later
* extend volumes live
* resize filesystems easier
* manage storage dynamically

Very important for:

* servers
* cloud systems
* virtualization
* enterprise Linux

---

# practical example

Suppose:

```text id="lvm018"
/home
```

becomes full.

Without LVM:

* difficult resizing

With LVM:

```bash id="lvm019"
lvextend
resize2fs
```

filesystem grows dynamically.

---

# thin provisioning

Advanced LVM feature.

Allows:

* allocating "virtual" storage larger than physical space

Useful for:

* VMs
* cloud systems
* containers

Example:

* create:

```text id="lvm020"
1TB logical volume
```

while physically using:

```text id="lvm021"
100GB initially
```

storage grows on demand.

---

# software RAID support

LVM can integrate with:

* RAID concepts

Examples:

* mirroring
* striping

though Linux also has:

```text id="lvm022"
mdadm
```

for dedicated software RAID.

---

# important distinction

## LVM is NOT a filesystem

LVM manages:

```text id="lvm023"
storage abstraction
```

Filesystem still needed on top:

Example:

```text id="lvm024"
LV → ext4
```

---

# example complete stack

```text id="lvm025"
Physical disks
   ↓
LVM PVs
   ↓
Volume Group
   ↓
Logical Volume
   ↓
ext4 filesystem
   ↓
Mounted directory
```

---

# common enterprise usage

Very common in:

* RHEL
* CentOS
* enterprise Linux
* virtualization hosts
* database servers

---

# how LVM appears in Linux

Common paths:

```text id="lvm026"
/dev/mapper/
/dev/<vg-name>/<lv-name>
```

Example:

```text id="lvm027"
/dev/myvg/data
```

---

# useful LVM commands preview

## show physical volumes

```bash id="lvm028"
sudo pvs
```

---

## show volume groups

```bash id="lvm029"
sudo vgs
```

---

## show logical volumes

```bash id="lvm030"
sudo lvs
```

---

## create physical volume

```bash id="lvm031"
sudo pvcreate /dev/sdb
```

---

## create volume group

```bash id="lvm032"
sudo vgcreate myvg /dev/sdb /dev/sdc
```

---

## create logical volume

```bash id="lvm033"
sudo lvcreate -L 50G -n data myvg
```

---

## create filesystem

```bash id="lvm034"
sudo mkfs.ext4 /dev/myvg/data
```

---

## mount it

```bash id="lvm035"
sudo mount /dev/myvg/data /mnt/data
```

---

# important practical benefit

Without LVM:

```text id="lvm036"
storage planning must be predicted early
```

With LVM:

* much more flexible
* easier future growth

---

# conceptual analogy

Traditional partitions:

```text id="lvm037"
fixed-size boxes
```

LVM:

```text id="lvm038"
dynamic storage pool
```

---

# important professional relevance

LVM is heavily used in:

* cloud infrastructure
* virtualization
* enterprise Linux
* DevOps/server environments

Understanding it is very valuable for:

* backend
* infrastructure
* SRE/DevOps paths

---

# useful commands summary

Show block devices:

```bash id="lvm039"
lsblk
```

Show physical volumes:

```bash id="lvm040"
sudo pvs
```

Show volume groups:

```bash id="lvm041"
sudo vgs
```

Show logical volumes:

```bash id="lvm042"
sudo lvs
```

Show detailed LVM info:

```bash id="lvm043"
sudo lvdisplay
sudo vgdisplay
sudo pvdisplay
```
