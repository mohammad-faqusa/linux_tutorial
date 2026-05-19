# 266. Expanding File Systems and Partitions

## important concept

Expanding storage works in the OPPOSITE order of shrinking.

---

# VERY IMPORTANT RULE

## expanding order

Correct order:

```text id="expand001"
1. Expand partition first
2. Expand filesystem second
```

---

# Why?

Because:

* filesystem cannot grow beyond partition boundaries

So first:

* make partition larger

then:

* extend filesystem into new free space

---

# example scenario

Current layout:

```text id="expand002"
/dev/sdb3 → 10GiB
```

But free unallocated space exists after it.

Goal:

```text id="expand003"
/dev/sdb3 → 20GiB
```

---

# creating a new partition

## Step 1: open parted

```bash id="expand004"
sudo parted /dev/sdb
```

---

# Step 2: inspect layout

```bash id="expand005"
(parted) print
```

Shows:

* partition numbers
* start/end
* free space

---

# Step 3: create partition

Syntax:

```bash id="expand006"
(parted) mkpart <name> <type> <start> <end>
```

Example:

```bash id="expand007"
(parted) mkpart primary ext4 20GiB 30GiB
```

---

# Step 4: quit parted

```bash id="expand008"
(parted) quit
```

---

# Step 5: create filesystem

Format partition:

```bash id="expand009"
sudo mkfs.ext4 /dev/sdb3
```

WARNING:

* destroys existing data on that partition.

---

# Step 6: create mount point

```bash id="expand010"
sudo mkdir -p /mnt/data
```

---

# Step 7: mount filesystem

```bash id="expand011"
sudo mount /dev/sdb3 /mnt/data
```

---

# verify

```bash id="expand012"
df -h
```

or:

```bash id="expand013"
lsblk -f
```

---

# increasing the size of an EXISTING partition

Now assume:

```text id="expand014"
/dev/sdb3
```

already exists and contains data.

We want to expand it safely.

---

# Step 1: enlarge partition

## open parted

```bash id="expand015"
sudo parted /dev/sdb
```

---

# Step 2: resize partition

```bash id="expand016"
(parted) resizepart
```

Then:

* partition number
* new end boundary

Example:

```text id="expand017"
Partition number? 3
End? 30GiB
```

---

# Step 3: quit parted

```bash id="expand018"
(parted) quit
```

---

# At this point

Partition is larger, BUT:

* filesystem still old size

Example:

| Layer      | Size  |
| ---------- | ----- |
| Partition  | 30GiB |
| Filesystem | 10GiB |

---

# Step 4: expand filesystem

For ext4:

```bash id="expand019"
sudo resize2fs /dev/sdb3
```

Important:

* no size specified
* automatically grows to maximum partition size

---

# final result

Now:

| Layer      | Size  |
| ---------- | ----- |
| Partition  | 30GiB |
| Filesystem | 30GiB |

---

# Important ext4 advantage

Ext4 supports:

* online growth

Meaning:

* filesystem may remain mounted while expanding

Example:

```bash id="expand020"
sudo resize2fs /dev/sdb3
```

often works while mounted.

---

# Shrinking vs growing comparison

| Operation | Order                  |
| --------- | ---------------------- |
| Shrink    | filesystem → partition |
| Grow      | partition → filesystem |

---

# important filesystem limitations

## ext4

Supports:

* grow
* shrink

---

## XFS

Supports:

* grow only

Expansion command:

```bash id="expand021"
sudo xfs_growfs /mountpoint
```

NOT:

```text id="expand022"
resize2fs
```

---

## Btrfs

Supports:

* online resize
* shrink/grow

---

# verify sizes

## lsblk

```bash id="expand023"
lsblk
```

---

## filesystem usage

```bash id="expand024"
df -h
```

---

## detailed partition table

```bash id="expand025"
sudo fdisk -l
```

---

# Important safety notes

## ALWAYS backup important data first

Partition operations are dangerous.

---

## NEVER interrupt resizing

Power loss during resize:

* may corrupt filesystem

---

## Be careful with correct partition names

Example mistake:

```text id="expand026"
/dev/sdb2
```

vs:

```text id="expand027"
/dev/sdb3
```

wrong target can destroy data.

---

# graphical alternative

GParted can automate:

* partition growth
* filesystem growth

But CLI understanding is important professionally.

---

# practical workflow example

## enlarge partition

```bash id="expand028"
sudo parted /dev/sdb
```

Inside:

```bash id="expand029"
(parted) resizepart
(parted) quit
```

---

## grow filesystem

```bash id="expand030"
sudo resize2fs /dev/sdb3
```

---

## verify

```bash id="expand031"
df -h
```

---

# useful commands summary

Open parted:

```bash id="expand032"
sudo parted /dev/sdb
```

Show partitions:

```bash id="expand033"
(parted) print
```

Create partition:

```bash id="expand034"
(parted) mkpart primary ext4 20GiB 30GiB
```

Resize partition:

```bash id="expand035"
(parted) resizepart
```

Format ext4:

```bash id="expand036"
sudo mkfs.ext4 /dev/sdb3
```

Create mount point:

```bash id="expand037"
sudo mkdir -p /mnt/data
```

Mount:

```bash id="expand038"
sudo mount /dev/sdb3 /mnt/data
```

Grow filesystem:

```bash id="expand039"
sudo resize2fs /dev/sdb3
```

Show block devices:

```bash id="expand040"
lsblk
```

Show filesystem usage:

```bash id="expand041"
df -h
```
