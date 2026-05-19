# 262. Ensuring Data Integrity: File System Checks

## what is `fsck`?

`fsck` stands for:

```text id="fsck001"
File System Consistency Check
```

used to:

* detect filesystem corruption
* repair filesystem inconsistencies
* recover metadata problems

similar concept to:

```text id="fsck002"
chkdsk
```

on Windows.

---

# why filesystems become corrupted

common causes:

## unexpected shutdown

examples:

* power loss
* battery drain
* forced power off

filesystem operations may be interrupted.

---

## filesystem driver bugs

rare, but possible.

---

## failing storage hardware

examples:

* bad SSD blocks
* HDD bad sectors
* controller issues

SMART may help detect this earlier.

---

## kernel crashes

can interrupt writes.

---

## cable/controller problems

especially on older SATA systems.

---

# important practical idea

## regular filesystem checks help prevent data loss

checking early:

* can detect corruption
* repair metadata
* prevent larger damage

---

# VERY important rule

## NEVER fsck a mounted writable filesystem

bad:

```bash id="fsck003"
sudo fsck /dev/sdb1
```

while mounted.

This can:

* worsen corruption
* destroy filesystem metadata

---

# correct workflow

## first: unmount filesystem

```bash id="fsck004"
sudo umount /dev/sdb1
```

or:

```bash id="fsck005"
sudo umount /mnt/data
```

---

## then run fsck

```bash id="fsck006"
sudo fsck /dev/sdb1
```

---

# specifying filesystem type

sometimes required.

example:

```bash id="fsck007"
sudo fsck.ext4 /dev/sdb1
```

other examples:

```bash id="fsck008"
sudo fsck.xfs /dev/sdb1
```

```bash id="fsck009"
sudo fsck.btrfs /dev/sdb1
```

---

# important filesystem-specific behavior

## ext4

supports:

```text id="fsck010"
fsck.ext4
```

fully repairable offline.

---

## XFS

IMPORTANT:

* XFS does NOT use normal fsck repair.

Instead:

```bash id="fsck011"
sudo xfs_repair /dev/sdb1
```

---

## Btrfs

uses:

```bash id="fsck012"
sudo btrfs check
```

---

# example workflow

## mounted filesystem

check:

```bash id="fsck013"
mount | grep sdb1
```

---

## unmount

```bash id="fsck014"
sudo umount /dev/sdb1
```

---

## run repair

```bash id="fsck015"
sudo fsck.ext4 /dev/sdb1
```

---

# automatic fixes

## interactive mode

default:

* asks before fixing issues.

---

## automatic yes

```bash id="fsck016"
sudo fsck -y /dev/sdb1
```

automatically answers:

```text id="fsck017"
yes
```

to repair prompts.

Be careful:

* automated repairs may remove damaged entries.

---

# checking the root filesystem `/`

problem:

```text id="fsck018"
/ is mounted while system is running
```

cannot safely fsck it live.

---

# method 1: force fsck on boot

## GRUB kernel parameter

during boot:

* open GRUB menu
* press:

```text id="fsck019"
e
```

edit kernel line.

Add:

```text id="fsck020"
fsck.mode=force
```

example:

```text id="fsck021"
linux ... ro quiet splash fsck.mode=force
```

then boot with:

```text id="fsck022"
F10
```

or:

```text id="fsck023"
Ctrl+X
```

---

# what happens

during next boot:

* system performs forced filesystem check
* before mounting root fully

---

# if GRUB menu hidden

Ubuntu often hides GRUB menu.

Common ways to show it:

* hold:

```text id="fsck024"
Shift
```

(BIOS systems)

or:

```text id="fsck025"
Esc
```

(UEFI systems)

during boot.

---

# verify fsck happened

after boot:

```bash id="fsck026"
journalctl -b | grep fsck
```

or:

```bash id="fsck027"
journalctl -b | grep "File System"
```

---

# method 2: live USB / rescue environment

very important recovery technique.

Boot:

* live Linux USB
* rescue system
* recovery ISO

then:

* target filesystem is NOT mounted

safe to repair.

---

# typical rescue workflow

## boot live Linux

---

## identify partitions

```bash id="fsck028"
lsblk
```

---

## run fsck

```bash id="fsck029"
sudo fsck.ext4 /dev/sda2
```

---

# forcing fsck with filesystem flags

another method:

```bash id="fsck030"
sudo touch /forcefsck
```

older systems may honor this at boot.

Less common now with modern systemd.

---

# checking mount status

before fsck:

```bash id="fsck031"
mount
```

or:

```bash id="fsck032"
lsblk -f
```

---

# repairing severely damaged filesystems

sometimes:

* filesystem mounted read-only automatically.

kernel may log:

```text id="fsck033"
EXT4-fs error
Remounting filesystem read-only
```

Then:

1. boot rescue/live environment
2. unmount filesystem
3. run fsck

---

# important distinction

| Tool          | Purpose                |
| ------------- | ---------------------- |
| SMART         | physical drive health  |
| fsck          | filesystem consistency |
| fdisk/gparted | partitions             |
| mount         | attaching filesystems  |

---

# examples of problems fsck can repair

* orphaned inodes
* journal inconsistencies
* invalid metadata
* directory corruption
* allocation bitmap issues

---

# examples fsck cannot repair

* deleted user files
* physically destroyed NAND cells
* dead SSD controller
* overwritten data

---

# dangerous mistake

NEVER run:

```bash id="fsck034"
sudo fsck /dev/sda1
```

blindly on your system partition while running Linux.

Always confirm:

* target partition
* mount state

first.

---

# useful commands summary

install tools:

```bash id="fsck035"
sudo apt install util-linux
```

check mounts:

```bash id="fsck036"
mount
```

show block devices:

```bash id="fsck037"
lsblk
```

unmount filesystem:

```bash id="fsck038"
sudo umount /dev/sdb1
```

run fsck:

```bash id="fsck039"
sudo fsck /dev/sdb1
```

ext4 specific:

```bash id="fsck040"
sudo fsck.ext4 /dev/sdb1
```

automatic repair:

```bash id="fsck041"
sudo fsck -y /dev/sdb1
```

view boot logs:

```bash id="fsck042"
journalctl -b
```

grep fsck logs:

```bash id="fsck043"
journalctl -b | grep fsck
```
