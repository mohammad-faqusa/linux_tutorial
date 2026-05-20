# 277. Dismantling LVM: Safely Removing Logical Volumes and Groups

## important idea

LVM removal must happen in:

```text id="lvmdel001"
reverse order
```

Because architecture is:

```text id="lvmdel002"
PV → VG → LV → Filesystem
```

So deletion happens:

```text id="lvmdel003"
Filesystem/LV → VG → PV
```

---

# VERY IMPORTANT WARNING

Before deleting anything:

* confirm correct disk names
* backup important data
* check mounts carefully

LVM removal permanently destroys data.

---

# Step 1: check mounted filesystems

```bash id="lvmdel004"
sudo df -h
```

or:

```bash id="lvmdel005"
mount | grep vgroup
```

---

# VERY IMPORTANT

Before removing an LV:

```text id="lvmdel006"
filesystem must be unmounted
```

and:

```text id="lvmdel007"
/etc/fstab
```

entries should be removed if they exist.

Otherwise:

* boot issues may occur later.

---

# Step 2: unmount filesystem

Example:

```bash id="lvmdel008"
sudo umount /dev/vgroup/data
```

or:

```bash id="lvmdel009"
sudo umount /mnt/data
```

---

# Step 3: remove Logical Volume

## remove `data`

```bash id="lvmdel010"
sudo lvremove /dev/vgroup/data
```

LVM asks confirmation:

```text id="lvmdel011"
Do you really want to remove active logical volume?
```

Type:

```text id="lvmdel012"
y
```

---

# verify remaining LVs

```bash id="lvmdel013"
sudo lvs
```

---

# remove another LV

Example:

```bash id="lvmdel014"
sudo lvremove /dev/vgroup/backups
```

---

# important concept

A VG cannot be removed while:

```text id="lvmdel015"
Logical Volumes still exist
```

---

# Step 4: inspect Volume Groups

```bash id="lvmdel016"
sudo vgs
```

---

# Step 5: remove Volume Group

```bash id="lvmdel017"
sudo vgremove vgroup
```

Meaning:

* destroy VG metadata
* detach PV pool structure

---

# verify removal

```bash id="lvmdel018"
sudo vgs
```

Should no longer show:

```text id="lvmdel019"
vgroup
```

---

# Step 6: inspect Physical Volumes

```bash id="lvmdel020"
sudo pvs
```

PVs still contain:

```text id="lvmdel021"
LVM metadata
```

even after VG deletion.

---

# Step 7: remove Physical Volumes

Example:

```bash id="lvmdel022"
sudo pvremove /dev/sdb1
```

Repeat:

```bash id="lvmdel023"
sudo pvremove /dev/sdd1
sudo pvremove /dev/sde1
```

---

# what `pvremove` does

Removes:

* LVM metadata
* UUIDs
* extent information

Partition becomes:

```text id="lvmdel024"
normal partition again
```

---

# after full dismantling

Disk layout becomes:

```text id="lvmdel025"
Partitions remain
BUT
no LVM structures exist
```

You may then:

* delete partitions
* reformat
* reuse disks
* create new filesystems

---

# important verification commands

## show LVs

```bash id="lvmdel026"
sudo lvs
```

---

## show VGs

```bash id="lvmdel027"
sudo vgs
```

---

## show PVs

```bash id="lvmdel028"
sudo pvs
```

---

# common cleanup after removal

## remove mount directories

Example:

```bash id="lvmdel029"
sudo rmdir /mnt/data
```

---

## clean `/etc/fstab`

Edit:

```bash id="lvmdel030"
sudo nano /etc/fstab
```

Remove old LVM mount entries.

---

# VERY IMPORTANT boot warning

If root filesystem uses LVM:

```text id="lvmdel031"
DO NOT remove VG/PVs blindly
```

You could destroy the operating system.

Your current practice is safe because:

* you are using separate test disks in VirtualBox.

Good learning approach.

---

# complete removal flow

```text id="lvmdel032"
Unmount filesystem
→ lvremove
→ vgremove
→ pvremove
```

---

# architecture after deletion

Before:

```text id="lvmdel033"
PV → VG → LV → ext4
```

After:

```text id="lvmdel034"
partition only
```

---

# professional insight

LVM removal is intentionally:

* layered
* dependency-aware

Linux prevents:

* removing lower layers while upper layers still depend on them

similar to:

* object dependency graphs
* container storage layers
* infrastructure orchestration concepts

---

# useful commands summary

Check mounts:

```bash id="lvmdel035"
df -h
```

Unmount:

```bash id="lvmdel036"
sudo umount /dev/vgroup/data
```

Show LVs:

```bash id="lvmdel037"
sudo lvs
```

Remove LV:

```bash id="lvmdel038"
sudo lvremove /dev/vgroup/data
```

Show VGs:

```bash id="lvmdel039"
sudo vgs
```

Remove VG:

```bash id="lvmdel040"
sudo vgremove vgroup
```

Show PVs:

```bash id="lvmdel041"
sudo pvs
```

Remove PV:

```bash id="lvmdel042"
sudo pvremove /dev/sdb1
```

Inspect block devices:

```bash id="lvmdel043"
lsblk
```

Edit fstab:

```bash id="lvmdel044"
sudo nano /etc/fstab
```
