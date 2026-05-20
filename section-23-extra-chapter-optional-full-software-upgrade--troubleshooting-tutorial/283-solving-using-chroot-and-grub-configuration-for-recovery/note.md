# 283. Solving Boot Problems using `chroot` and GRUB Recovery

# important concept

This lecture introduces one of the MOST important Linux recovery tools:

```text id="chroot001"
chroot
```

This is real Linux administrator knowledge.

---

# what is `chroot` REALLY?

`chroot` means:

```text id="chroot002"
change root directory
```

It changes:

```text id="chroot003"
what "/" means
```

for a process.

---

# normal situation

Normally:

```text id="chroot004"
/ = current running Linux system
```

Example:

```text id="chroot005"
/bin
/etc
/dev
```

belong to:

```text id="chroot006"
live USB system
```

---

# after chroot

Suppose broken system mounted at:

```text id="chroot007"
/media/ubuntu/rootdisk
```

After:

```bash id="chroot008"
sudo chroot /media/ubuntu/rootdisk
```

Now:

```text id="chroot009"
/ = broken installed Linux system
```

VERY important concept.

---

# what chroot allows

You can:

* run commands
* edit configs
* reinstall packages
* regenerate GRUB
* rebuild initramfs

AS IF:

```text id="chroot010"
you booted normally into installed system
```

even though:

* system itself cannot boot.

---

# important clarification

`chroot` does NOT:

* boot another Linux kernel
* start another operating system

It simply:

```text id="chroot011"
changes filesystem root context
```

for processes.

---

# practical workflow

---

# Step 1: boot live Ubuntu

Choose:

```text id="chroot012"
Try Ubuntu
```

---

# Step 2: locate installed system

Example:

```bash id="chroot013"
lsblk
```

Suppose root partition:

```text id="chroot014"
/dev/sda2
```

---

# Step 3: mount installed system

```bash id="chroot015"
sudo mount /dev/sda2 /mnt
```

Now installed system accessible under:

```text id="chroot016"
/mnt
```

---

# Step 4: enter chroot

```bash id="chroot017"
sudo chroot /mnt
```

Now:

```text id="chroot018"
commands operate inside installed Linux
```

---

# GRUB configuration recovery

Edit:

```bash id="chroot019"
nano /etc/default/grub
```

Common settings:

---

# show GRUB menu

Comment/remove hidden menu:

```text id="chroot020"
#GRUB_HIDDEN_TIMEOUT
```

---

# set timeout

```text id="chroot021"
GRUB_TIMEOUT=5
```

Gives:

* visible boot menu
* time to choose older kernels

VERY useful for recovery.

---

# why `update-grub` initially failed

Inside chroot:

* `/dev`
* `/proc`
* `/sys`

were missing/incomplete.

These directories are VERY special.

---

# IMPORTANT understanding

These are NOT normal stored filesystems.

| Directory | Purpose                  |
| --------- | ------------------------ |
| `/dev`    | device nodes             |
| `/proc`   | process/kernel interface |
| `/sys`    | kernel/sysfs interface   |

---

# why chroot alone is insufficient

When entering chroot:

* filesystem exists
  BUT:
* kernel interfaces missing

So tools like:

```text id="chroot022"
update-grub
```

cannot properly:

* detect disks
* detect partitions
* detect kernels

---

# solution: bind mounts

Very important Linux recovery technique.

---

# bind `/dev`

```bash id="chroot023"
sudo mount --bind /dev /mnt/dev
```

Makes:

```text id="chroot024"
live system devices visible inside chroot
```

---

# bind `/proc`

```bash id="chroot025"
sudo mount --bind /proc /mnt/proc
```

---

# bind `/sys`

```bash id="chroot026"
sudo mount --bind /sys /mnt/sys
```

---

# VERY important recovery pattern

This is standard Linux recovery methodology:

```text id="chroot027"
mount root partition
↓
bind /dev /proc /sys
↓
chroot
↓
repair system
```

You will see this repeatedly in:

* Ubuntu recovery
* Arch recovery
* server rescue
* cloud VM repair

---

# after bind mounts

Now commands work correctly:

```bash id="chroot028"
update-grub
```

Because:

* disk devices visible
* kernel interfaces available

---

# reboot recovery

After fixing:

1. exit chroot
2. reboot
3. remove USB ISO
4. boot installed system

---

# choosing older kernel

GRUB menu:

```text id="chroot029"
Advanced options for Ubuntu
```

Select:

* older working kernel

Very common temporary recovery strategy.

---

# forcing working kernel as default

Inspect kernel entries:

```bash id="chroot030"
nano /boot/grub/grub.cfg
```

Find:

```text id="chroot031"
exact kernel menu entry name
```

---

# set GRUB default

Edit:

```bash id="chroot032"
nano /etc/default/grub
```

Example:

```text id="chroot033"
GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 6.x.x"
```

---

# regenerate GRUB config

```bash id="chroot034"
sudo update-grub
```

Now:

```text id="chroot035"
working kernel boots automatically
```

---

# important professional insight

This is exactly how many production Linux recoveries happen.

Especially:

* VPS recovery
* AWS rescue mode
* broken kernel upgrades
* bootloader corruption

---

# critical conceptual understanding

The kernel that failed:

```text id="chroot036"
still exists on disk
```

The system itself often:

* not destroyed
* only boot path broken

This is why Linux recovery is often possible.

---

# mental model of recovery

```text id="chroot037"
Live Linux
↓
mount broken Linux
↓
borrow kernel interfaces
↓
enter broken system using chroot
↓
repair boot configuration
```

This is the BIG idea.

---

# why this lecture is extremely valuable

Many Linux users:

* can install Linux
  BUT:
* cannot recover broken systems

Recovery knowledge dramatically increases:

* Linux confidence
* troubleshooting ability
* infrastructure skills

---

# important commands summary

Show disks:

```bash id="chroot038"
lsblk
```

Mount installed system:

```bash id="chroot039"
sudo mount /dev/sda2 /mnt
```

Bind special filesystems:

```bash id="chroot040"
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
```

Enter chroot:

```bash id="chroot041"
sudo chroot /mnt
```

Edit GRUB config:

```bash id="chroot042"
nano /etc/default/grub
```

Regenerate GRUB:

```bash id="chroot043"
sudo update-grub
```

Inspect GRUB entries:

```bash id="chroot044"
nano /boot/grub/grub.cfg
```

Reboot:

```bash id="chroot045"
sudo reboot
```
