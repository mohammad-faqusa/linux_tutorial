# 278. CentOS Boot Process with LVM Integration

## important question

Can Linux boot directly from:

```text id="bootlvm001"
LVM volumes?
```

Answer:

```text id="bootlvm002"
Yes, but with limitations and special requirements
```

---

# why booting from LVM is more complicated

During early boot:

* firmware and bootloader start first
* before full Linux kernel is loaded

At this stage:

* system has very limited drivers/modules available

So:

```text id="bootlvm003"
bootloader must understand LVM
```

and:

```text id="bootlvm004"
kernel/initramfs must support LVM
```

---

# important requirements

## bootloader support

Common supported bootloader:

```text id="bootlvm005"
GRUB 2
```

Older/simple bootloaders may not fully support:

* LVM metadata
* logical volume discovery

---

# kernel support

Linux kernel/initramfs must contain:

```text id="bootlvm006"
LVM modules/tools
```

so it can:

* activate VGs
* discover LVs
* mount root filesystem

---

# important practical limitation

Some advanced LVM features:

* thin provisioning
* snapshots
* certain RAID modes

may complicate early boot support.

That is why:

```text id="bootlvm007"
simple LVM layouts are safest for root filesystems
```

---

# typical modern Linux approach

Best/common setup:

```text id="bootlvm008"
Small normal boot partition
→ kernel + initramfs stored there
→ rest of system inside LVM
```

---

# Why separate /boot exists

At power-on:

* GRUB must access:

  * kernel
  * initramfs

before full LVM stack activated.

Thus:

```text id="bootlvm009"
/boot often lives on normal partition
```

not inside complicated LVM setup.

---

# typical CentOS/RHEL layout

Example:

```text id="bootlvm010"
/dev/sda1   EFI System Partition
/dev/sda2   /boot
/dev/sda3   LVM PV
```

Inside LVM:

```text id="bootlvm011"
VG → root LV
VG → home LV
VG → swap LV
```

Very common enterprise design.

---

# boot sequence with LVM

# Step 1: firmware

BIOS/UEFI starts system.

---

# Step 2: EFI partition

EFI loads:

```text id="bootlvm012"
GRUB 2
```

EFI partition usually:

* FAT32
* small partition

---

# Step 3: GRUB loads kernel

Kernel files stored in:

```text id="bootlvm013"
/boot
```

Examples:

```text id="bootlvm014"
vmlinuz
initramfs
```

---

# Step 4: initramfs starts

Very important stage.

`initramfs` contains:

* temporary minimal Linux environment
* storage drivers
* LVM tools/modules

---

# Step 5: activate LVM

Initramfs:

* scans PVs
* activates VGs
* discovers LVs

Commands conceptually similar to:

```bash id="bootlvm015"
vgscan
vgchange -ay
```

---

# Step 6: mount root filesystem

Now root LV becomes available:

Example:

```text id="bootlvm016"
/dev/mapper/vg-root
```

mounted as:

```text id="bootlvm017"
/
```

---

# Step 7: switch to real root

System leaves initramfs environment and continues normal boot.

---

# inspecting your current CentOS/Ubuntu setup

## open GParted

```bash id="bootlvm018"
sudo gparted
```

You may see:

| Partition | Purpose           |
| --------- | ----------------- |
| EFI       | bootloader        |
| /boot     | kernels/initramfs |
| LVM PV    | main system       |

---

# important directories

## `/boot`

Contains:

* kernel images
* initramfs
* GRUB files

---

# common files

## kernel

```text id="bootlvm019"
vmlinuz
```

compressed Linux kernel.

---

## initramfs

```text id="bootlvm020"
initramfs
```

temporary early boot filesystem.

---

# inspect `/boot`

```bash id="bootlvm021"
ls /boot
```

You may see:

```text id="bootlvm022"
vmlinuz-...
initrd.img-...
grub/
```

---

# important concept

## `/boot` is often outside LVM

Because:

* bootloader can read it easily

while:

```text id="bootlvm023"
main system may reside entirely in LVM
```

---

# root filesystem on LVM

Example:

```text id="bootlvm024"
/dev/mapper/centos-root
```

or:

```text id="bootlvm025"
/dev/vgroup/root
```

---

# inspect LVM mappings

```bash id="bootlvm026"
lsblk
```

or:

```bash id="bootlvm027"
sudo lvs
```

---

# important role of initramfs

Without initramfs:

* kernel may not know how to access LVM root

System would fail to boot.

---

# regenerate initramfs (advanced)

Ubuntu:

```bash id="bootlvm028"
sudo update-initramfs -u
```

CentOS/RHEL:

```bash id="bootlvm029"
sudo dracut -f
```

---

# common enterprise setup

Very common:

```text id="bootlvm030"
EFI partition
→ /boot partition
→ LVM for everything else
```

Advantages:

* flexible storage
* dynamic resizing
* snapshots
* easier management

---

# why not place everything in LVM?

Technically possible sometimes, BUT:

* increases boot complexity
* recovery harder
* bootloader compatibility issues

Thus:

```text id="bootlvm031"
separate /boot remains common best practice
```

---

# useful commands summary

Open GParted:

```bash id="bootlvm032"
sudo gparted
```

Show partitions/LVM:

```bash id="bootlvm033"
lsblk
```

Show logical volumes:

```bash id="bootlvm034"
sudo lvs
```

Show volume groups:

```bash id="bootlvm035"
sudo vgs
```

Inspect boot directory:

```bash id="bootlvm036"
ls /boot
```

Show mounted filesystems:

```bash id="bootlvm037"
df -h
```

Show kernel version:

```bash id="bootlvm038"
uname -r
```

Regenerate initramfs (Ubuntu):

```bash id="bootlvm039"
sudo update-initramfs -u
```

Regenerate initramfs (CentOS):

```bash id="bootlvm040"
sudo dracut -f
```
