# 276. Resizing Logical Volumes with LVM

## important architecture reminder

```text id="lvresize001"
Physical Volumes (PV)
   ↓
Volume Group (VG)
   ↓
Logical Volume (LV)
   ↓
Filesystem
```

When resizing:

* sometimes LV changes
* sometimes filesystem changes
* often BOTH must change

---

# increasing the size of a Logical Volume

## requirement

The Volume Group must have:

```text id="lvresize002"
free space available
```

Check with:

```bash id="lvresize003"
sudo vgs
```

Look at:

```text id="lvresize004"
VFree
```

---

# extend LV to exact size

## syntax

```bash id="lvresize005"
sudo lvextend -L 20G --resizefs /dev/vgroup/data
```

Meaning:

* set LV size to:

```text id="lvresize006"
20GB total
```

---

# Important flag

```text id="lvresize007"
--resizefs
```

Very useful.

LVM automatically:

1. extends logical volume
2. expands filesystem

for supported filesystems like:

* ext4

---

# increase relatively

## add 1GB

```bash id="lvresize008"
sudo lvextend -L +1G --resizefs /dev/vgroup/data
```

Meaning:

* current size + 1GB

---

# difference between absolute and relative

| Syntax   | Meaning          |
| -------- | ---------------- |
| `-L 20G` | final size = 20G |
| `-L +1G` | add 1G           |

---

# if --resizefs unsupported

Some filesystems may not auto-expand.

Then:

1. extend LV
2. manually resize filesystem

---

# manual ext4 expansion

## Step 1: extend LV

```bash id="lvresize009"
sudo lvextend -L +1G /dev/vgroup/data
```

---

## Step 2: grow filesystem

```bash id="lvresize010"
sudo resize2fs /dev/vgroup/data
```

Ext4 automatically expands to:

```text id="lvresize011"
maximum LV size
```

---

# verify result

## show logical volumes

```bash id="lvresize012"
sudo lvs
```

---

## show filesystem size

```bash id="lvresize013"
df -h
```

Very important distinction:

| Command | Shows           |
| ------- | --------------- |
| lvs     | LV size         |
| df -h   | filesystem size |

---

# important ext4 advantage

Ext4 supports:

```text id="lvresize014"
online expansion
```

Meaning:

* filesystem may remain mounted while growing.

Very convenient.

---

# decreasing the size of a Logical Volume

## VERY IMPORTANT WARNING

Shrinking is MUCH more dangerous than expansion.

Wrong order may:

```text id="lvresize015"
destroy data
```

---

# VERY IMPORTANT RULE

## shrinking order

Correct order:

```text id="lvresize016"
1. shrink filesystem first
2. shrink LV second
```

---

# Why?

Filesystem lives INSIDE the LV.

If LV shrinks first:

* filesystem data may get truncated

---

# Step 1: unmount filesystem

Ext4 shrinking requires:

```text id="lvresize017"
filesystem unmounted
```

```bash id="lvresize018"
sudo umount /dev/vgroup/data
```

---

# Step 2: filesystem check

Best practice before shrinking:

```bash id="lvresize019"
sudo fsck.ext4 /dev/vgroup/data
```

---

# Step 3: shrink filesystem

Example:

```bash id="lvresize020"
sudo resize2fs /dev/vgroup/data 15G
```

Meaning:

* filesystem becomes:

```text id="lvresize021"
15GB
```

---

# Step 4: reduce Logical Volume

Now safely reduce LV:

```bash id="lvresize022"
sudo lvreduce -L 15G /dev/vgroup/data
```

---

# verify

## remount filesystem

```bash id="lvresize023"
sudo mount /dev/vgroup/data /mnt/data
```

---

## check filesystem size

```bash id="lvresize024"
df -h
```

---

# IMPORTANT safety recommendation

Instead of:

```bash
lvreduce
```

many admins prefer:

```bash
lvreduce --resizefs
```

because:

* LVM coordinates filesystem resizing automatically

Example:

```bash id="lvresize025"
sudo lvreduce --resizefs -L 15G /dev/vgroup/data
```

Safer for ext4.

---

# important ext4 behavior

## ext4 supports:

| Operation | Mounted? |
| --------- | -------- |
| grow      | yes      |
| shrink    | no       |

---

# XFS behavior

XFS:

* supports growth
* CANNOT shrink

Example grow command:

```bash id="lvresize026"
sudo xfs_growfs /mountpoint
```

---

# understanding the layers

Suppose:

Before shrink:

| Layer | Size |
| ----- | ---- |
| LV    | 20G  |
| ext4  | 20G  |

---

After `resize2fs 15G`:

| Layer | Size |
| ----- | ---- |
| LV    | 20G  |
| ext4  | 15G  |

Unused space now exists inside LV.

---

After `lvreduce 15G`:

| Layer | Size |
| ----- | ---- |
| LV    | 15G  |
| ext4  | 15G  |

Now sizes match again.

---

# useful visualization

## expansion

```text id="lvresize027"
Expand:
LV → Filesystem
```

---

## shrinking

```text id="lvresize028"
Shrink:
Filesystem → LV
```

---

# common enterprise workflow

## add storage dynamically

```bash id="lvresize029"
pvcreate
vgextend
lvextend
resize2fs
```

without reinstalling systems.

---

# important professional advantage

LVM allows:

* resizing live systems
* dynamic storage growth
* online maintenance
* virtualization-friendly storage

Huge advantage over traditional partitions.

---

# useful commands summary

Show VGs:

```bash id="lvresize030"
sudo vgs
```

Show LVs:

```bash id="lvresize031"
sudo lvs
```

Extend LV to exact size:

```bash id="lvresize032"
sudo lvextend -L 20G --resizefs /dev/vgroup/data
```

Add 1GB:

```bash id="lvresize033"
sudo lvextend -L +1G --resizefs /dev/vgroup/data
```

Manual ext4 resize:

```bash id="lvresize034"
sudo resize2fs /dev/vgroup/data
```

Unmount:

```bash id="lvresize035"
sudo umount /dev/vgroup/data
```

Shrink filesystem:

```bash id="lvresize036"
sudo resize2fs /dev/vgroup/data 15G
```

Reduce LV:

```bash id="lvresize037"
sudo lvreduce -L 15G /dev/vgroup/data
```

Show filesystem sizes:

```bash id="lvresize038"
df -h
```
