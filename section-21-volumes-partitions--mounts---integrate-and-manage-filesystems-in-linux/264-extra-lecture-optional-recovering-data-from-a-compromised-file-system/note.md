# 264. Extra Lecture: Recovering Data from a Compromised File System

## very important warning

This lecture is dangerous.

Commands like:

```bash
dd if=/dev/urandom of=/dev/sdb1
```

can permanently destroy data.

Do NOT run this on:

* your real laptop disk
* your main Ubuntu system
* external drives
* USB drives with important files

Only practice on:

* a disposable VM disk
* a test partition
* a disk you are 100% sure you can destroy

---

## goal of the lecture

We intentionally:

1. damage a filesystem
2. fail to mount it
3. repair it using `fsck`
4. recover whatever data is still available

---

## starting point

Assume we have a test partition mounted at:

```text
/mnt/backups
```

Example:

```bash
cd /mnt/backups
ls
```

Maybe it contains:

```text
Downloads/
```

or some ISO files.

---

# Step 1: unmount the filesystem

Before damaging or repairing a filesystem, unmount it:

```bash
sudo umount /mnt/backups
```

Verify:

```bash
mount | grep backups
```

No output means it is unmounted.

---

# Step 2: damage the filesystem

Dangerous command:

```bash
sudo dd bs=1M count=10 if=/dev/urandom of=/dev/sdb1
```

Meaning:

```text
bs=1M
```

write in blocks of 1 MiB.

```text
count=10
```

write 10 blocks.

So total damage:

```text
10 MiB
```

```text
if=/dev/urandom
```

input is random data.

```text
of=/dev/sdb1
```

output is the target partition.

---

## what this destroys

This overwrites the beginning of the partition, which may contain:

* filesystem superblock
* metadata
* journal
* directory structures
* allocation information

That is why the filesystem may no longer mount.

---

# Step 3: try mounting again

```bash
sudo mount /dev/sdb1 /mnt/backups
```

Expected result:

* mount may fail
* filesystem may be reported as corrupted

---

# Step 4: repair with fsck

Run:

```bash
sudo fsck /dev/sdb1
```

or for ext4:

```bash
sudo fsck.ext4 /dev/sdb1
```

If many repair prompts appear, you can press:

```text
a
```

meaning:

* answer yes to all questions

Alternative:

```bash
sudo fsck -y /dev/sdb1
```

---

# Step 5: mount again

```bash
sudo mount /dev/sdb1 /mnt/backups
```

If repair succeeded, it should mount.

---

# Step 6: check recovered data

```bash
ls /mnt/backups
```

Look for:

```text
lost+found
```

---

# what is `lost+found`?

`lost+found` is a special directory used by ext filesystems.

When `fsck` finds file data without proper directory references, it places recovered fragments there.

Example:

```bash
sudo ls -lah /mnt/backups/lost+found
```

---

# why files go to `lost+found`

A file may still exist on disk, but its filename/path metadata may be damaged.

So `fsck` may recover it as:

```text
#12345
#12346
```

instead of the original name.

---

# how to inspect recovered files

Use:

```bash
file /mnt/backups/lost+found/*
```

Example output:

```text
#12345: ISO 9660 CD-ROM filesystem data
#12346: JPEG image data
#12347: ASCII text
```

Then rename useful files manually.

---

# safer educational alternative

Instead of running dangerous `dd` on a real partition, practice inside a file-backed filesystem:

```bash
mkdir ~/fsck-lab
cd ~/fsck-lab
dd if=/dev/zero of=test.img bs=1M count=100
mkfs.ext4 test.img
mkdir mnt
sudo mount -o loop test.img mnt
echo "hello" | sudo tee mnt/file.txt
sudo umount mnt
```

Then damage only the image file:

```bash
dd if=/dev/urandom of=test.img bs=1M count=1 conv=notrunc
```

Repair:

```bash
fsck.ext4 -f test.img
```

Mount again:

```bash
sudo mount -o loop test.img mnt
```

This is much safer because you are damaging only:

```text
test.img
```

not a real disk partition.

---

# important concept

`fsck` can repair filesystem metadata, but it cannot magically restore overwritten data.

If `dd` overwrites actual file contents:

* that data is gone

If only metadata is damaged:

* some data may be recoverable

---

# professional recovery rule

If data is important:

1. stop using the disk immediately
2. do NOT run repair first
3. make a full image with `ddrescue`
4. repair the copy, not the original

Example:

```bash
sudo ddrescue /dev/sdb1 backup.img rescue.log
```

Then:

```bash
fsck.ext4 -f backup.img
```

---

# useful commands summary

Unmount:

```bash
sudo umount /mnt/backups
```

Damage test partition:

```bash
sudo dd bs=1M count=10 if=/dev/urandom of=/dev/sdb1
```

Repair:

```bash
sudo fsck /dev/sdb1
```

Auto-repair:

```bash
sudo fsck -y /dev/sdb1
```

Mount:

```bash
sudo mount /dev/sdb1 /mnt/backups
```

Inspect recovered files:

```bash
sudo ls -lah /mnt/backups/lost+found
```

Check file types:

```bash
file /mnt/backups/lost+found/*
```
