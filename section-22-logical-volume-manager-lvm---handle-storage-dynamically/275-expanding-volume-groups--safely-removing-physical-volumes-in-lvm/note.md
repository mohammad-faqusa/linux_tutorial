# 275. Expanding Volume Groups & Safely Removing Physical Volumes in LVM

# adding a Physical Volume (PV) to a Volume Group (VG)

One of the biggest advantages of LVM:

```text id="lvmadd001"
storage can grow dynamically
```

without rebuilding the entire filesystem structure.

---

# scenario

Suppose:

```text id="lvmadd002"
vgroup
```

already contains:

```text id="lvmadd003"
/dev/sdb1
/dev/sdc1
/dev/sdd1
```

Now we add another disk:

```text id="lvmadd004"
/dev/sde
```

---

# Step 1: create partition table

```bash id="lvmadd005"
sudo parted /dev/sde
```

Inside parted:

```bash id="lvmadd006"
(parted) mklabel gpt
```

---

# Step 2: create partition

```bash id="lvmadd007"
(parted) mkpart primary 0% 100%
```

---

# Step 3: mark as LVM

```bash id="lvmadd008"
(parted) set 1 lvm on
```

---

# Step 4: quit parted

```bash id="lvmadd009"
(parted) quit
```

---

# Step 5: initialize Physical Volume

```bash id="lvmadd010"
sudo pvcreate /dev/sde1
```

Now:

```text id="lvmadd011"
/dev/sde1
```

became:

```text id="lvmadd012"
LVM Physical Volume
```

---

# Step 6: extend the Volume Group

```bash id="lvmadd013"
sudo vgextend vgroup /dev/sde1
```

Meaning:

* add new PV into:

```text id="lvmadd014"
vgroup
```

---

# verify result

## show PVs

```bash id="lvmadd015"
sudo pvs
```

---

## show VGs

```bash id="lvmadd016"
sudo vgs
```

You should see:

```text id="lvmadd017"
VG size increased
```

---

## show LVs

```bash id="lvmadd018"
sudo lvs
```

Logical volumes remain unchanged until extended manually.

---

# important concept

After `vgextend`:

```text id="lvmadd019"
Volume Group grows
```

BUT:

* Logical Volumes do NOT automatically grow.

You must later use:

```bash
lvextend
resize2fs
```

if you want larger filesystems.

---

# removing a Physical Volume safely

Now suppose we want to remove:

```text id="lvmremove001"
/dev/sdc1
```

from:

```text id="lvmremove002"
vgroup
```

---

# VERY IMPORTANT RULE

You CANNOT remove a PV if:

* extents/data still exist on it.

First:

```text id="lvmremove003"
move data elsewhere
```

---

# Step 1: move extents

```bash id="lvmremove004"
sudo pvmove -v /dev/sdc1
```

---

# what does `pvmove` do?

LVM:

* transparently migrates extents
* from one PV to others inside VG

Applications/filesystems:

```text id="lvmremove005"
do not notice this movement
```

Filesystem stays mounted and operational.

Very powerful feature.

---

# `-v`

```text id="lvmremove006"
verbose mode
```

prints detailed progress.

---

# IMPORTANT requirement

You must have:

```text id="lvmremove007"
enough free space
```

inside the Volume Group.

Otherwise:

* no destination extents available.

---

# verify free space

```bash id="lvmremove008"
sudo vgs
```

Look at:

```text id="lvmremove009"
VFree
```

---

# Step 2: remove PV from VG

After successful `pvmove`:

```bash id="lvmremove010"
sudo vgreduce vgroup /dev/sdc1
```

Meaning:

* remove PV membership from:

```text id="lvmremove011"
vgroup
```

---

# Step 3: remove LVM metadata

Finally:

```bash id="lvmremove012"
sudo pvremove /dev/sdc1
```

Meaning:

* erase LVM metadata
* partition no longer an LVM PV

---

# after pvremove

Partition may be:

* reused
* reformatted
* deleted
* repurposed

---

# Important conceptual understanding

## `pvmove`

moves:

```text id="lvmremove013"
physical extents
```

NOT:

* files directly

LVM handles relocation internally.

---

# Huge enterprise advantage

This allows:

* replacing failing disks
* migrating storage
* expanding systems
* removing hardware

while:

```text id="lvmremove014"
systems remain online
```

Very powerful.

---

# practical workflow example

## add disk

```bash id="lvmworkflow001"
sudo pvcreate /dev/sde1
sudo vgextend vgroup /dev/sde1
```

---

## remove old disk

```bash id="lvmworkflow002"
sudo pvmove -v /dev/sdc1
sudo vgreduce vgroup /dev/sdc1
sudo pvremove /dev/sdc1
```

---

# useful inspection commands

## show PVs

```bash id="lvminspect001"
sudo pvs
```

---

## show VGs

```bash id="lvminspect002"
sudo vgs
```

---

## show LVs

```bash id="lvminspect003"
sudo lvs
```

---

## detailed display

```bash id="lvminspect004"
sudo pvdisplay
sudo vgdisplay
sudo lvdisplay
```

---

# important professional insight

LVM provides:

```text id="lvminspect005"
storage virtualization
```

similar idea to:

* cloud storage pools
* SAN systems
* enterprise virtualization

This is why LVM knowledge is highly valuable.

---

# common enterprise pattern

```text id="lvminspect006"
Add new disk
→ pvcreate
→ vgextend
→ lvextend
→ resize filesystem
```

all done:

```text id="lvminspect007"
without reinstalling system
```

---

# useful commands summary

Create PV:

```bash id="lvmsummary001"
sudo pvcreate /dev/sde1
```

Extend VG:

```bash id="lvmsummary002"
sudo vgextend vgroup /dev/sde1
```

Move extents:

```bash id="lvmsummary003"
sudo pvmove -v /dev/sdc1
```

Reduce VG:

```bash id="lvmsummary004"
sudo vgreduce vgroup /dev/sdc1
```

Remove PV metadata:

```bash id="lvmsummary005"
sudo pvremove /dev/sdc1
```

Show PVs:

```bash id="lvmsummary006"
sudo pvs
```

Show VGs:

```bash id="lvmsummary007"
sudo vgs
```

Show LVs:

```bash id="lvmsummary008"
sudo lvs
```
