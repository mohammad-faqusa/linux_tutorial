# 284. Prevention: Kernel Safeguarding

# important idea of this lecture

After recovering the system:

```text id="kernelsafe001"
how do we prevent the same problem from happening again?
```

Very important real-world Linux administration topic.

---

# why keeping old kernels is valuable

Suppose:

* newest kernel broken
* system cannot boot

If:

```text id="kernelsafe002"
older kernel still installed
```

then:

* recovery becomes MUCH easier.

You simply:

* choose old kernel from GRUB
* boot normally

---

# why Ubuntu usually keeps older kernels

Ubuntu intentionally:

```text id="kernelsafe003"
keeps multiple kernels
```

for safety.

This is extremely useful.

---

# important command

## autoremove

```bash id="kernelsafe004"
sudo apt-get autoremove
```

Purpose:

* remove unused dependencies/packages

---

# important observation

`autoremove`:

```text id="kernelsafe005"
did NOT remove old kernel
```

Why?

Because Ubuntu protects:

* currently used kernel
* fallback kernels

to avoid:

```text id="kernelsafe006"
system becoming unbootable
```

---

# investigating kernel files

## kernel storage location

```bash id="kernelsafe007"
cd /boot
```

Important files:

| File         | Purpose       |
| ------------ | ------------- |
| vmlinuz-*    | Linux kernel  |
| initrd.img-* | initramfs     |
| config-*     | kernel config |
| System.map-* | symbol map    |

---

# example

```text id="kernelsafe008"
vmlinuz-5.19...
```

actual kernel binary.

---

# initrd/initramfs

```text id="kernelsafe009"
initrd.img-...
```

temporary boot filesystem loaded before root mount.

---

# finding package owning a file

Very important Debian/Ubuntu tool:

```bash id="kernelsafe010"
dpkg -S /boot/vmlinuz-5.19...
```

Meaning:

```text id="kernelsafe011"
which package installed this file?
```

Extremely useful troubleshooting command.

---

# example output meaning

Suppose output:

```text id="kernelsafe012"
linux-image-5.19...
```

Meaning:

* kernel file belongs to that package.

---

# manually protecting a kernel

Installing explicitly:

```bash id="kernelsafe013"
sudo apt install linux-image-5.19...
```

marks kernel as:

```text id="kernelsafe014"
manually installed
```

Meaning:

* apt less likely to remove it automatically.

---

# why this matters

You may intentionally want:

```text id="kernelsafe015"
stable fallback kernel
```

especially on:

* servers
* production systems
* remote systems

---

# investigating initrd ownership

Sometimes:

```bash id="kernelsafe016"
dpkg -S initrd.img-...
```

returns:

```text id="kernelsafe017"
no path found
```

Why?

Because:

```text id="kernelsafe018"
initrd generated dynamically
```

by tools like:

* initramfs-tools
* update-initramfs

Not always directly packaged files.

---

# regenerating initramfs

Important command:

```bash id="kernelsafe019"
sudo dpkg-reconfigure linux-image-5.19...
```

This may:

* regenerate initramfs
* rerun kernel hooks
* refresh boot configuration

Useful when:

* initramfs corrupted
* boot modules missing

---

# easiest recovery strategy

Instead of fixing broken kernel:

```text id="kernelsafe020"
remove problematic kernel
```

Very realistic strategy.

---

# identify broken kernel package

```bash id="kernelsafe021"
dpkg -S /boot/vmlinuz-6.2...
```

---

# remove problematic kernel

```bash id="kernelsafe022"
sudo apt remove linux-image-6.2...
```

---

# dependency issue

Sometimes removal fails because:

* meta-packages depend on it

Example:

```text id="kernelsafe023"
linux-headers-generic
```

or:

```text id="kernelsafe024"
linux-generic
```

---

# important concept: meta-packages

Meta-packages:

```text id="kernelsafe025"
contain almost no files themselves
```

Instead:

* depend on latest kernel packages

Ubuntu uses them to:

* automatically track newest kernels.

---

# example

```text id="kernelsafe026"
linux-generic
```

depends on:

* latest kernel image
* latest headers

---

# why removal may fail

Because:

```text id="kernelsafe027"
package dependency chain blocks removal
```

---

# removing headers first

Sometimes required:

```bash id="kernelsafe028"
sudo apt remove linux-headers-6.2...
```

then:

```bash id="kernelsafe029"
sudo apt remove linux-image-6.2...
```

---

# VERY important professional advice

Never remove:

```text id="kernelsafe030"
ALL kernels except one
```

Always keep:

```text id="kernelsafe031"
at least one older working kernel
```

Especially on:

* remote servers
* cloud systems
* production machines

---

# enterprise best practice

Common strategy:

| Kernel       | Purpose            |
| ------------ | ------------------ |
| newest       | testing/current    |
| older stable | emergency fallback |

---

# how GRUB helps

GRUB advanced menu:

```text id="kernelsafe032"
Advanced options for Ubuntu
```

lets you:

* select fallback kernels easily.

---

# why kernel issues happen

Common reasons:

* NVIDIA drivers
* DKMS failures
* incompatible modules
* incomplete upgrades
* experimental kernels
* filesystem driver changes

---

# important real-world insight

Linux admins often:

```text id="kernelsafe033"
prefer stability over newest kernels
```

Especially on servers.

---

# valuable commands summary

Show installed kernels:

```bash id="kernelsafe034"
dpkg --list | grep linux-image
```

List boot files:

```bash id="kernelsafe035"
ls /boot
```

Find package owning file:

```bash id="kernelsafe036"
dpkg -S /boot/vmlinuz-*
```

Rebuild initramfs:

```bash id="kernelsafe037"
sudo update-initramfs -u
```

Reconfigure kernel package:

```bash id="kernelsafe038"
sudo dpkg-reconfigure linux-image-5.19...
```

Remove broken kernel:

```bash id="kernelsafe039"
sudo apt remove linux-image-6.2...
```

Remove headers:

```bash id="kernelsafe040"
sudo apt remove linux-headers-6.2...
```

Update GRUB:

```bash id="kernelsafe041"
sudo update-grub
```

Show current kernel:

```bash id="kernelsafe042"
uname -r
```
