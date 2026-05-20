# 279. Advanced LVM Features: RAID, Thin Volumes, and Snapshots

# important note

This course section gives:

```text id="lvmadv001"
high-level enterprise concepts
```

These are advanced storage technologies heavily used in:

* servers
* virtualization
* cloud infrastructure
* enterprise Linux

Understanding the concepts is very valuable even if:

* you do not configure them yet.

---

# RAID (Redundant Array of Independent Disks)

RAID combines multiple disks to improve:

* performance
* redundancy
* fault tolerance

---

# LVM and RAID

LVM can:

* work on top of RAID
  or:
* implement RAID-like functionality itself

Modern LVM supports:

```text id="lvmadv002"
RAID 0,1,4,5,6,10
```

---

# important RAID concepts

| Goal            | RAID helps with      |
| --------------- | -------------------- |
| Speed           | striping             |
| Redundancy      | mirroring/parity     |
| Fault tolerance | survive disk failure |

---

# RAID 0 — striping

## idea

Data split across multiple disks.

Example:

```text id="lvmadv003"
Disk A + Disk B
```

Data alternates between them.

---

# advantage

```text id="lvmadv004"
higher performance
```

because:

* reads/writes parallelized

---

# disadvantage

```text id="lvmadv005"
NO redundancy
```

If ONE disk fails:

* all data lost.

---

# RAID 0 visualization

```text id="lvmadv006"
File:
A1 A2 A3 A4

Disk1: A1 A3
Disk2: A2 A4
```

---

# RAID 1 — mirroring

## idea

Same data duplicated across disks.

---

# advantage

```text id="lvmadv007"
redundancy
```

One disk can fail safely.

---

# disadvantage

```text id="lvmadv008"
50% storage efficiency
```

2×50GB disks:
→ only 50GB usable.

---

# RAID 5

## idea

Striping + parity.

Needs:

```text id="lvmadv009"
minimum 3 disks
```

---

# advantage

```text id="lvmadv010"
1 disk may fail
```

without losing data.

Good balance:

* storage efficiency
* redundancy

---

# RAID 5 example

3×50GB disks:

Usable storage:

```text id="lvmadv011"
100GB
```

because:

* one disk worth used for parity.

---

# RAID 6

Similar to RAID 5 BUT:

* double parity

---

# advantage

```text id="lvmadv012"
2 disks may fail
```

safely.

---

# disadvantage

More parity overhead:

* slightly slower writes
* less usable storage

---

# RAID 10 (1+0)

Combination of:

* RAID 1
* RAID 0

---

# advantage

Provides:

* high performance
* redundancy

Very popular in:

* databases
* virtualization
* enterprise systems

---

# simplified RAID comparison

| RAID   | Speed     | Redundancy | Min disks |
| ------ | --------- | ---------- | --------- |
| RAID0  | High      | None       | 2         |
| RAID1  | Medium    | 1 disk     | 2         |
| RAID5  | Good      | 1 disk     | 3         |
| RAID6  | Good      | 2 disks    | 4         |
| RAID10 | Very high | Yes        | 4         |

---

# Thin Volumes

## traditional allocation

Normally:

* storage reserved immediately

Example:

```text id="lvmadv013"
LV size = 100GB
```

means:

```text id="lvmadv014"
100GB actually consumed
```

inside VG.

---

# thin provisioning

Thin volumes allow:

```text id="lvmadv015"
virtual allocation larger than physical storage
```

Example:

| Physical storage | Advertised volume |
| ---------------- | ----------------- |
| 50GB             | 100GB             |

---

# how this works

Storage allocated:

```text id="lvmadv016"
only when actually written
```

Very common in:

* virtualization
* cloud providers
* VM hosting

---

# advantage

Efficient storage utilization.

Many VMs may each receive:

```text id="lvmadv017"
100GB virtual disk
```

while actual usage much lower.

---

# IMPORTANT RISK

If real physical storage fills completely:

```text id="lvmadv018"
system may crash or corrupt data
```

Thus:

* monitoring very important.

---

# Snapshot feature

## idea

Create:

```text id="lvmadv019"
point-in-time copy
```

of logical volume.

---

# important detail

Snapshots initially consume:

```text id="lvmadv020"
very little storage
```

because:

* unchanged blocks shared

Only modified blocks after snapshot consume extra space.

Technique called:

```text id="lvmadv021"
Copy-On-Write (COW)
```

---

# snapshot workflow

## Step 1

Create snapshot.

---

## Step 2

Original system continues running.

---

## Step 3

Changed blocks copied separately.

---

# why snapshots are powerful

Allows:

* consistent backups
* rollback
* testing
* safe upgrades

without shutting system down.

---

# practical backup example

## without snapshot

Database/filesystem changing during backup:

* inconsistent state possible

---

## with snapshot

1. create snapshot
2. backup snapshot
3. remove snapshot

Backup remains:

```text id="lvmadv022"
consistent
```

even while production system changes.

---

# example conceptual workflow

```text id="lvmadv023"
Production LV
   ↓
Snapshot created
   ↓
Backup snapshot
   ↓
Delete snapshot
```

---

# important snapshot limitation

Snapshots are NOT full backups.

If:

* original disks fail completely

snapshots disappear too.

Still stored on same storage pool unless copied elsewhere.

---

# enterprise relevance

These features are heavily used in:

* VMware
* Proxmox
* OpenStack
* enterprise databases
* backup systems
* SAN/NAS storage

---

# important professional understanding

LVM evolved from:

```text id="lvmadv024"
simple partition abstraction
```

into:

```text id="lvmadv025"
enterprise storage management system
```

---

# conceptual layering

Example enterprise stack:

```text id="lvmadv026"
Physical disks
→ RAID
→ LVM
→ Thin volumes
→ Snapshots
→ Filesystems
→ Virtual machines
```

Very common architecture.

---

# important distinction

| Technology        | Purpose                |
| ----------------- | ---------------------- |
| RAID              | redundancy/performance |
| LVM               | storage abstraction    |
| Thin provisioning | overcommit storage     |
| Snapshots         | point-in-time recovery |

---

# common real-world usage

## virtualization hosts

Example:

* many VM disks
* thin-provisioned
* snapshot before upgrades
* RAID underneath

---

# why this matters for you

As you move toward:

* backend
* Docker
* cloud
* DevOps
* infrastructure

understanding these concepts becomes extremely valuable.

Many developers never study storage deeply.

---

# useful inspection commands preview

Show RAID devices:

```bash id="lvmadv027"
cat /proc/mdstat
```

Show LVM:

```bash id="lvmadv028"
sudo lvs
sudo vgs
sudo pvs
```

Show snapshots:

```bash id="lvmadv029"
sudo lvs
```

Thin pool details:

```bash id="lvmadv030"
sudo lvs -a
```

Show filesystem usage:

```bash id="lvmadv031"
df -h
```
