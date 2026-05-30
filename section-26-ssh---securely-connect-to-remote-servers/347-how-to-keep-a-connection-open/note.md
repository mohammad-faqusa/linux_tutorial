## 347. How to Keep an SSH Connection Open

# SSH: Preventing Connection Drops

## The Problem

By default, SSH creates a TCP connection between a client and a server.

```text
SSH Client
     │
     ▼
SSH Server
```

If the connection remains idle for a long period of time, it may be terminated by:

* Routers
* Firewalls
* NAT devices
* The operating system
* Network infrastructure

As a result, an SSH session may disconnect while:

* Taking a lunch break
* Taking a coffee break
* Reading documentation
* Monitoring logs without typing commands

---

## Example

Suppose you connect to a server:

```bash
ssh mohammad@server
```

Then you leave your computer for 30 minutes.

When you return and type:

```bash
ls
```

you may see:

```text
Connection reset by peer
```

or

```text
Broken pipe
```

because the connection was closed due to inactivity.

---

# The Solution: Keep-Alive Messages

## What Is a Keep-Alive?

A keep-alive is a small packet sent periodically to prevent the connection from being considered idle.

The idea is:

```text
Client
   │
   ├── Keep-Alive Packet
   │
   ├── Keep-Alive Packet
   │
   └── Keep-Alive Packet
Server
```

The packets contain no useful data; they simply inform the network that the connection is still active.

---

# SSH Client Configuration

SSH supports automatic keep-alive messages.

These settings are usually configured on the client machine.

---

## User-Specific Configuration

Configuration file:

```bash
~/.ssh/config
```

This affects only the current user.

---

## System-Wide Configuration

Configuration file:

```bash
/etc/ssh/ssh_config
```

This affects all users on the system.

---

# Example Configuration

Open the SSH configuration file:

```bash
nano ~/.ssh/config
```

Add:

```text
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

---

# Understanding the Settings

## Host *

```text
Host *
```

The asterisk means:

```text
Apply these settings to all SSH connections.
```

---

## ServerAliveInterval

```text
ServerAliveInterval 60
```

Meaning:

* Every 60 seconds
* The SSH client sends a keep-alive message

Example timeline:

```text
0 sec    Connection established
60 sec   Keep-alive sent
120 sec  Keep-alive sent
180 sec  Keep-alive sent
```

This prevents the connection from appearing idle.

---

## ServerAliveCountMax

```text
ServerAliveCountMax 3
```

Meaning:

* If the server fails to respond to 3 consecutive keep-alive messages,
* SSH assumes the connection is dead and disconnects.

Example:

```text
Keep-alive #1 → No response
Keep-alive #2 → No response
Keep-alive #3 → No response
```

Result:

```text
SSH Connection Closed
```

---

# Practical Example

Configuration:

```text
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

Maximum tolerated outage:

```text
60 seconds × 3
=
180 seconds
=
3 minutes
```

If the server becomes unreachable for more than 3 minutes, SSH disconnects.

---

# Why This Is Useful

Without keep-alives:

```text
Idle Connection
        ↓
Router Removes Session
        ↓
SSH Disconnects
```

With keep-alives:

```text
Keep-Alive Traffic
        ↓
Connection Appears Active
        ↓
Session Remains Open
```

---

# Verify the Configuration

Display your SSH configuration:

```bash
cat ~/.ssh/config
```

Example:

```text
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

---

# Real-World Usage

Keep-alive settings are especially useful when:

* Managing cloud servers
* Working over unstable Wi-Fi
* Using VPN connections
* Monitoring logs for long periods
* Running long administrative tasks

Example:

```bash
ssh ubuntu@aws-server
```

You can leave the session idle for extended periods without being disconnected.

---

# Related Server-Side Settings

Administrators can also configure keep-alive behavior on the SSH server using:

```bash
/etc/ssh/sshd_config
```

Common options:

```text
ClientAliveInterval
ClientAliveCountMax
```

These control keep-alive behavior from the server's perspective.

---

# Important Takeaway

Idle SSH connections may be terminated by network devices or firewalls.

To prevent unexpected disconnects, configure SSH keep-alives:

```text
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

This causes the client to send a keep-alive packet every 60 seconds and tolerate up to 3 missed responses before closing the connection.

It is a simple but highly recommended configuration for anyone who regularly manages remote Linux servers.
