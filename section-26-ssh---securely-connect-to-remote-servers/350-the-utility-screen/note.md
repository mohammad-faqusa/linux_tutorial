# 350. The Utility `screen`

## What Is `screen`?

### Overview

* `screen` is a terminal multiplexer.
* It allows multiple terminal sessions to run inside a single SSH connection.
* A `screen` session continues running even if the SSH connection is lost or disconnected.
* This makes it extremely useful when working on remote servers.

---

## Why Use `screen`?

Normally:

```text
SSH Client
     │
     ▼
Terminal Process
```

If the SSH connection is closed:

```text
SSH Connection Lost
        ↓
Terminal Closes
        ↓
Running Program Stops
```

---

### Example

Suppose you start:

```bash
long-running-script.sh
```

or:

```bash
docker compose up
```

and then:

* Close your laptop
* Lose internet connectivity
* Disconnect SSH

The process may terminate.

---

## Using `screen`

With `screen`:

```text
SSH Client
     │
     ▼
Screen Session
     │
     ▼
Program
```

If SSH disconnects:

```text
SSH Connection Lost
        ↓
Screen Session Continues
        ↓
Program Keeps Running
```

You can reconnect later and continue where you left off.

---

# Installing Screen

### Ubuntu / Debian

```bash
sudo apt install screen
```

---

### CentOS / Rocky Linux / RHEL

```bash
sudo dnf install screen
```

---

# Starting a New Screen Session

Create a new session:

```bash
screen
```

You are now inside a virtual terminal managed by `screen`.

Anything started inside this terminal belongs to the screen session.

---

## Example

```bash
screen
```

Then:

```bash
ping google.com
```

The command continues running inside the screen session.

---

# Detaching from a Session

One of the most useful features of `screen` is detaching.

### Keyboard Shortcut

```text
CTRL + A
then
CTRL + D
```

This means:

1. Hold `CTRL`
2. Press `A`
3. Release
4. Press `D`

---

## Result

```text
Screen Session Continues Running
          ↓
You Return To Normal Shell
```

Your programs continue running in the background.

---

# Listing Existing Sessions

Display all active screen sessions:

```bash
screen -ls
```

Example output:

```text
There is a screen on:
    12345.pts-0.server    (Detached)

1 Socket in /run/screen/S-user.
```

---

## Explanation

```text
12345.pts-0.server
```

is the session identifier.

```text
Detached
```

means the session is running but not currently attached to a terminal.

---

# Reattaching to a Session

Reconnect to an existing session:

```bash
screen -x SESSION_ID
```

Example:

```bash
screen -x 12345
```

or:

```bash
screen -x 12345.pts-0.server
```

---

## Result

You return to exactly the same terminal state.

Example:

```bash
ping google.com
```

is still running where you left it.

---

# Named Sessions

Instead of using numeric IDs, you can create named sessions.

### Create a Named Session

```bash
screen -S backup
```

---

### List Sessions

```bash
screen -ls
```

Example:

```text
12345.backup
```

---

### Reattach

```bash
screen -x backup
```

or:

```bash
screen -r backup
```

---

# Practical Example

Suppose you are connected to a remote server:

```bash
ssh mohammad@server
```

Start a screen session:

```bash
screen -S springboot
```

Run your application:

```bash
java -jar app.jar
```

Detach:

```text
CTRL + A
CTRL + D
```

The Spring Boot application continues running.

Later:

```bash
screen -r springboot
```

returns you to the same terminal.

---

# Common Screen Commands

| Command                     | Description                 |
| --------------------------- | --------------------------- |
| `screen`                    | Start a new session         |
| `screen -S name`            | Start a named session       |
| `screen -ls`                | List sessions               |
| `screen -x session`         | Attach to session           |
| `screen -r session`         | Resume detached session     |
| `screen -d session`         | Detach another user/session |
| `screen -X -S session quit` | Terminate a session         |

---

# Difference Between Detach and Exit

### Detach

```text
CTRL + A
CTRL + D
```

Result:

```text
Session Continues Running
```

---

### Exit

```bash
exit
```

or

```bash
CTRL + D
```

inside the shell.

Result:

```text
Screen Session Terminates
```

if no processes remain.

---

# Real-World Use Cases

`screen` is commonly used for:

* Long-running scripts
* Application deployments
* Server maintenance
* Monitoring logs
* Running Docker containers
* Backup operations
* Data migrations

---

# Screen vs SSH Disconnects

Without `screen`:

```text
SSH Disconnect
       ↓
Program Stops
```

With `screen`:

```text
SSH Disconnect
       ↓
Screen Continues
       ↓
Program Continues
```

---

# Alternative: tmux

A more modern alternative is:

```text
tmux
```

Many Linux administrators prefer `tmux` today because it provides:

* Window splitting
* Better session management
* More features

However, `screen` is simpler and is still widely available on Linux systems.

---

# Important Takeaway

`screen` is a terminal multiplexer that allows programs to continue running even after an SSH session disconnects.

Most common workflow:

```bash
screen
```

Detach:

```text
CTRL + A
CTRL + D
```

List sessions:

```bash
screen -ls
```

Reconnect:

```bash
screen -x SESSION
```

This makes `screen` an essential tool when working with remote Linux servers and long-running processes.
