## 230. The GRUB2 Bootloader: Safely Modifying Configuration for Linux System Startup

### the bootloader : GRUB 2

* after the BIOS/UEFI, the bootloader is the first software that runs during startup
* the goal of the bootloader is to load the operating system
* how does it work:

  * loads the Linux kernel into memory
  * passes control to the kernel
  * may also load the initramfs/initrd image

### GRUB configuration

* main default configuration file:

  * `/etc/default/grub`

* after editing the configuration:

  * Ubuntu/Debian:

```bash
sudo update-grub
```

* RHEL/CentOS/Rocky Linux:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

* on UEFI systems:

```bash
sudo grub2-mkconfig -o /boot/efi/EFI/rocky/grub.cfg
```

### important note

* we should NEVER edit the generated GRUB configuration file directly:

  * `/boot/grub2/grub.cfg`
* because it is automatically generated
* changes may be overwritten after updates or regeneration

### common GRUB settings

* default boot entry:

```bash
GRUB_DEFAULT=0
```

* boot timeout:

```bash
GRUB_TIMEOUT=5
```

* hidden menu:

```bash
GRUB_TIMEOUT_STYLE=hidden
```

* kernel parameters:

```bash
GRUB_CMDLINE_LINUX="quiet splash"
```

### useful commands

* show current kernel:

```bash
uname -r
```

* list installed kernels:

```bash
rpm -q kernel
```

* show GRUB menu entries:

```bash
grep menuentry /boot/grub2/grub.cfg
```

* reboot directly into firmware setup:

```bash
systemctl reboot --firmware-setup
```

### BIOS vs UEFI

* BIOS:

  * traditional firmware interface
  * usually uses MBR partitioning

* UEFI:

  * modern replacement for BIOS
  * supports Secure Boot
  * usually uses GPT partitioning
  * stores bootloaders inside EFI System Partition (ESP)

### boot process overview

1. BIOS/UEFI starts
2. bootloader (GRUB2) loads
3. GRUB loads kernel + initramfs
4. kernel initializes hardware
5. systemd starts userspace services
6. login screen/terminal appears
