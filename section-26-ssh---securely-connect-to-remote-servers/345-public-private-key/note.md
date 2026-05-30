## 345. SSH Public Key Authentication

# SSH Key-Based Authentication

## Overview

Besides password authentication, SSH also supports authentication using a public/private key pair.

This method is:

* More secure than passwords
* More convenient
* Widely used in production environments
* The standard authentication method for cloud servers

Examples:

* AWS EC2
* Google Cloud
* Azure Virtual Machines
* Kubernetes nodes
* Production Linux servers

---

# The Idea Behind Public/Private Keys

SSH uses asymmetric cryptography.

A key pair consists of:

```text
Private Key
      +
Public Key
```

The two keys are mathematically related.

---

## Private Key

The private key:

* Must remain secret
* Must never be shared
* Stays on your local machine
* Is used to prove your identity

Example location:

```bash
~/.ssh/id_rsa
```

---

## Public Key

The public key:

* Can be shared freely
* Is copied to servers
* Is used to verify ownership of the private key

Example location:

```bash
~/.ssh/id_rsa.pub
```

---

# Authentication Process

## Traditional Password Authentication

```text
Client
   │
   ▼
Send Password
   │
   ▼
Server Verifies Password
```

Problems:

* Passwords can be guessed
* Passwords can be stolen
* Vulnerable to brute-force attacks

---

## Public Key Authentication

```text
Client
   │
   ▼
Prove Ownership of Private Key
   │
   ▼
Server Verifies Using Public Key
```

The private key never leaves the client machine.

This makes authentication significantly more secure.

---

# Generating an SSH Key Pair

## Generate RSA Keys

```bash
ssh-keygen -t rsa -b 4096
```

### Explanation

| Option    | Meaning                 |
| --------- | ----------------------- |
| `-t rsa`  | Use RSA algorithm       |
| `-b 4096` | Generate a 4096-bit key |

---

## Example Output

```text
Generating public/private rsa key pair.
Enter file in which to save the key:
```

Press:

```text
Enter
```

to accept the default location.

---

## Passphrase Prompt

You may optionally enter a passphrase.

### Benefits

* Adds an additional layer of security
* Protects the private key if it is stolen

### Drawback

* Must be entered when using the key

---

# Generated Files

After generation:

```bash
ls ~/.ssh
```

Example:

```text
id_rsa
id_rsa.pub
```

---

## Private Key

```bash
~/.ssh/id_rsa
```

Contains:

```text
Private Key
```

Never share this file.

---

## Public Key

```bash
~/.ssh/id_rsa.pub
```

Contains:

```text
Public Key
```

This file is intended to be copied to remote servers.

---

# Installing the Public Key on a Server

For key authentication to work, the public key must be stored on the remote server.

---

## Authorized Keys File

SSH looks for:

```bash
~/.ssh/authorized_keys
```

on the remote machine.

Example:

```text
/home/mohammad/.ssh/authorized_keys
```

---

# Manual Installation

## Step 1: Connect to the Server

```bash
ssh user@server
```

---

## Step 2: Create the `.ssh` Directory

```bash
mkdir -p ~/.ssh
```

---

## Step 3: Create the Authorized Keys File

```bash
touch ~/.ssh/authorized_keys
```

---

## Step 4: Copy the Public Key

Display the public key:

```bash
cat ~/.ssh/id_rsa.pub
```

Copy the entire line and append it to:

```bash
~/.ssh/authorized_keys
```

---

# Correct Permissions

SSH is very strict about file permissions.

---

## `.ssh` Directory

```bash
chmod 700 ~/.ssh
```

Meaning:

```text
Owner: Full Access
Others: No Access
```

---

## `authorized_keys`

```bash
chmod 600 ~/.ssh/authorized_keys
```

Meaning:

```text
Owner: Read + Write
Others: No Access
```

---

# Automatic Installation (Recommended)

The easiest method is:

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
```

---

## Example

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub mohammad@ubuntu.local
```

---

## What Happens?

`ssh-copy-id` automatically:

1. Connects to the server.
2. Creates the `.ssh` directory if necessary.
3. Creates `authorized_keys`.
4. Copies the public key.
5. Sets appropriate permissions.

---

# Verifying Installation

On the remote server:

```bash
ls ~/.ssh
```

Expected:

```text
authorized_keys
```

---

## View Authorized Keys

```bash
cat ~/.ssh/authorized_keys
```

You should see your public key.

---

# Logging In Using the Key

After the public key is installed:

```bash
ssh user@server
```

SSH automatically uses:

```bash
~/.ssh/id_rsa
```

for authentication.

---

# Authentication Flow

```text
Client
 ├── Private Key (id_rsa)
 │
 ▼
Server
 ├── Public Key (authorized_keys)
 │
 ▼
Authentication Successful
```

No password is required.

---

# Real-World Example

Suppose:

### Local Machine

```text
Laptop
```

contains:

```bash
~/.ssh/id_rsa
```

---

### Remote Server

```text
ubuntu-server
```

contains:

```bash
~/.ssh/authorized_keys
```

---

### Login

```bash
ssh mohammad@ubuntu-server
```

Authentication occurs automatically using the key pair.

---

# Why SSH Keys Are More Secure

Compared to passwords:

✔ Much harder to brute-force

✔ Private key never leaves the client

✔ Can be protected with a passphrase

✔ Convenient for automation

✔ Industry standard for cloud environments

---

# Security Warning

Never share:

```bash
~/.ssh/id_rsa
```

Doing so allows anyone possessing that file to authenticate as you.

---

## Safe to Share

```bash
~/.ssh/id_rsa.pub
```

The public key is designed to be distributed.

---

# Common Modern Algorithms

Although RSA is still widely used:

```bash
ssh-keygen -t rsa -b 4096
```

many modern systems prefer:

```bash
ssh-keygen -t ed25519
```

because:

* Smaller keys
* Faster operations
* Strong security

You will commonly encounter both RSA and ED25519 keys in production systems.

---

# Important Takeaway

SSH key authentication works by:

```text
Private Key (Client)
            +
Public Key (Server)
            =
Secure Authentication
```

The private key stays on your machine, while the public key is stored in:

```bash
~/.ssh/authorized_keys
```

This method is more secure, more convenient, and is the preferred way to authenticate to Linux servers in professional environments.
