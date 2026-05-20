# 282. Troubleshooting: Identifying Kernel Issues & Facilitating Data Backup

# important mindset

When Linux fails to boot:

```text id="trouble001"
DO NOT panic immediately
```

This is one of the most important Linux administration skills.

Very often:

```text id="trouble002"
the data is still safe
```

even if:

* system cannot boot.

---

# first principle of troubleshooting

## identify WHICH stage failed

Remember boot chain:

```text id="trouble003"
BIOS/UEFI
↓
GRUB
↓
Kernel
↓
initramfs
↓
Root filesystem
↓
systemd
↓
Desktop/Login
```

We must determine:

```text id="trouble004"
which layer breaks
```

---

# observed behavior

## GRUB menu appears

This means:

```text id="trouble005"
bootloader works
```

So:

* EFI partition likely OK
* GRUB installation likely OK

---

# failure happens AFTER selecting Ubuntu

Example messages:

```text id="trouble006"
Loading Linux kernel...
```

then crash/freeze.

This strongly suggests:

```text id="trouble007"
kernel/initramfs problem
```

not GRUB itself.

---

# very important observation

## older kernel still works

This is HUGE information.

Because:

* hardware works
* filesystem probably works
* GRUB works
* operating system mostly intact

Most likely:

```text id="trouble008"
new kernel broken
```

or:

```text id="trouble009"
new initramfs broken
```

---

# why old kernel boots successfully

Linux usually keeps:

```text id="trouble010"
multiple kernel versions
```

installed.

GRUB menu allows selecting:

* current kernel
* older kernels

This is extremely valuable recovery mechanism.

---

# why kernel upgrades sometimes fail

Possible causes:

* incompatible drivers
* broken DKMS modules
* bad NVIDIA drivers
* corrupted initramfs
* interrupted upgrade
* missing modules

---

# VERY important emotional skill

Course says:

```text id="trouble011"
stay calm
```

This is actually realistic professional advice.

Because:

* panic causes destructive commands
* stress reduces reasoning ability

Good troubleshooting requires:

```text id="trouble012"
systematic thinking
```

---

# if GRUB menu was NOT enabled

Then recovery becomes harder.

Common recovery path:

---

# Step 1: download live Linux ISO

Usually:

* Ubuntu Live Desktop
* rescue image

---

# Step 2: create bootable USB

IMPORTANT:

```text id="trouble013"
copying ISO file normally is NOT enough
```

USB must become:

```text id="trouble014"
bootable device
```

---

# common tools

Linux:

```bash id="trouble015"
dd
```

Windows:

* Rufus
* Balena Etcher

---

# Example dd command

VERY dangerous if wrong device selected.

```bash id="trouble016"
sudo dd if=ubuntu.iso of=/dev/sdX bs=4M status=progress
```

Where:

* `if=` input file
* `of=` output device

---

# IMPORTANT WARNING

Wrong `/dev/sdX`:

```text id="trouble017"
can destroy another disk
```

Always verify carefully with:

```bash id="trouble018"
lsblk
```

---

# Step 3: boot from USB/DVD

BIOS/UEFI boot order:

* USB/DVD first

Then:

```text id="trouble019"
Live Linux environment starts
```

---

# why live system is powerful

Because:

* it runs independently from broken OS
* broken disks can still be accessed

Allows:

* backup files
* repair GRUB
* repair filesystem
* reinstall kernel
* chroot recovery

---

# VirtualBox workflow

## attach ISO

VirtualBox:

```text id="trouble020"
Settings → Storage → Optical Drive
```

Attach Ubuntu ISO.

---

# boot order

Set:

```text id="trouble021"
CD/DVD before hard disk
```

---

# boot into live Ubuntu

Choose:

```text id="trouble022"
Try Ubuntu
```

NOT:

```text id="trouble023"
Install Ubuntu
```

---

# filesystem inspection

## open GParted

```bash id="trouble024"
sudo gparted
```

Used to:

* inspect partitions
* detect corruption
* mount drives

---

# filesystem repair

Example:

```bash id="trouble025"
sudo fsck /dev/sde2
```

Checks:

* filesystem consistency
* metadata corruption

---

# important result

If fsck says:

```text id="trouble026"
filesystem clean
```

then:

* storage likely OK
* corruption probably elsewhere

---

# important troubleshooting narrowing

At this point:

| Component  | Status     |
| ---------- | ---------- |
| GRUB       | works      |
| Filesystem | clean      |
| Disk       | accessible |
| Old kernel | works      |
| New kernel | fails      |

Strongly indicates:

```text id="trouble027"
kernel/initramfs issue
```

---

# data backup becomes possible

From live Linux:

* mount broken system
* copy important files

Very important recovery skill.

---

# typical mounting example

```bash id="trouble028"
sudo mount /dev/sda2 /mnt
```

Then access:

```text id="trouble029"
/mnt/home/username
```

---

# why this chapter is realistic

Real production Linux recovery often works exactly like this:

* boot rescue environment
* inspect disks
* mount system
* repair manually

Especially:

* cloud VMs
* VPS servers
* enterprise systems

---

# important recovery principle

When troubleshooting:

```text id="trouble030"
reduce uncertainty layer-by-layer
```

Example reasoning:

| Observation      | Conclusion               |
| ---------------- | ------------------------ |
| GRUB works       | bootloader OK            |
| old kernel boots | hardware mostly OK       |
| fsck clean       | filesystem OK            |
| new kernel fails | kernel/initramfs suspect |

This is proper Linux troubleshooting methodology.

---

# likely next lecture

Probably:

* mount installed system
* use `chroot`
* reinstall/fix kernel
* regenerate initramfs
* update GRUB

Very important recovery skills.

---

# useful commands summary

Show boot devices:

```bash id="trouble031"
lsblk
```

Filesystem check:

```bash id="trouble032"
sudo fsck /dev/sda2
```

Mount partition:

```bash id="trouble033"
sudo mount /dev/sda2 /mnt
```

Open partition GUI:

```bash id="trouble034"
sudo gparted
```

Write ISO to USB:

```bash id="trouble035"
sudo dd if=ubuntu.iso of=/dev/sdX bs=4M status=progress
```

Show mounted filesystems:

```bash id="trouble036"
mount
```

Check disks:

```bash id="trouble037"
df -h
```
