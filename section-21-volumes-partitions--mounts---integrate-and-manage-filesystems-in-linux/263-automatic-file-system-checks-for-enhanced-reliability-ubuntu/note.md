# 263. Automatic File System Checks for Enhanced Reliability [Ubuntu]

## automatic filesystem checks in Ubuntu

## default Ubuntu behavior

By default:

* Ubuntu does NOT fully check filesystems on every boot.

Instead:

* filesystem checks usually happen only when needed.

---

# dirty bit

## what is the dirty bit?

filesystem metadata contains a flag called:

```text id="autofs001"
dirty bit
```

If set:

* filesystem may not have been cleanly unmounted.

Examples:

* power loss
* crash
* forced shutdown
* battery removal

Then:

* Linux automatically schedules filesystem checking.

---

# clean shutdown

If system shuts down properly:

* filesystem journal remains clean
* fsck usually skipped

especially on:

```text id="autofs002"
ext4 + SSD + modern Ubuntu
```

---

# `/etc/fstab` pass field

Inside:

```text id="autofs003"
/etc/fstab
```

last column:

```text id="autofs004"
<pass>
```

controls automatic fsck order.

---

# example fstab

```text id="autofs005"
UUID=xxxx / ext4 defaults 0 1
```

---

# meaning of pass values

| Value | Meaning                   |
| ----- | ------------------------- |
| 0     | never automatically check |
| 1     | root filesystem           |
| 2     | non-root filesystems      |

---

# examples

## root filesystem

```text id="autofs006"
UUID=abc / ext4 defaults 0 1
```

checked first.

---

## secondary disk

```text id="autofs007"
UUID=xyz /data ext4 defaults 0 2
```

checked after root.

---

## disable automatic fsck

```text id="autofs008"
UUID=xyz /data ext4 defaults 0 0
```

---

# viewing automatic check settings

## time-based checks

```bash id="autofs009"
sudo tune2fs -l /dev/sdb2 | grep -i -F 'check'
```

Shows:

* last check
* maximum check interval

---

# mount-count-based checks

```bash id="autofs010"
sudo tune2fs -l /dev/sdb2 | grep -i -F 'mount'
```

Shows:

* mount count
* maximum mount count before forced fsck

---

# checking root filesystem settings

Example:

```bash id="autofs011"
sudo tune2fs -l /dev/sda2 | grep -i -F 'check'
```

```bash id="autofs012"
sudo tune2fs -l /dev/sda2 | grep -i -F 'mount'
```

For NVMe systems, maybe:

```bash id="autofs013"
sudo tune2fs -l /dev/nvme0n1p2
```

---

# important tune2fs information

## current mount count

example:

```text id="autofs014"
Mount count: 12
```

---

## maximum mount count

example:

```text id="autofs015"
Maximum mount count: 30
```

meaning:

* after 30 mounts:

```text id="autofs016"
forced fsck
```

---

## check interval

example:

```text id="autofs017"
Check interval: 15552000
```

which equals:

```text id="autofs018"
6 months
```

---

# enabling periodic checks

## mount-count-based checking

Force check every:

```text id="autofs019"
30 mounts
```

```bash id="autofs020"
sudo tune2fs -c 30 /dev/sdb2
```

---

# disable mount-count checking

```bash id="autofs021"
sudo tune2fs -c 0 /dev/sdb2
```

---

# time-based checking

Check every:

```text id="autofs022"
6 months
```

```bash id="autofs023"
sudo tune2fs -i 6m /dev/sdb2
```

---

# time interval formats

| Format | Meaning |
| ------ | ------- |
| d      | days    |
| w      | weeks   |
| m      | months  |

Examples:

```bash id="autofs024"
sudo tune2fs -i 30d /dev/sdb2
```

```bash id="autofs025"
sudo tune2fs -i 4w /dev/sdb2
```

```bash id="autofs026"
sudo tune2fs -i 12m /dev/sdb2
```

---

# disable time-based checks

```bash id="autofs027"
sudo tune2fs -i 0 /dev/sdb2
```

---

# practical recommendation

## SSD/NVMe systems

Modern ext4 journaling is very reliable.

Usually:

* aggressive periodic fsck is less necessary.

Common reasonable settings:

* every few months
  or:
* every 30–50 mounts

---

# enterprise/server practice

Servers often:

* rely mainly on journaling
* perform occasional maintenance checks

because:

* large fsck operations may take long time

---

# important filesystem limitation

`tune2fs` mainly works for:

```text id="autofs028"
ext2/ext3/ext4
```

NOT:

* XFS
* Btrfs
* FAT

---

# viewing ext4 filesystem metadata

Full output:

```bash id="autofs029"
sudo tune2fs -l /dev/sdb2
```

Shows:

* UUID
* mount counts
* filesystem state
* journal features
* inode info
* reserved blocks

---

# example useful fields

```text id="autofs030"
Filesystem state: clean
```

good sign.

---

```text id="autofs031"
Last checked:
```

last full fsck date.

---

```text id="autofs032"
Errors behavior:
```

what kernel should do on ext4 errors.

---

# forcing immediate full check next boot

```bash id="autofs033"
sudo tune2fs -C 31 /dev/sdb2
```

If max count is:

```text id="autofs034"
30
```

then next mount triggers fsck.

---

# important distinction

| Mechanism      | Purpose               |
| -------------- | --------------------- |
| Journal replay | quick recovery        |
| fsck           | deep consistency scan |
| SMART          | hardware monitoring   |

---

# modern Linux reality

With:

* SSDs
* ext4 journaling
* clean shutdowns

full fsck is much rarer today than:

* older HDD Linux systems

---

# useful commands summary

show mount/check settings:

```bash id="autofs035"
sudo tune2fs -l /dev/sdb2
```

grep check info:

```bash id="autofs036"
sudo tune2fs -l /dev/sdb2 | grep -i check
```

grep mount info:

```bash id="autofs037"
sudo tune2fs -l /dev/sdb2 | grep -i mount
```

check every 30 mounts:

```bash id="autofs038"
sudo tune2fs -c 30 /dev/sdb2
```

check every 6 months:

```bash id="autofs039"
sudo tune2fs -i 6m /dev/sdb2
```

disable mount checks:

```bash id="autofs040"
sudo tune2fs -c 0 /dev/sdb2
```

disable interval checks:

```bash id="autofs041"
sudo tune2fs -i 0 /dev/sdb2
```

show block devices:

```bash id="autofs042"
lsblk -f
```
