## 256. Advanced Mounting and Permission Configuration for exFAT

# Mount Options Depend on Filesystem

Different filesystems support different features.

Examples:

| Filesystem | Linux Permissions | Users/Groups        | Journaling |
| ---------- | ----------------- | ------------------- | ---------- |
| ext4       | Yes               | Yes                 | Yes        |
| xfs        | Yes               | Yes                 | Yes        |
| exFAT      | No                | No                  | No         |
| FAT32      | No                | No                  | No         |
| NTFS       | Partial           | Limited via drivers | Yes        |

---

# Why exFAT Is Special

exFAT was designed mainly for:

* USB drives
* SD cards
* cross-platform compatibility

Commonly used between:

* Windows
* Linux
* macOS
* cameras
* embedded devices

---

# Important Limitation

exFAT does NOT support native Linux:

* ownership
* users
* groups
* permissions

Unlike ext4:

* metadata is not stored in Linux permission format

Therefore Linux simulates permissions using:

* mount options

---

# Required Packages

---

# Ubuntu

```bash id="zvjlwm"
sudo apt install exfat-fuse exfatprogs
```

Explanation:

* `exfat-fuse`

  * userspace filesystem driver

* `exfatprogs`

  * formatting/checking tools

---

# CentOS / RHEL

```bash id="p7chq4"
sudo dnf install exfatprogs
```

---

# Creating exFAT Partition

## Start parted

```bash id="o79h1k"
sudo parted
```

---

## Select disk

```bash id="n1a7d9"
select /dev/sdb
```

---

## View partitions

```bash id="mjlwm4"
print
```

---

## Create exFAT partition

```bash id="bjlwm3"
mkpart primary exfat 50001 100%
```

Explanation:

* creates second partition
* uses remaining disk space

---

# Create exFAT Filesystem

```bash id="eqjlwm"
sudo mkfs.exfat /dev/sdb2
```

Explanation:

* formats partition as exFAT

---

# Create Mount Directory

```bash id="a5j3wt"
sudo mkdir -p /mnt/partition2
```

---

# Mount exFAT Partition

## Default mount

```bash id="0jlwm4"
sudo mount /dev/sdb2 /mnt/partition2
```

---

# Problem: Permission Denied

Example:

```bash id="jlwmx2"
touch test.txt
```

Possible result:

```bash id="jlwmx3"
Permission denied
```

Reason:

* filesystem mounted by root
* ownership defaults to root
* exFAT cannot store real Linux ownership metadata

---

# Checking Your User ID

```bash id="jlwmx4"
id
```

Example:

```bash id="jlwmx5"
uid=1000(mohammad) gid=1000(mohammad)
```

---

# Mounting With Custom Ownership

## Using `uid` and `gid`

```bash id="jlwmx6"
sudo mount -o uid=1001,gid=1001 /dev/sdb2 /mnt/partition2
```

Explanation:

* `uid=1001`

  * all files appear owned by user 1001

* `gid=1001`

  * all files appear owned by group 1001

---

# Now File Creation Works

```bash id="jlwmx7"
touch test.txt
```

Success:

* because mounted ownership matches your user

---

# Important Behavior

Even though:

```bash id="jlwmx8"
chmod 700 test.txt
```

is executed,

permissions do NOT really change.

Why?

Because exFAT:

* does not support Linux permission metadata

Linux only simulates permissions during mounting.

---

# `umask`

Controls default permissions for files/folders.

Example:

```bash id="jlwmx9"
umask=0027
```

---

# Understanding `umask`

Permissions are calculated like this:

```bash id="jlwmxa"
0777 - umask
```

Example:

```bash id="jlwmxb"
0777 - 0027 = 0750
```

Resulting permissions:

```bash id="jlwmxc"
rwxr-x---
```

Meaning:

* owner: full access
* group: read/execute
* others: no access

---

# Why Leading Zero?

```bash id="jlwmxd"
0027
```

starts with:

```bash id="jlwmxe"
0
```

to indicate:

* octal notation

Linux permissions use octal numbers:

* base 8

---

# Mounting With All Options

```bash id="jlwmxf"
sudo mount -o uid=1001,gid=1001,umask=0027 /dev/sdb2 /mnt/partition2
```

Effects:

* files owned by user 1001
* group owned by group 1001
* permissions simulated as 0750

---

# Verifying Permissions

```bash id="jlwmxg"
ls -l
```

Example:

```bash id="jlwmxh"
-rwxr-x--- 1 mohammad mohammad 0 May 18 test.txt
```

Remember:

* permissions are simulated
* not truly stored on exFAT

---

# Important Difference From ext4

## ext4

Permissions stored:

* per-file
* permanently

---

## exFAT

Permissions generated:

* dynamically during mount
* using mount options

---

# Real-World Usage of exFAT

Very common for:

* USB flash drives
* SD cards
* cameras
* dual Windows/Linux systems
* external SSDs

Because:

* large file support
* cross-platform compatibility

---

# Why Linux Admins Prefer ext4 For Servers

Because ext4 supports:

* real permissions
* ownership
* journaling
* ACLs
* symlinks
* Linux metadata

exFAT lacks most of these.

---

# Security Implication

With exFAT:

* every file effectively shares same ownership/permission policy
* less granular security

Not ideal for:

* production Linux servers
* multi-user systems

---

# Important Docker Relation

Docker bind mounts rely heavily on:

* Linux UID/GID mechanics

Understanding:

```bash id="’wini9"
uid=
gid=
```

becomes VERY important later when:

* containers cannot access mounted files
* permission conflicts appear
* volumes fail between host/container

This lesson is secretly preparing you for many future Docker debugging situations.
