## 344. How to Avoid Locking Yourself Out of a Remote Server

# Why This Is Important

When administering a remote Linux server through SSH, one of the worst mistakes you can make is accidentally locking yourself out of the server.

Examples:

* Misconfiguring `sshd_config`
* Changing the SSH port incorrectly
* Misconfiguring the firewall
* Restricting user access incorrectly
* Stopping the SSH service

Recovering from such mistakes can be difficult and may require:

* Physical access to the server
* A cloud provider's recovery console
* Rescue mode or emergency boot options

---

# The Golden Rule

Whenever you modify anything related to SSH:

```text
Never close your current SSH session until you have verified that a new SSH connection works.
```

This is one of the most important habits of Linux system administrators.

---

# Why Existing SSH Sessions Often Continue Working

An already established SSH connection is usually not affected by configuration changes.

Example:

```bash
sudo systemctl stop sshd
```

---

## Existing SSH Session

```text
Current SSH Session
        │
        ▼
Still Active
```

The terminal that is already connected continues to work normally.

You can still execute commands:

```bash
pwd
ls
whoami
```

---

## New SSH Connections

```text
New SSH Connection
        │
        ▼
Rejected
```

Because the SSH daemon is no longer running, new connections cannot be established.

Example:

```bash
ssh mohammad@server
```

Result:

```text
Connection refused
```

---

# Recommended Procedure

## Step 1: Keep Your Current SSH Session Open

Suppose you are already connected:

```bash
ssh mohammad@server
```

Do not close this terminal.

Keep it open until you have verified that everything works correctly.

---

## Step 2: Make Your Changes

Examples:

* Change the SSH port
* Disable root login
* Configure `AllowUsers`
* Configure SSH keys
* Modify firewall rules

---

## Step 3: Validate the Configuration

Before restarting SSH, always test the configuration:

```bash
sudo sshd -t
```

---

### Successful Validation

No output usually means:

```text
Configuration is valid.
```

---

### Configuration Error

Example:

```text
Bad configuration option
```

or:

```text
Missing argument
```

Fix any errors before proceeding.

---

# Step 4: Restart the SSH Service

Ubuntu / Debian:

```bash
sudo systemctl restart ssh
```

---

CentOS / Rocky Linux / RHEL:

```bash
sudo systemctl restart sshd
```

---

# Step 5: Open a Second Terminal

Before closing your original session, open another terminal window and attempt a new connection.

Example:

```bash
ssh mohammad@server
```

or:

```bash
ssh mohammad@server -p 2222
```

if you changed the SSH port.

---

# Verify the New Connection

If the new connection succeeds:

✔ SSH configuration is valid

✔ Firewall rules are correct

✔ Authentication works

✔ SSH service is running properly

Only then should you close the original SSH session.

---

# Administrator Best Practice

Always follow this sequence:

```text
Keep Existing SSH Session Open
            ↓
Modify Configuration
            ↓
Validate Configuration (sshd -t)
            ↓
Restart SSH
            ↓
Open New SSH Session
            ↓
Verify Success
            ↓
Close Original Session
```

---

# Never Do This

```text
Modify Configuration
        ↓
Restart SSH
        ↓
Close Existing Session
        ↓
Try New Connection
```

If something is wrong, you may completely lose access to the server.

---

# Practical Example

Suppose you change:

```text
Port 22
```

to:

```text
Port 2222
```

and restart SSH.

However, you forget to update the firewall.

Result:

```text
SSH listens on 2222
        +
Firewall blocks 2222
        =
No new connections
```

If your original SSH session is still open, you can immediately fix the problem:

```bash
sudo ufw allow 2222/tcp
```

or

```bash
sudo firewall-cmd --add-port=2222/tcp --permanent
```

Without the original session, you could be locked out completely.

---

# Important Takeaway

When working on remote servers:

```text
One Active SSH Session
            +
sshd -t
            +
Test a Second Connection
```

is your safety net.

Always remember:

```text
Never close your last working SSH session until you have successfully established a new SSH connection.
```

This simple habit can prevent hours of troubleshooting and is considered a standard best practice among Linux administrators, DevOps engineers, and cloud engineers.
