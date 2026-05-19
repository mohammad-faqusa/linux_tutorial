# 272. Initializing Physical Volumes with LVM

## goal

Before using LVM, disks or partitions must first become:

```text id="pv001"
Physical Volumes (PV)
```

A PV is:

* the lowest LVM layer
* storage prepared for LVM usage

---

# important architecture reminder

```text id="pv002"
Disk/Partition
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

# two approaches

## option 1 (recommended)

Initialize:

```text id="pv003"
partition
```

Example:

```text id="pv004"
/dev/sdb1
```

This is the safest/common approach.

---

## option 2

Initialize:

```text id="pv005"
entire disk
```

Example:

```text id="pv006"
/dev/sdb
```

Possible, but usually less recommended.

---

# Why partitions are preferred

Partition tables:

* help organization
* improve compatibility
* reduce accidental overwrites
* make recovery/debugging easier

Many tools expect:

```text id="pv007"
GPT/MBR + partitions
```

---

# Step 1: open parted

```bash id="pv008"
sudo parted /dev/sdb
```

---

# Step 2: create partition table

Inside parted:

```bash id="pv009"
(parted) mklabel
```

Then choose:

```text id="pv010"
gpt
```

---

# what is `mklabel`?

Creates:

```text id="pv011"
partition table
```

This ERASES existing partition metadata.

---

# GPT recommended

Modern systems should prefer:

```text id="pv012"
GPT
```

instead of:

```text id="pv013"
MBR
```

because:

* supports large disks
* more partitions
* modern UEFI compatibility

---

# Step 3: create partition

```bash id="pv014"
(parted) mkpart primary 0% 100%
```

Meaning:

* create partition using full disk

---

# Step 4: mark partition as LVM

```bash id="pv015"
(parted) set 1 lvm on
```

Meaning:

* partition type flagged as:

```text id="pv016"
Linux LVM
```

Partition:

```text id="pv017"
/dev/sdb1
```

now identified as LVM partition.

---

# Step 5: quit parted

```bash id="pv018"
(parted) quit
```

---

# Step 6: initialize physical volume

```bash id="pv019"
sudo pvcreate /dev/sdb1
```

This writes:

* LVM metadata
* physical extent structures

Now:

```text id="pv020"
/dev/sdb1
```

became:

```text id="pv021"
Physical Volume (PV)
```

---

# verify PV creation

```bash id="pv022"
sudo pvs
```

Example:

```text id="pv023"
PV         VG   Fmt  Attr PSize   PFree
/dev/sdb1       lvm2 a--  <50.00g <50.00g
```

---

# detailed view

```bash id="pv024"
sudo pvdisplay
```

Shows:

* UUID
* size
* physical extents
* metadata info

---

# Physical Extents (PE)

LVM internally divides PVs into chunks called:

```text id="pv025"
Physical Extents (PE)
```

Similar to:

* blocks/pages inside storage

Typical PE size:

```text id="pv026"
4 MiB
```

LVM allocates storage using these extents.

---

# repeat for additional disks

## second disk

```bash id="pv027"
sudo parted /dev/sdc
```

Inside:

```bash id="pv028"
(parted) mklabel gpt
(parted) mkpart primary 0% 100%
(parted) set 1 lvm on
(parted) quit
```

Then:

```bash id="pv029"
sudo pvcreate /dev/sdc1
```

---

# third disk

```bash id="pv030"
sudo parted /dev/sdd
```

Inside:

```bash id="pv031"
(parted) mklabel gpt
(parted) mkpart primary 0% 100%
(parted) set 1 lvm on
(parted) quit
```

Then:

```bash id="pv032"
sudo pvcreate /dev/sdd1
```

---

# show all physical volumes

```bash id="pv033"
sudo pvs
```

or:

```bash id="pv034"
sudo pvdisplay
```

---

# Important warning about whole-disk pvcreate

Example:

```bash id="pv035"
sudo pvcreate /dev/sdb
```

If GPT already exists:

* LVM warns/refuses

because:

* it would overwrite partition metadata

---

# why whole-disk PVs can be risky

Some software/tools may:

* overwrite beginning of disk
* expect partition tables
* become confused without GPT/MBR

Thus:

```text id="pv036"
partition-based PVs are safer
```

---

# troubleshooting

## if PVs do not appear

Run:

```bash id="pv037"
sudo pvscan
```

This scans system for LVM metadata.

---

# additional useful LVM scans

## scan volume groups

```bash id="pv038"
sudo vgscan
```

---

## scan logical volumes

```bash id="pv039"
sudo lvscan
```

---

# inspect partition types

```bash id="pv040"
lsblk -f
```

or:

```bash id="pv041"
sudo fdisk -l
```

You should see:

```text id="pv042"
Linux LVM
```

partition type.

---

# important practical distinction

| Layer           | Example            |
| --------------- | ------------------ |
| Physical disk   | /dev/sdb           |
| Partition       | /dev/sdb1          |
| Physical Volume | pvcreate /dev/sdb1 |

---

# what happens internally after pvcreate

LVM writes:

* metadata headers
* UUID
* extent maps

onto the partition.

---

# professional best practice

Common enterprise setup:

```text id="pv043"
GPT partition
→ LVM PV
→ VG
→ LV
→ ext4/xfs
```

---

# useful commands summary

Open parted:

```bash id="pv044"
sudo parted /dev/sdb
```

Create GPT:

```bash id="pv045"
(parted) mklabel gpt
```

Create partition:

```bash id="pv046"
(parted) mkpart primary 0% 100%
```

Enable LVM flag:

```bash id="pv047"
(parted) set 1 lvm on
```

Initialize PV:

```bash id="pv048"
sudo pvcreate /dev/sdb1
```

Show PVs:

```bash id="pv049"
sudo pvs
```

Detailed PV info:

```bash id="pv050"
sudo pvdisplay
```

Rescan PVs:

```bash id="pv051"
sudo pvscan
```

Show block devices:

```bash id="pv052"
lsblk -f
```
