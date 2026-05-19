# 260. Extra Lecture (Optional): Automatically Mounting FTP Servers through `/etc/fstab`

## goal

automatically mount an FTP server at boot using:

```text id="fstftp001"
/etc/fstab
```

combined with:

```text id="fstftp002"
curlftpfs
```

---

# important idea

normally:

```bash id="fstftp003"
curlftpfs ftp://server /mnt/ftp
```

mounts manually.

Using:

```text id="fstftp004"
/etc/fstab
```

allows:

* automatic mounting
* persistent configuration
* systemd automount integration

---

# install curlftpfs

```bash id="fstftp005"
sudo apt install curlftpfs
```

---

# create mount point

```bash id="fstftp006"
sudo mkdir -p /mnt/ftp
```

---

# basic fstab syntax

## with username/password

```text id="fstftp007"
curlftpfs#username:password@server/ /mnt/ftp fuse noauto,allow_other,x-systemd.automount 0 0
```

---

## example

```text id="fstftp008"
curlftpfs#mohammad:3141@192.168.56.101/ /mnt/ftp fuse noauto,allow_other,x-systemd.automount 0 0
```

---

# safer approach using `.netrc`

recommended:

* avoid passwords in `/etc/fstab`

then use:

```text id="fstftp009"
curlftpfs#192.168.56.101/ /mnt/ftp fuse noauto,allow_other,x-systemd.automount 0 0
```

credentials loaded automatically from:

```text id="fstftp010"
/root/.netrc
```

---

# edit `/etc/fstab`

```bash id="fstftp011"
sudo nano /etc/fstab
```

Add:

```text id="fstftp012"
curlftpfs#192.168.56.101/ /mnt/ftp fuse noauto,allow_other,x-systemd.automount,_netdev 0 0
```

---

# important typo correction

wrong:

```text id="fstftp013"
/etc/fstap
```

correct:

```text id="fstftp014"
/etc/fstab
```

---

# explanation of mount options

## `noauto`

```text id="fstftp015"
noauto
```

means:

* do NOT mount immediately during boot

instead:

* mount on first access

---

## `allow_other`

```text id="fstftp016"
allow_other
```

allow all users to access the mount.

requires:

```text id="fstftp017"
/etc/fuse.conf
```

contains:

```text id="fstftp018"
user_allow_other
```

---

## `x-systemd.automount`

```text id="fstftp019"
x-systemd.automount
```

very important.

systemd creates:

```text id="fstftp020"
automount unit
```

filesystem mounts:

* automatically
* when directory is accessed

example:

```bash id="fstftp021"
cd /mnt/ftp
```

triggers automatic mount.

---

## `_netdev`

```text id="fstftp022"
_netdev
```

tells system:

* this is a network filesystem

important because:

* network may not yet be ready during boot

---

# test fstab safely

VERY important:

* never reboot immediately after editing `/etc/fstab`

test first:

```bash id="fstftp023"
sudo mount -a
```

If no errors:

* configuration is likely valid.

---

# reboot test

```bash id="fstftp024"
sudo reboot
```

after reboot:

```bash id="fstftp025"
cd /mnt/ftp
```

this should:

* trigger automount
* connect to FTP automatically

---

# verify mount

```bash id="fstftp026"
mount | grep ftp
```

or:

```bash id="fstftp027"
df -h
```

---

# recommended secure setup

## `/root/.netrc`

```text id="fstftp028"
machine 192.168.56.101
login mohammad
password yourpassword
```

permissions:

```bash id="fstftp029"
sudo chmod 600 /root/.netrc
```

---

# troubleshooting

## if mount hangs

common fix:

```text id="fstftp030"
disable_epsv
```

Example fstab:

```text id="fstftp031"
curlftpfs#192.168.56.101/ /mnt/ftp fuse noauto,allow_other,x-systemd.automount,_netdev,disable_epsv 0 0
```

Very common in:

* VirtualBox
* NAT/host-only networking

---

# if allow_other fails

Edit:

```bash id="fstftp032"
sudo nano /etc/fuse.conf
```

Uncomment:

```text id="fstftp033"
user_allow_other
```

---

# important practical note

Using:

```text id="fstftp034"
x-systemd.automount
```

is MUCH better than direct boot mount because:

* boot does not freeze if FTP unavailable
* mount happens lazily/on-demand

---

# mount lifecycle

## before access

```text id="fstftp035"
/mnt/ftp exists but not mounted
```

---

## first access

```bash id="fstftp036"
ls /mnt/ftp
```

systemd:

* automatically mounts FTP

---

## after idle timeout

may unmount automatically depending on configuration.

---

# important security warning

FTP:

* unencrypted
* insecure over real networks

Good for:

* labs
* VM experiments
* learning mounts

Not ideal for:

* production
* internet exposure

---

# modern alternative

Usually better:

## SSHFS

Example:

```bash id="fstftp037"
sshfs mohammad@192.168.56.101:/home/mohammad /mnt/ssh
```

Advantages:

* encrypted
* simpler
* more reliable
* better Linux integration

---

# useful commands summary

edit fstab:

```bash id="fstftp038"
sudo nano /etc/fstab
```

test mounts:

```bash id="fstftp039"
sudo mount -a
```

check mounted filesystems:

```bash id="fstftp040"
mount
```

show disk usage:

```bash id="fstftp041"
df -h
```

manual unmount:

```bash id="fstftp042"
sudo fusermount -u /mnt/ftp
```

reboot:

```bash id="fstftp043"
sudo reboot
```
