# 348. SSH Fingerprints

## SSH: Host Key Fingerprints

### Overview

* When we connect to an SSH server for the first time, the server presents its host key.
* SSH calculates a fingerprint from this key and asks whether we trust the server.
* If we accept it, the fingerprint is stored locally in:

```bash
~/.ssh/known_hosts
```

* Every SSH server has its own unique fingerprint.

---

## First Connection Example

```bash
ssh mohammad@ubuntu.local
```

SSH may display:

```text
The authenticity of host 'ubuntu.local' can't be established.

ED25519 key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxx

Are you sure you want to continue connecting (yes/no)?
```

If we type:

```text
yes
```

the fingerprint is added to:

```bash
~/.ssh/known_hosts
```

Future connections will verify that the server still presents the same fingerprint.

---

## Invalid Fingerprint Warning

If we later connect to the same server and receive a warning such as:

```text
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```

we should **never ignore it**.

Possible reasons include:

* We are connecting to the wrong server.
* The hostname or DNS record resolves to another machine.
* The server has been reinstalled and generated new SSH keys.
* We are the victim of a Man-in-the-Middle (MITM) attack.

---

## Man-in-the-Middle (MITM) Attack

### Normal Connection

```text
SSH Client
     │
     ▼
SSH Server
```

### MITM Attack

```text
SSH Client
     │
     ▼
Attacker
     │
     ▼
SSH Server
```

The attacker pretends to be the server.

Because the attacker uses a different SSH key, the fingerprint changes and SSH warns us.

This is one of the main security benefits of SSH fingerprints.

---

## Demonstrating a Fingerprint Mismatch

We can simulate the problem by editing:

```bash
nano ~/.ssh/known_hosts
```

and modifying the stored fingerprint.

The next time we connect:

```bash
ssh mohammad@ubuntu.local
```

SSH detects that the fingerprint no longer matches and displays a warning.

---

## Verifying the Fingerprint

Instead of blindly accepting a fingerprint, we can verify it manually.

On the server:

```bash
ssh-keygen -E sha256 -lf /etc/ssh/ssh_host_ed25519_key.pub
```

Example output:

```text
256 SHA256:AbCdEfGhIjKlMnOpQrStUvWxYz
```

Compare this value with the fingerprint displayed by the SSH client.

---

## If the Fingerprints Match

```text
Server Fingerprint
        =
SSH Displayed Fingerprint
```

Then we know we are communicating with the correct server and can safely trust it.

---

## Important Files

### Client Side

Known server fingerprints:

```bash
~/.ssh/known_hosts
```

### Server Side

Server public host key:

```bash
/etc/ssh/ssh_host_ed25519_key.pub
```

---

## Important Takeaway

* SSH stores trusted server fingerprints in:

```bash
~/.ssh/known_hosts
```

* A fingerprint warning should never be ignored.
* It may indicate:

  * A wrong server
  * A DNS problem
  * A server rebuild
  * A potential Man-in-the-Middle attack
* The safest approach is to verify the server fingerprint manually before trusting it.
