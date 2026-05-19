# 261. The SMART Protocol: Proactive Drive Health Monitoring

## what is SMART?

SMART stands for:

```text id="smart101"
Self-Monitoring, Analysis and Reporting Technology
```

It is a monitoring system built into:

* HDDs
* SSDs
* NVMe drives

used for:

* health monitoring
* detecting hardware deterioration
* predicting possible failures

---

# important idea

physical drives deteriorate over time because of:

* flash wear (SSD/NVMe)
* mechanical wear (HDD)
* bad sectors
* overheating
* power issues

SMART helps monitor these problems.

---

# what SMART can detect

examples:

* bad sectors
* read/write failures
* overheating
* flash wear
* excessive retries
* controller issues
* unsafe shutdowns

---

# important limitation

SMART only evaluates:

```text id="smart102"
physical drive hardware health
```

it does NOT detect:

* broken filesystem
* corrupted partition table
* deleted files
* damaged ext4/xfs structures
* wrong mounts

Those are higher-level software/storage problems.

---

# install SMART tools

Ubuntu/Debian:

```bash id="smart103"
sudo apt install smartmontools
```

Fedora/CentOS:

```bash id="smart104"
sudo dnf install smartmontools
```

---

# main utility

```text id="smart105"
smartctl
```

used to:

* inspect drive health
* run tests
* view SMART attributes

---

# basic usage

## SATA/SAS drives

```bash id="smart106"
sudo smartctl --all /dev/sda
```

or:

```bash id="smart107"
sudo smartctl -a /dev/sda
```

---

# NVMe drives

important:

* use the whole device
* NOT partition

correct:

```bash id="smart108"
sudo smartctl -a /dev/nvme0
```

not:

```bash id="smart109"
/dev/nvme0n1p1
```

because SMART belongs to:

* entire physical device

---

# healthy output example

```text id="smart110"
SMART overall-health self-assessment test result: PASSED
```

usually means:

* drive reports healthy state.

---

# important SMART sections

# overall health

```text id="smart111"
SMART overall-health self-assessment test result
```

most important quick indicator.

---

# temperature

example:

```text id="smart112"
Temperature: 40 Celsius
```

important especially for:

* NVMe drives

---

# percentage used (SSD/NVMe)

example:

```text id="smart113"
Percentage Used: 25%
```

means:

* approximately 25% wear consumed.

---

# unsafe shutdowns

example:

```text id="smart114"
Unsafe Shutdowns: 41
```

indicates:

* forced power offs
* crashes
* battery failures

---

# integrity/media errors

VERY important.

example:

```text id="smart115"
Media and Data Integrity Errors: 0
```

good sign.

Non-zero values may indicate:

* NAND failure
* bad blocks
* corruption

---

# data written/read

example:

```text id="smart116"
Data Units Written: 35.0 TB
```

shows SSD wear usage.

---

# SMART self-tests

drives can perform:

* short tests
* long tests

---

# short test

quick diagnostic.

```bash id="smart117"
sudo smartctl -t short /dev/sda
```

or NVMe:

```bash id="smart118"
sudo smartctl -t short /dev/nvme0
```

---

# long test

more comprehensive.

```bash id="smart119"
sudo smartctl -t long /dev/sda
```

may take:

* minutes
* hours

depending on drive size.

---

# view self-test results

```bash id="smart120"
sudo smartctl -a /dev/sda
```

look for:

```text id="smart121"
Self-test log
```

---

# common HDD SMART indicators

# reallocated sectors

important for HDDs.

bad if increasing:

```text id="smart122"
Reallocated_Sector_Ct
```

---

# pending sectors

```text id="smart123"
Current_Pending_Sector
```

non-zero often concerning.

---

# uncorrectable sectors

```text id="smart124"
Offline_Uncorrectable
```

may indicate physical damage.

---

# common SSD/NVMe indicators

# percentage used

SSD wear level.

---

# available spare

example:

```text id="smart125"
Available Spare: 100%
```

good.

---

# media/data integrity errors

very important for NAND health.

---

# NVMe-specific monitoring

For NVMe, sometimes better tool:

## install nvme-cli

```bash id="smart126"
sudo apt install nvme-cli
```

---

## show NVMe SMART log

```bash id="smart127"
sudo nvme smart-log /dev/nvme0
```

---

# important practical idea

SMART is:

```text id="smart128"
self-reported
```

the drive itself reports status.

Therefore:

* not absolutely perfect
* but still extremely useful

---

# monitoring continuously

## watch temperature

```bash id="smart129"
watch -n 2 'sudo smartctl -a /dev/nvme0 | grep Temperature'
```

---

# health-only quick check

```bash id="smart130"
sudo smartctl -H /dev/nvme0
```

---

# useful Linux storage commands

show disks:

```bash id="smart131"
lsblk
```

show filesystem UUIDs:

```bash id="smart132"
blkid
```

show mounted filesystems:

```bash id="smart133"
df -h
```

show partition tables:

```bash id="smart134"
sudo fdisk -l
```

---

# important practical distinction

| Layer                 | Tool          |
| --------------------- | ------------- |
| Physical drive health | SMART         |
| Filesystem repair     | fsck          |
| Partitioning          | fdisk/gparted |
| Mounting              | mount/fstab   |

---

# examples of problems SMART CANNOT detect

* deleted files
* broken ext4 metadata
* wrong `/etc/fstab`
* corrupted GPT partition table
* filesystem inconsistency

For those:

```bash id="smart135"
fsck
```

is more relevant.

---

# useful commands summary

install smartmontools:

```bash id="smart136"
sudo apt install smartmontools
```

show full SMART:

```bash id="smart137"
sudo smartctl -a /dev/sda
```

NVMe:

```bash id="smart138"
sudo smartctl -a /dev/nvme0
```

health only:

```bash id="smart139"
sudo smartctl -H /dev/sda
```

start short test:

```bash id="smart140"
sudo smartctl -t short /dev/sda
```

start long test:

```bash id="smart141"
sudo smartctl -t long /dev/sda
```

NVMe smart log:

```bash id="smart142"
sudo nvme smart-log /dev/nvme0
```
