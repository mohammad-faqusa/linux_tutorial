## 183. Sending Signals to Multiple Processes: the `killall` Command

The `killall` command sends a signal to processes **by process name** instead of PID.

Instead of doing:

```bash
kill 1234
kill 5678
kill 9012
```

You can do:

```bash
killall firefox
```

This sends the default signal (`SIGTERM`) to **all processes named `firefox`**.

---

# Basic Syntax

```bash
killall [signal] process_name
```

Examples:

```bash
killall yes
killall firefox
killall chrome
```

---

# Example 1 — Stopping Multiple `yes` Processes

Start several background processes:

```bash
yes > /dev/null &
yes > /dev/null &
yes > /dev/null &
```

Check them:

```bash
pgrep yes
```

You may see:

```text
6201
6202
6203
```

Instead of killing them one by one:

```bash
kill 6201
kill 6202
kill 6203
```

You can simply run:

```bash
killall yes
```

Now verify:

```bash
pgrep yes
```

No output means all were terminated.

---

# Default Signal = SIGTERM

Like `kill`, `killall` sends `SIGTERM` by default.

```bash
killall firefox
```

Equivalent to:

```bash
killall -TERM firefox
```

or:

```bash
killall -15 firefox
```

---

# Force Killing with SIGKILL

If a process ignores `SIGTERM`:

```bash
killall -9 process_name
```

Example:

```bash
killall -9 yes
```

This sends `SIGKILL`.

---

# Sending Other Signals

## Pause all matching processes

```bash
killall -STOP firefox
```

Resume them:

```bash
killall -CONT firefox
```

---

# Reload Configuration with SIGHUP

Some daemons reload configuration on `SIGHUP`.

Example:

```bash
sudo killall -HUP nginx
```

This tells all `nginx` processes:

> "Reload your configuration without fully stopping."

---

# Difference Between `kill` and `killall`

| Command        | Targets                      |
| -------------- | ---------------------------- |
| `kill PID`     | Specific process ID          |
| `killall name` | All processes with that name |

Example:

```bash
kill 1234
```

vs

```bash
killall firefox
```

---

# Important Warning

`killall` can terminate MANY processes at once.

For example:

```bash
killall python
```

Could stop:

* scripts
* web servers
* automation tools
* virtual environments
* background services

So always verify first:

```bash
pgrep python
```

or:

```bash
ps -ef | grep python
```

---

# Safer Testing Example

You can safely practice using `sleep`:

```bash
sleep 300 &
sleep 300 &
sleep 300 &
```

Check:

```bash
pgrep sleep
```

Kill all:

```bash
killall sleep
```

---

# Difference Between `killall` and `pkill`

| Command   | Works By           |
| --------- | ------------------ |
| `killall` | Exact process name |
| `pkill`   | Pattern matching   |

Example:

```bash
pkill fire
```

May match:

* firefox
* firewalld
* firebird

While:

```bash
killall firefox
```

Targets only `firefox`.

---

# Common Real-World Uses

## Close all browser processes

```bash
killall firefox
```

## Restart a stuck application

```bash
killall vlc
vlc &
```

## Reload a daemon

```bash
sudo killall -HUP sshd
```

## Stop all runaway CPU-heavy tasks

```bash
killall yes
```
