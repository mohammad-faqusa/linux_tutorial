# 281. Full Software Upgrade on Ubuntu

# important distinction

There are TWO different upgrade types in Ubuntu:

| Upgrade Type    | Purpose                       |
| --------------- | ----------------------------- |
| Package upgrade | update installed packages     |
| Release upgrade | upgrade entire Ubuntu version |

---

# normal package upgrades

## update package lists

```bash id="upgrade001"
sudo apt update
```

Downloads latest package metadata.

---

# upgrade installed packages

```bash id="upgrade002"
sudo apt full-upgrade
```

or older equivalent:

```bash id="upgrade003"
sudo apt-get dist-upgrade
```

---

# what `full-upgrade` does

Unlike simple:

```bash id="upgrade004"
sudo apt upgrade
```

`full-upgrade` may:

* install/remove dependencies
* replace packages
* resolve complex upgrades

Used for:

```text id="upgrade005"
major dependency transitions
```

---

# upgrading Ubuntu release version

Example:

```text id="upgrade006"
22.04 LTS → 24.04 LTS
```

This is MUCH bigger than normal package upgrades.

Thousands of packages may change.

---

# VERY IMPORTANT PREPARATION CHECKLIST

Before release upgrade:

---

# 1. full backup

Most important step.

Because:

```text id="upgrade007"
release upgrades can fail
```

Backup:

* home directory
* databases
* configs
* SSH keys
* Docker volumes
* important projects

---

# 2. enough free disk space

Check:

```bash id="upgrade008"
df -h /
```

Need:

```text id="upgrade009"
several GB free
```

because:

* packages downloaded
* temporary files created
* kernels/initramfs generated

---

# 3. enough time

Do NOT upgrade when:

* tired
* busy
* unstable electricity
* urgent work needed

Because fixing failures may take hours.

---

# 4. wait after new release

Best practice:

```text id="upgrade010"
wait 1–2 weeks
```

after major Ubuntu release.

Early releases sometimes:

* contain bugs
* have repository issues
* break drivers/packages

---

# 5. verify third-party repositories

Very important.

PPAs/external repos may:

* not support new Ubuntu release yet

Broken repositories can:

* break apt
* create dependency conflicts

Inspect:

```bash id="upgrade011"
ls /etc/apt/sources.list.d/
```

---

# 6. prepare recovery media

Always have:

```text id="upgrade012"
bootable Ubuntu USB
```

available.

Because:

* bootloader failures
* initramfs failures
* package corruption
  may occur.

---

# 7. evaluate upgrade path

Check current version:

```bash id="upgrade013"
lsb_release -a
```

---

# important LTS concept

```text id="upgrade014"
LTS = Long Term Support
```

Ubuntu LTS releases:

* more stable
* supported longer
* preferred for servers/workstations

---

# example outputs

```text id="upgrade015"
22.04 LTS → Jammy
24.04 LTS → Noble
```

Codename identifies release.

---

# Step 1: install all normal updates FIRST

Very important.

```bash id="upgrade016"
sudo apt update
```

```bash id="upgrade017"
sudo apt full-upgrade
```

---

# Step 2: reboot

```bash id="upgrade018"
sudo reboot
```

Ensures:

* latest kernel running
* clean package state

---

# Step 3: install upgrade manager

```bash id="upgrade019"
sudo apt install update-manager-core
```

Provides:

```text id="upgrade020"
do-release-upgrade
```

tool.

---

# Step 4: start release upgrade

```bash id="upgrade021"
sudo do-release-upgrade
```

This:

* updates repositories
* downloads new packages
* migrates system

---

# important Ubuntu upgrade rule

You usually upgrade:

```text id="upgrade022"
one release step at a time
```

Examples:

```text id="upgrade023"
22.04 → 22.10 → 23.04
```

or:

```text id="upgrade024"
22.04 LTS → 24.04 LTS
```

---

# LTS-only behavior

By default:

* Ubuntu may only offer:

```text id="upgrade025"
LTS → LTS
```

upgrades.

---

# enabling non-LTS upgrades

Edit:

```bash id="upgrade026"
sudo nano /etc/update-manager/release-upgrades
```

---

# important setting

```text id="upgrade027"
Prompt=normal
```

Allows:

* non-LTS upgrades

---

# default safer setting

```text id="upgrade028"
Prompt=lts
```

---

# upgrade interaction

During upgrade:

* package conflicts resolved
* services restarted
* config files replaced/merged

---

# console-setup prompt

You may see:

```text id="upgrade029"
keyboard configuration
```

during upgrade.

Normal.

---

# obsolete packages

Upgrade may ask:

```text id="upgrade030"
Remove obsolete packages?
```

Usually:

```text id="upgrade031"
yes
```

is recommended.

These are:

* old dependencies
* unsupported packages
* replaced libraries

---

# after upgrade

Verify:

```bash id="upgrade032"
lsb_release -a
```

Check:

* new Ubuntu version
* codename

---

# VERY IMPORTANT PART OF THIS CHAPTER

After upgrade:

```text id="upgrade033"
system no longer boots
```

This is extremely realistic.

Major upgrades can break:

* GRUB
* initramfs
* drivers
* packages
* graphics stack
* kernel modules

---

# why release upgrades are risky

Because:

```text id="upgrade034"
thousands of packages change simultaneously
```

including:

* libc
* systemd
* kernels
* bootloader
* drivers

---

# common causes of post-upgrade boot failure

| Cause                      | Example                |
| -------------------------- | ---------------------- |
| Broken initramfs           | missing modules        |
| Failed GRUB update         | invalid boot config    |
| NVIDIA driver mismatch     | black screen           |
| Incomplete package install | interrupted upgrade    |
| Full disk                  | package corruption     |
| Broken DKMS modules        | kernel incompatibility |

---

# professional recommendation

For important production systems:

```text id="upgrade035"
test upgrades in VM first
```

Very common enterprise practice.

---

# your VM practice is extremely valuable here

Because now:

* you can safely break systems
* recover them
* understand boot internals

without risking main machine.

That is exactly how strong Linux admins learn.

---

# important recovery preparation knowledge

You already learned:

* GRUB
* initramfs
* fsck
* mounts
* journalctl
* LVM
* systemd

Now those concepts become:

```text id="upgrade036"
practical recovery tools
```

---

# useful commands summary

Check Ubuntu version:

```bash id="upgrade037"
lsb_release -a
```

Update package lists:

```bash id="upgrade038"
sudo apt update
```

Upgrade packages:

```bash id="upgrade039"
sudo apt full-upgrade
```

Reboot:

```bash id="upgrade040"
sudo reboot
```

Install upgrade manager:

```bash id="upgrade041"
sudo apt install update-manager-core
```

Start release upgrade:

```bash id="upgrade042"
sudo do-release-upgrade
```

Edit upgrade behavior:

```bash id="upgrade043"
sudo nano /etc/update-manager/release-upgrades
```

Check free space:

```bash id="upgrade044"
df -h /
```

List repositories:

```bash id="upgrade045"
ls /etc/apt/sources.list.d/
```

That is completely normal.

GRUB and initramfs are difficult at first because they happen in:

```text id="bootdeep001"
very early boot stages
```

where:

* Linux is only partially loaded
* many normal tools are unavailable
* multiple layers interact together

Most people memorize commands there without truly understanding them.

You are actually doing better by stopping and noticing:

```text id="bootdeep002"
"I still don't fully understand this"
```

That awareness is important.

---

# The BIG picture first

Forget commands for a moment.

Your machine boots roughly like this:

```text id="bootdeep003"
Power On
↓
BIOS/UEFI
↓
GRUB
↓
Linux Kernel (vmlinuz)
↓
initramfs
↓
Real Root Filesystem
↓
systemd
↓
Desktop/Login
```

Now let's deeply simplify:

* what GRUB does
* what initramfs does

because THIS is the key.

---

# GRUB — what is it REALLY?

GRUB is basically:

```text id="bootdeep004"
a boot menu + kernel loader
```

Its main job:

```text id="bootdeep005"
find Linux kernel and load it into memory
```

---

# Think of GRUB like this

Imagine:

* your computer just powered on
* RAM mostly empty
* Linux not running yet

At this moment:

* there is NO:

  * systemd
  * bash
  * apt
  * filesystem mounts
  * drivers

Only:

```text id="bootdeep006"
firmware + bootloader
```

exist.

---

# GRUB's responsibilities

GRUB:

1. shows boot menu
2. finds Linux kernel
3. loads kernel into RAM
4. loads initramfs into RAM
5. passes control to kernel

Then:

```text id="bootdeep007"
GRUB's job ends
```

---

# VERY important understanding

GRUB does NOT boot the full system itself.

It only:

```text id="bootdeep008"
starts the kernel
```

---

# Kernel problem

Now another problem appears.

The Linux kernel starts...

BUT:

```text id="bootdeep009"
kernel still cannot fully access your disk/system yet
```

Why?

Because:

* storage drivers may not yet be loaded
* LVM may not be activated
* filesystem drivers may not exist yet
* encrypted disks may need unlocking

This is where:

```text id="bootdeep010"
initramfs
```

becomes critical.

---

# initramfs — what is it REALLY?

initramfs is:

```text id="bootdeep011"
a tiny temporary Linux system loaded into RAM
```

VERY important concept.

---

# Why initramfs exists

Kernel alone is often insufficient to boot modern systems.

Kernel needs help to:

* detect disks
* load modules
* activate LVM
* unlock encryption
* mount root filesystem

So:

```text id="bootdeep012"
initramfs acts like an emergency mini Linux
```

before the real Linux system starts.

---

# Think of initramfs like this

```text id="bootdeep013"
GRUB loads:
1. kernel
2. tiny rescue Linux (initramfs)

Kernel starts
↓
Kernel runs tiny rescue Linux
↓
Tiny rescue Linux prepares real system
↓
Real root filesystem mounted
↓
Switch to actual Ubuntu
```

THIS is the key mental model.

---

# What initramfs usually contains

Very minimal environment:

* busybox shell
* storage drivers
* filesystem modules
* LVM tools
* encryption tools
* mount tools

Enough to:

```text id="bootdeep014"
prepare the real system
```

---

# Real example

Suppose your root filesystem is:

```text id="bootdeep015"
/dev/vgroup/root
```

stored inside:

```text id="bootdeep016"
LVM
```

At boot:

* kernel initially cannot understand LVM fully

So initramfs:

1. loads LVM modules
2. activates volume groups
3. finds root LV
4. mounts it

THEN:

```text id="bootdeep017"
real Ubuntu starts
```

---

# SUPER important transition

At some point:

```text id="bootdeep018"
switch_root
```

happens.

Meaning:

* initramfs temporary root discarded
* real root filesystem becomes `/`

Then:

```text id="bootdeep019"
systemd starts
```

and normal Linux begins.

---

# Why boot failures happen

Now you can understand failures better.

---

# If GRUB broken

Then:

* kernel never starts

Symptoms:

* GRUB rescue shell
* no boot menu
* black screen before Linux

---

# If kernel broken

Then:

* kernel panic
* freezes very early

---

# If initramfs broken

Then:

* kernel starts
  BUT:
* cannot find root filesystem

Common message:

```text id="bootdeep020"
ALERT! UUID not found
```

or:

```text id="bootdeep021"
Dropped to initramfs shell
```

Very common recovery scenario.

---

# If root filesystem broken

Then:

* initramfs cannot mount it
* boot stops

---

# This is why initramfs regeneration matters

Commands like:

```bash id="bootdeep022"
sudo update-initramfs -u
```

rebuild:

```text id="bootdeep023"
temporary boot environment
```

including:

* modules
* drivers
* storage support

---

# This is why GRUB regeneration matters

Commands like:

```bash id="bootdeep024"
sudo update-grub
```

rebuild:

```text id="bootdeep025"
bootloader configuration
```

including:

* available kernels
* boot entries
* root UUIDs

---

# VERY important conceptual separation

| Component | Responsibility           |
| --------- | ------------------------ |
| GRUB      | load kernel/initramfs    |
| Kernel    | core operating system    |
| initramfs | prepare real system      |
| systemd   | start services/userspace |

---

# Why this feels confusing

Because:

```text id="bootdeep026"
multiple systems temporarily exist during boot
```

Example:

1. firmware environment
2. GRUB environment
3. initramfs mini Linux
4. real Ubuntu system

Understanding this layering takes time.

---

# The biggest mental breakthrough

When you realize:

```text id="bootdeep027"
initramfs is basically a temporary mini Linux system
```

everything becomes MUCH clearer.

That is usually the major turning point in understanding Linux booting.

---

# Your Linux knowledge is already preparing you

Because now you understand:

* mounts
* filesystems
* LVM
* kernel modules
* systemd
* partitions

Without those concepts:

* GRUB/initramfs are almost impossible to understand deeply.

So you are actually learning them in the correct order.
