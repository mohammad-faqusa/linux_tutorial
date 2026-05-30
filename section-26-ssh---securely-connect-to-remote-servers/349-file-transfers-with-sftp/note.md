# 349. File Transfers with SFTP

## SSH: SFTP

### Overview

* SSH can be used not only for remote terminal access, but also for secure file transfers.
* The file transfer protocol built on top of SSH is called:

```text
SFTP (SSH File Transfer Protocol)
```

* SFTP encrypts all transferred data using SSH.
* Most servers that support SSH also support SFTP by default.
* SFTP is commonly used for:

  * Uploading files to servers
  * Downloading files from servers
  * Managing remote directories
  * Deploying applications

---

## Advantages of SFTP

Compared to traditional FTP:

| FTP                         | SFTP                      |
| --------------------------- | ------------------------- |
| Unencrypted                 | Encrypted                 |
| Password visible on network | Password protected by SSH |
| Separate authentication     | Uses SSH authentication   |
| Less secure                 | Highly secure             |

Because of these advantages, SFTP has largely replaced FTP on modern systems.

---

## Graphical File Transfers

### Linux

Many Linux desktop environments support SFTP directly through the file manager.

#### Example

1. Open the file manager.
2. Select:

```text
Other Locations
```

3. Choose:

```text
Connect to Server
```

4. Enter:

```text
sftp://user@server
```

Example:

```text
sftp://mohammad@192.168.1.15
```

The remote server will appear like a normal folder.

---

## Terminal File Transfers

### SCP (Secure Copy)

Linux provides the:

```bash
scp
```

command for transferring files over SSH.

---

### Copy a File from Server to Local Machine

```bash
scp user@server:file.txt .
```

Example:

```bash
scp mohammad@ubuntu.local:file.txt .
```

Downloads:

```text
file.txt
```

to the current directory.

---

### Copy a File to a Server

```bash
scp file.txt user@server:/home/user/
```

Example:

```bash
scp report.pdf mohammad@ubuntu.local:/home/mohammad/
```

Uploads:

```text
report.pdf
```

to the remote server.

---

### Copy an Entire Directory

Use:

```bash
-r
```

for recursive copying.

```bash
scp -r project/ user@server:/home/user/
```

Example:

```bash
scp -r spring-project/ mohammad@ubuntu.local:/home/mohammad/
```

Copies the entire directory and its contents.

---

## Using a Custom SSH Port

If SSH is configured on a non-default port:

```bash
scp -P 2222 file.txt user@server:/home/user/
```

### Important

SCP uses:

```bash
-P
```

(uppercase P)

while SSH uses:

```bash
-p
```

(lowercase p)

Example:

```bash
scp -P 2222 report.pdf mohammad@ubuntu.local:/home/mohammad/
```

---

## General SCP Syntax

### Download

```bash
scp -P PORT user@host:source destination
```

Example:

```bash
scp -P 2222 mohammad@ubuntu.local:/home/mohammad/file.txt .
```

---

### Upload

```bash
scp -P PORT source user@host:destination
```

Example:

```bash
scp -P 2222 file.txt mohammad@ubuntu.local:/home/mohammad/
```

---

## Cyberduck

### Overview

Cyberduck is a graphical file transfer client that supports:

* SFTP
* FTP
* WebDAV
* Amazon S3
* Google Cloud Storage
* Azure Storage

Official website:

```text
https://cyberduck.io
```

---

### Supported Platforms

* macOS
* Windows

---

### Creating a Connection

Enter:

* Protocol: SFTP
* Server: hostname or IP address
* Username
* Password or SSH key

Example:

```text
Protocol: SFTP
Server: ubuntu.local
Username: mohammad
Port: 22
```

---

## Authentication Methods

SFTP supports the same authentication methods as SSH:

### Password Authentication

```text
Username + Password
```

---

### Key Authentication

```text
Public Key + Private Key
```

Recommended for production environments.

---

## Practical Example

Suppose:

### Local Machine

```text
Laptop
```

### Remote Server

```text
ubuntu.local
```

### Upload a File

```bash
scp report.pdf mohammad@ubuntu.local:/home/mohammad/
```

---

### Download a File

```bash
scp mohammad@ubuntu.local:/home/mohammad/report.pdf .
```

---

## Real-World Use Cases

SFTP is commonly used for:

* Uploading website files
* Deploying applications
* Transferring backups
* Managing cloud servers
* Moving log files
* Sharing files securely

---

## Important Takeaway

* SFTP provides secure file transfers over SSH.
* Most SSH servers support SFTP automatically.
* Linux users commonly use:

```bash
scp
```

for terminal-based transfers.

* Graphical clients such as Cyberduck provide an easy-to-use interface for managing files on remote servers.
* SFTP is the secure modern replacement for traditional FTP.
