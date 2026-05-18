# 259. Extra Lecture (Optional): Securing FTP Server Mounts with `.netrc` Files

## allowing access to other users

by default:

* a FUSE mount from `curlftpfs` is usually only accessible to the mounting user.

To allow all users to access the mounted FTP filesystem:

```bash id="netrc001"
sudo curlftpfs -o allow_other \
ftp://mohammad:3141@192.168.56.101 /mnt/ftp
```

---

# `allow_other`

```text id="netrc002"
-o allow_other
```

means:

* all local users can access the mounted filesystem.

Without it:

* only the mounting user can access the mount.

---

# important FUSE configuration

sometimes `allow_other` fails with:

```text id="netrc003"
fusermount: option allow_other only allowed if 'user_allow_other' is set
```

Fix:

```bash id="netrc004"
sudo nano /etc/fuse.conf
```

Uncomment:

```ini id="netrc005"
user_allow_other
```

Save.

---

# unmounting

```bash id="netrc006"
sudo fusermount -u /mnt/ftp
```

or:

```bash id="netrc007"
sudo umount /mnt/ftp
```

---

# problem with storing credentials in `/etc/fstab`

BAD practice:

```text id="netrc008"
ftp://username:password@server
```

inside:

```text id="netrc009"
/etc/fstab
```

because:

* passwords become visible
* security risk
* readable by system users

---

# solution: `.netrc`

FTP credentials can be stored securely inside:

```text id="netrc010"
~/.netrc
```

for root mounts:

```text id="netrc011"
/root/.netrc
```

---

# create `.netrc`

```bash id="netrc012"
sudo nano /root/.netrc
```

Example:

```text id="netrc013"
machine 192.168.56.101
login mohammad
password pass
```

---

# important typo correction

wrong:

```text id="netrc014"
mahcine
```

correct:

```text id="netrc015"
machine
```

---

# secure permissions

VERY important:

```bash id="netrc016"
sudo chmod 700 /root/.netrc
```

or even stricter:

```bash id="netrc017"
sudo chmod 600 /root/.netrc
```

recommended:

```text id="netrc018"
600
```

---

# why permissions matter

FTP tools refuse insecure `.netrc` files because:

* credentials are stored in plaintext.

---

# mounting without credentials in URL

After `.netrc` exists:

```bash id="netrc019"
sudo curlftpfs ftp://192.168.56.101/ /mnt/ftp
```

Credentials are automatically read from:

```text id="netrc020"
/root/.netrc
```

---

# example with allow_other

```bash id="netrc021"
sudo curlftpfs -o allow_other \
ftp://192.168.56.101/ /mnt/ftp
```

---

# create mount directory

```bash id="netrc022"
sudo mkdir -p /mnt/ftp
```

---

# verify mount

```bash id="netrc023"
mount | grep ftp
```

or:

```bash id="netrc024"
df -h
```

---

# automatic mounting with `/etc/fstab`

Example:

```text id="netrc025"
curlftpfs#192.168.56.101 /mnt/ftp fuse allow_other,_netdev 0 0
```

---

# `_netdev`

important option:

```text id="netrc026"
_netdev
```

means:

* wait for network before mounting

important for:

* boot-time network mounts

---

# testing fstab safely

after editing `/etc/fstab`:

DO NOT reboot immediately.

Test first:

```bash id="netrc027"
sudo mount -a
```

If no errors:

* configuration is likely correct.

---

# important security warning

FTP is:

```text id="netrc028"
NOT encrypted
```

Credentials travel in plaintext.

For real systems:

* prefer:

```text id="netrc029"
SFTP / SSHFS
```

instead.

---

# SSHFS equivalent (much safer)

Example:

```bash id="netrc030"
sshfs mohammad@192.168.56.101:/home/mohammad /mnt/ssh
```

Advantages:

* encrypted
* easier
* better Linux integration
* more secure

---

# useful commands summary

install curlftpfs:

```bash id="netrc031"
sudo apt install curlftpfs
```

create mount point:

```bash id="netrc032"
sudo mkdir -p /mnt/ftp
```

mount FTP:

```bash id="netrc033"
sudo curlftpfs ftp://192.168.56.101/ /mnt/ftp
```

allow all users:

```bash id="netrc034"
-o allow_other
```

unmount:

```bash id="netrc035"
sudo fusermount -u /mnt/ftp
```

edit netrc:

```bash id="netrc036"
sudo nano /root/.netrc
```

secure permissions:

```bash id="netrc037"
sudo chmod 600 /root/.netrc
```

test fstab:

```bash id="netrc038"
sudo mount -a
```
