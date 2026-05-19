# 265. Reducing File Systems and Partitions

## important concept

When shrinking storage, there are TWO separate layers:

```text id="resize001"
Partition
Filesystem
```

and they must be resized in the correct order.

---

# VERY IMPORTANT RULE

## shrinking order

Correct order:

```text id="resize002"
1. Shrink filesystem first
2. Shrink partition second
```

---

# Why?

Because:

* filesystem lives INSIDE the partition

If you shrink partition first:

* filesystem data may get cut off
* permanent corruption/data loss may occur

---

# growing is opposite

## expanding order

```text id="resize003"
1. Expand partition first
2. Expand filesystem second
```

---

# common resizing scenario

Suppose disk layout:

```text id="resize004"
/dev/sdb1
/dev/sdb2   ← very large partition
```

but you want:

```text id="resize005"
/dev/sdb1
/dev/sdb2   ← smaller
/dev/sdb3   ← new partition
```

Need:

* free space from shrinking `sdb2`

---

# Step 1: unmount filesystem

Usually required for shrinking.

```bash id="resize006"
sudo umount /dev/sdb2
```

Verify:

```bash id="resize007"
mount | grep sdb2
```

No output means:

* unmounted.

---

# Step 2: filesystem check (VERY important)

Best practice before resizing:

```bash id="resize008"
sudo fsck.ext4 /dev/sdb2
```

or generic:

```bash id="resize009"
sudo fsck /dev/sdb2
```

This ensures:

* filesystem consistency before resize

---

# Step 3: shrink filesystem

## ext4 resizing

```bash id="resize010"
sudo resize2fs /dev/sdb2 10G
```

Meaning:

* filesystem becomes:

```text id="resize011"
10 GiB
```

---

# Important note about resize2fs

`resize2fs` modifies:

```text id="resize012"
filesystem size
```

NOT:

```text id="resize013"
partition size
```

yet.

---

# After resize2fs

Partition still large, but:

* filesystem now occupies less space

Unused area appears inside partition.

---

# Step 4: shrink partition itself

Now reduce actual partition boundary.

---

# Using parted

Start:

```bash id="resize014"
sudo parted /dev/sdb
```

---

# Show current layout

```bash id="resize015"
(parted) print
```

Example:

```text id="resize016"
Number  Start   End     Size
2       1GiB    20GiB   19GiB
```

---

# IMPORTANT about units

Parted may default to:

```text id="resize017"
GB
```

while filesystem tools use:

```text id="resize018"
GiB
```

This mismatch can cause:

* resize failures
* rounding issues

---

# Set GiB units explicitly

```bash id="resize019"
(parted) unit GiB
```

VERY recommended.

---

# Resize partition

```bash id="resize020"
(parted) resizepart
```

Then:

* partition number:

```text id="resize021"
2
```

Then:

* new end position

Example:

```text id="resize022"
11GiB
```

---

# Example full flow

```bash id="resize023"
(parted) unit GiB
(parted) print
(parted) resizepart
Partition number? 2
End? 11GiB
```

---

# Exit parted

```bash id="resize024"
(parted) quit
```

---

# Step 5: verify result

```bash id="resize025"
lsblk
```

or:

```bash id="resize026"
sudo fdisk -l
```

---

# Step 6: create new partition

Now free space exists.

Use:

* GParted
  or:
* parted/fdisk

to create:

```text id="resize027"
/dev/sdb3
```

---

# Important filesystem limitations

Not all filesystems support shrinking.

---

# ext4

Supports:

* grow
* shrink

---

# XFS

Supports:

* grow only

Cannot shrink safely.

To reduce XFS:

1. backup data
2. recreate filesystem
3. restore data

---

# Btrfs

Supports:

* online resize
* shrink/grow

more flexible.

---

# FAT/exFAT/NTFS

Behavior varies by tools/platform.

---

# Very important safety practices

## ALWAYS backup first

Partition resizing is dangerous.

---

## NEVER resize mounted filesystem when shrinking

Especially ext4 shrinking:

* requires unmounted filesystem

---

## NEVER interrupt resize operation

Power loss during resize:

* can destroy filesystem

---

# graphical approach with GParted

GParted often automates:

* fsck
* resize2fs
* partition resize

in correct order.

But understanding CLI is very important professionally.

---

# Example full safe workflow

```bash id="resize028"
sudo umount /dev/sdb2
sudo fsck.ext4 /dev/sdb2
sudo resize2fs /dev/sdb2 10G
sudo parted /dev/sdb
```

Inside parted:

```bash id="resize029"
(parted) unit GiB
(parted) resizepart
(parted) quit
```

Then:

```bash id="resize030"
sudo mount /dev/sdb2 /mnt/data
```

---

# Understanding the gray area in GParted

After shrinking filesystem:

* partition still large
* unused blocks appear visually

Only after shrinking partition:

* real unallocated disk space appears

---

# Important distinction

| Tool                 | Layer                  |
| -------------------- | ---------------------- |
| resize2fs            | filesystem             |
| parted/fdisk/gparted | partition              |
| fsck                 | filesystem consistency |

---

# useful commands summary

Unmount:

```bash id="resize031"
sudo umount /dev/sdb2
```

Filesystem check:

```bash id="resize032"
sudo fsck.ext4 /dev/sdb2
```

Shrink ext4:

```bash id="resize033"
sudo resize2fs /dev/sdb2 10G
```

Open parted:

```bash id="resize034"
sudo parted /dev/sdb
```

Show partitions:

```bash id="resize035"
(parted) print
```

Use GiB units:

```bash id="resize036"
(parted) unit GiB
```

Resize partition:

```bash id="resize037"
(parted) resizepart
```

Show block devices:

```bash id="resize038"
lsblk
```

Open GParted:

```bash id="resize039"
sudo gparted
```
