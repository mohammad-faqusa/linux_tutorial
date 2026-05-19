# 273. Creating a Volume Group with LVM

## what is a Volume Group (VG)?

A Volume Group is:

* a storage pool
* created from one or more Physical Volumes (PVs)

It combines multiple disks/partitions into:

```text id="vg001"
one logical storage container
```

---

# architecture reminder

```text id="vg002"
Physical Disks
   ↓
Partitions
   ↓
Physical Volumes (PV)
   ↓
Volume Group (VG)
   ↓
Logical Volumes (LV)
   ↓
Filesystem
```

---

# current situation

Suppose we already initialized:

```text id="vg003"
/dev/sdb1
/dev/sdc1
/dev/sdd1
```

as:

```text id="vg004"
Physical Volumes
```

using:

```bash id="vg005"
sudo pvcreate /dev/sdb1
sudo pvcreate /dev/sdc1
sudo pvcreate /dev/sdd1
```

---

# creating the Volume Group

## syntax

```bash id="vg006"
sudo vgcreate <vg-name> <pv1> <pv2> ...
```

---

# example

```bash id="vg007"
sudo vgcreate vgroup /dev/sdb1 /dev/sdc1 /dev/sdd1
```

Meaning:

* create VG named:

```text id="vg008"
vgroup
```

using:

* 3 physical volumes

---

# what happens internally

LVM combines all PV storage into:

```text id="vg009"
one large virtual pool
```

Example:

| Disk | Size |
| ---- | ---- |
| sdb1 | 50GB |
| sdc1 | 50GB |
| sdd1 | 50GB |

Result:

```text id="vg010"
VG Size = 150GB
```

approximately.

---

# verify physical volumes

Before VG creation:

```bash id="vg011"
sudo pvs
```

Example:

```text id="vg012"
PV         VG   Fmt  Attr PSize   PFree
/dev/sdb1       lvm2 a--  <50.00g <50.00g
```

No VG assigned yet.

---

# after VG creation

Run again:

```bash id="vg013"
sudo pvs
```

Now:

```text id="vg014"
PV         VG       Fmt  Attr PSize   PFree
/dev/sdb1  vgroup   lvm2 a--  <50.00g <50.00g
```

Meaning:

* PV now belongs to:

```text id="vg015"
vgroup
```

---

# listing volume groups

## short summary

```bash id="vg016"
sudo vgs
```

Example:

```text id="vg017"
VG       #PV #LV #SN Attr   VSize    VFree
vgroup     3   0   0 wz--n- <150.00g <150.00g
```

---

# detailed view

```bash id="vg018"
sudo vgdisplay
```

Shows:

* VG UUID
* VG size
* PE size
* free extents
* allocated extents

---

# important concepts

# VG Size

Total storage available in the VG.

Example:

```text id="vg019"
VG Size = 150GB
```

---

# PE Size

PE = Physical Extent

LVM divides storage into chunks.

Example:

```text id="vg020"
PE Size = 4 MiB
```

All allocations happen in:

```text id="vg021"
PE units
```

---

# why extents matter

Logical volumes are internally built from:

```text id="vg022"
collections of extents
```

This makes:

* resizing
* moving
* allocation

much more flexible.

---

# important VG properties

Example attributes:

```text id="vg023"
wz--n-
```

Common meanings:

* writable
* resizable
* normal allocation

---

# scanning for volume groups

Sometimes newly created VGs do not appear immediately.

Run:

```bash id="vg024"
sudo vgscan
```

This scans all disks for:

```text id="vg025"
VG metadata
```

---

# additional scan commands

## scan PVs

```bash id="vg026"
sudo pvscan
```

---

## scan LVs

```bash id="vg027"
sudo lvscan
```

---

# practical importance of VG

The VG acts as:

```text id="vg028"
shared storage pool
```

From this pool you can create:

* one huge LV
  or:
* many smaller LVs

---

# example future allocations

From:

```text id="vg029"
150GB VG
```

You could create:

## option 1

```text id="vg030"
LV home = 100GB
LV backups = 50GB
```

---

## option 2

```text id="vg031"
one LV = 150GB
```

---

# adding storage later

Huge LVM advantage:

You can later add another disk:

```bash id="vg032"
sudo pvcreate /dev/sde1
sudo vgextend vgroup /dev/sde1
```

Then VG grows dynamically.

---

# removing storage

Possible too (carefully):

* move extents
* reduce VG
* remove PV

---

# important naming conventions

Typical enterprise names:

| Layer | Example            |
| ----- | ------------------ |
| VG    | vgdata             |
| LV    | lvhome             |
| Path  | /dev/vgdata/lvhome |

---

# how VG appears in Linux

After creation:

```bash id="vg033"
ls /dev/vgroup
```

may later contain:

```text id="vg034"
logical volumes
```

after LV creation.

---

# useful verification commands

Show block devices:

```bash id="vg035"
lsblk
```

Show LVM hierarchy:

```bash id="vg036"
sudo pvs
sudo vgs
sudo lvs
```

---

# important distinction

| Component | Purpose           |
| --------- | ----------------- |
| PV        | physical storage  |
| VG        | pooled storage    |
| LV        | virtual partition |

---

# useful commands summary

Show PVs:

```bash id="vg037"
sudo pvs
```

Create VG:

```bash id="vg038"
sudo vgcreate vgroup /dev/sdb1 /dev/sdc1 /dev/sdd1
```

Show VGs:

```bash id="vg039"
sudo vgs
```

Detailed VG info:

```bash id="vg040"
sudo vgdisplay
```

Scan for VGs:

```bash id="vg041"
sudo vgscan
```

Scan for PVs:

```bash id="vg042"
sudo pvscan
```

Scan for LVs:

```bash id="vg043"
sudo lvscan
```

Show block devices:

```bash id="vg044"
lsblk
```
