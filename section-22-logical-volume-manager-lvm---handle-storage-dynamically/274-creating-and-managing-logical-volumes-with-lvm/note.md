## 274. Creating and Managing Logical Volumes with LVM

### LVM: Creating Logical Volumes

* after creating a volume group (VG), we can create logical volumes (LVs) on top of it
* logical volumes act like normal partitions

### create a logical volume with fixed size

```bash
sudo lvcreate -L 10G -n data vgroup
```

* `-L`

  * specifies the size
* `10G`

  * logical volume size
* `-n data`

  * logical volume name
* `vgroup`

  * target volume group

---

### create a logical volume using all remaining free space

```bash
sudo lvcreate -l 100%FREE -n backups vgroup
```

* `-l`

  * uses extents instead of direct size
* `100%FREE`

  * allocate all remaining free space in the VG

---

### display logical volumes

```bash
lvs
```

or

```bash
lvdisplay
```

---

### scan for logical volumes

```bash
sudo lvscan
```

* useful if logical volumes are not detected automatically

---

### logical volume device paths

* logical volumes appear under:

```bash
/dev/<volume_group>/<logical_volume>
```

example:

```bash
/dev/vgroup/data
```

---

### create filesystem on logical volume

```bash
sudo mkfs.ext4 /dev/vgroup/data
```

---

### mount logical volume

```bash
sudo mkdir /mnt/vgroup-data
sudo mount /dev/vgroup/data /mnt/vgroup-data
```

---

### create and mount another logical volume

```bash
sudo mkfs.ext4 /dev/vgroup/backups

sudo mkdir -p /mnt/vgroup/backups

sudo mount /dev/vgroup/backups /mnt/vgroup/backups
```

---

### useful structure overview

```text id="zjcdrr"
Physical Volumes (PV)
        ↓
Volume Group (VG)
        ↓
Logical Volumes (LV)
        ↓
Filesystem (ext4/xfs)
        ↓
Mounted Directory
```

---

### important notes

* LVM allows flexible resizing of storage
* logical volumes can later be:

  * extended
  * reduced
  * snapshotted
  * moved between disks
* after creating an LV:

  * create filesystem
  * mount it
  * optionally add it to `/etc/fstab` for persistent mounting
