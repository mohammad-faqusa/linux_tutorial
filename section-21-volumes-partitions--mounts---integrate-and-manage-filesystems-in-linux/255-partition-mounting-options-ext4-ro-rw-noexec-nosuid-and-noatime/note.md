## 255. Partition Mounting Options (ext4): `ro`, `rw`, `noexec`, `nosuid`, and `noatime`

# Mount Options

When mounting a filesystem, Linux allows additional behaviors to be configured using:

```bash id="d9g4ee"
-o
```

These options affect:

* security
* performance
* execution permissions
* filesystem behavior

---

# Syntax

Example:

```bash id="8c5n4r"
sudo mount -o ro,noexec,nosuid,noatime /dev/sdb1 /mnt/backups
```

Explanation:

* multiple options separated with commas
* no spaces between options

---

# Common ext4 Mount Options

---

# 1. `ro` — Read Only

Mounts the filesystem as:

* read-only

Example:

```bash id="qgjb7j"
sudo mount -o ro /dev/sdb1 /mnt/backups
```

Effects:

* files can be read
* files cannot be modified
* prevents accidental changes

---

# Real-World Usage

Useful for:

* backup drives
* recovery mode
* damaged filesystems
* forensic analysis
* installation media

---

# Attempting Write Operations

Example:

```bash id="wdujlwm"
touch file.txt
```

Result:

```bash id="l3jmfm"
Read-only file system
```

---

# 2. `rw` — Read Write

Default behavior.

Example:

```bash id="58t1tf"
sudo mount -o rw /dev/sdb1 /mnt/backups
```

Allows:

* reading
* writing
* deleting
* modifying

---

# 3. `noexec`

Prevents direct execution of executable files from the mounted filesystem.

Example:

```bash id="yqeh9o"
sudo mount -o noexec /dev/sdb1 /mnt/backups
```

---

# Security Benefit

Very useful for:

* USB drives
* external storage
* temporary directories
* untrusted media

Prevents malicious binaries/scripts from executing directly.

---

# Important Clarification

`noexec` does NOT prevent:

* reading files
* scripts being interpreted manually

---

# Example Practice

## Create script

```bash id="hmkvoy"
nano script.sh
```

Example content:

```bash id="fzmv8n"
echo "Hello"
```

---

## Make executable

```bash id="cv4jql"
chmod +x script.sh
```

---

## Mount with `noexec`

```bash id="3b2ycw"
sudo mount -o noexec /dev/sdb1 /mnt/backups
```

---

## Try direct execution

```bash id="vcwx76"
./script.sh
```

Possible result:

```bash id="wv4hbd"
Permission denied
```

---

# Why Does `bash script.sh` Still Work?

This works:

```bash id="5rdbfe"
bash script.sh
```

because:

* Bash itself is the executable
* Bash reads the file as data
* the filesystem is not directly executing the script

Important distinction:

* interpreter executes
* filesystem execution restriction bypassed

---

# 4. `nosuid`

Disables:

* SUID
* SGID

on the mounted filesystem.

Example:

```bash id="3g8cmo"
sudo mount -o nosuid /dev/sdb1 /mnt/backups
```

---

# What is SUID?

SUID:

* Set User ID

Allows executable files to run:

* with owner's permissions
* instead of current user's permissions

Example:

```bash id="0c5f04"
-rwsr-xr-x
```

Notice:

```bash id="8hffbm"
s
```

in permissions.

---

# Why Can This Be Dangerous?

A malicious executable with SUID:

* could gain elevated privileges
* potentially become a security risk

---

# Why `nosuid` Helps

Linux ignores SUID/SGID bits on that filesystem.

Very important for:

* USB devices
* shared storage
* removable media
* external drives

---

# 5. `noatime`

Disables updating:

* access timestamps

when files are read.

Example:

```bash id="u8k7ws"
sudo mount -o noatime /dev/sdb1 /mnt/backups
```

---

# What is Access Time (`atime`)?

Linux stores timestamps:

* creation time
* modification time
* access time

Access time updates whenever a file is read.

---

# Why Disable It?

Updating access timestamps causes:

* additional disk writes
* performance overhead

Especially noticeable on:

* SSDs
* databases
* high-performance systems

---

# Benefits of `noatime`

* better performance
* reduced disk writes
* improved SSD lifespan

Commonly used on:

* servers
* Docker hosts
* databases
* high-I/O systems

---

# Viewing Mount Options

## Using `mount`

```bash id="kpsb3m"
mount
```

Example:

```bash id="u1r9ia"
/dev/sdb1 on /mnt/backups type ext4 (ro,noexec,nosuid,noatime)
```

---

# Combining Options

Example:

```bash id="4r7vwf"
sudo mount -o ro,noexec,nosuid,noatime /dev/sdb1 /mnt/backups
```

Effects:

* read-only
* no direct execution
* ignore SUID/SGID
* no access-time updates

---

# Unmounting

```bash id="1jtt7z"
sudo umount /mnt/backups
```

or:

```bash id="1ubkzx"
sudo umount /dev/sdb1
```

---

# Re-Mounting With Different Options

Example:

```bash id="u5pif7"
sudo mount /dev/sdb1 /mnt/backups
```

Now mounted again with:

* default options

usually:

```bash id="hqg6ws"
rw
```

---

# Important Security Concept

Mount options are a major Linux security layer.

Administrators often use them to:

* harden systems
* restrict execution
* protect sensitive storage
* reduce attack surfaces

---

# Relation to Docker and Containers

Mount options are extremely important later for:

* Docker bind mounts
* container security
* Kubernetes volumes
* read-only containers

Example:

```bash id="xdm4ln"
docker run --read-only
```

or:

```bash id="0aqt8t"
docker run -v /host:/container:ro
```

These concepts directly come from Linux mount mechanics.

---

# Very Important Practical Insight

Even though:

```bash id="xjlwmv"
chmod +x script.sh
```

adds execute permissions,

mount option:

```bash id="c8o6px"
noexec
```

overrides execution behavior at filesystem level.

This demonstrates an important Linux principle:

Filesystem mount policies can override file-level permissions.
