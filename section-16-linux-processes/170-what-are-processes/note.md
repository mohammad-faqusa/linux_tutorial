## 170. What are Processes?
A **process** is simply:

```text id="c7z62m"
a running program
```

When you start an application, Linux creates a process for it.

Examples:

| Program            | Process          |
| ------------------ | ---------------- |
| Bash terminal      | bash process     |
| Visual Studio Code | code processes   |
| Google Chrome      | chrome processes |
| Spring Boot app    | java process     |
| Node.js server     | node process     |

---

# 1. Program vs Process

Important distinction:

| Term    | Meaning                    |
| ------- | -------------------------- |
| Program | file on disk               |
| Process | running instance in memory |

Example:

```text id="jlwm251"
/usr/bin/bash
```

is a program.

When executed:

```bash id="’wini252"
bash
```

Linux creates a running process.

---

# 2. Processes Live in Memory

A process contains:

* program code
* memory
* variables
* open files
* network connections
* process ID (PID)

---

# 3. Every Process Has a PID

PID = Process ID

Example:

```bash id="’wini253"
echo $$
```

Shows current shell PID.

---

# 4. Viewing Processes

Most common command:

```bash id="’wini254"
ps aux
```

---

# 5. Understanding `ps aux`

Example:

```text id="’wini255"
USER       PID  %CPU %MEM COMMAND
mohammad  4211   2.0  1.3 code
```

Meaning:

| Column  | Meaning         |
| ------- | --------------- |
| USER    | owner           |
| PID     | process ID      |
| %CPU    | CPU usage       |
| %MEM    | RAM usage       |
| COMMAND | running program |

---

# 6. Process Tree

Processes create child processes.

Example:

```text id="’wini256"
bash
 └── python
      └── chrome
```

Linux processes form a hierarchy tree.

---

# 7. PID 1 — The Parent of Everything

Check:

```bash id="’wini257"
ps -p 1
```

Usually:

```text id="’wini258"
systemd
```

PID 1 is special.

It starts the whole Linux system.

---

# 8. Foreground vs Background Processes

---

## Foreground

Runs attached to terminal:

```bash id="’wini259"
ping google.com
```

Terminal becomes busy.

---

## Background

Use:

```bash id="’wini260"
ping google.com &
```

Now process runs in background.

---

# 9. Process States

Processes can be:

| State | Meaning  |
| ----- | -------- |
| R     | running  |
| S     | sleeping |
| T     | stopped  |
| Z     | zombie   |

You saw some earlier in `ps`.

---

# 10. Sleeping Processes

Most processes are sleeping most of the time.

Example:

```text id="’wini261"
waiting for input/events
```

This is normal.

---

# 11. Zombie Processes

Zombie means:

```text id="’wini262"
process finished
BUT parent didn't clean it
```

State:

```text id="’wini263"
Z
```

---

# 12. Viewing Process Tree

Use:

```bash id="’wini264"
pstree
```

Very useful.

Install if missing:

```bash id="’wini265"
sudo apt install psmisc
```

---

# 13. Interactive Process Monitoring

---

## `top`

```bash id="’wini266"
top
```

Real-time process viewer.

---

## `htop`

Better version:

```bash id="’wini267"
htop
```

---

# 14. Killing Processes

Graceful:

```bash id="’wini268"
kill PID
```

Force:

```bash id="’wini269"
kill -9 PID
```

---

# 15. Finding Processes

---

## By name

```bash id="’wini270"
pgrep chrome
```

---

## Using grep

```bash id="’wini271"
ps aux | grep '[c]hrome'
```

---

# 16. Parent and Child Processes

View parent PID:

```bash id="’wini272"
ps -f
```

Column:

```text id="’wini273"
PPID
```

means Parent Process ID.

---

# 17. Process Lifecycle

Typical flow:

```text id="’wini274"
Program starts
    ↓
Process created
    ↓
Runs/sleeps
    ↓
Terminates
```

---

# 18. How Linux Creates Processes

Linux uses system calls like:

| Call     | Purpose           |
| -------- | ----------------- |
| `fork()` | duplicate process |
| `exec()` | load new program  |
| `wait()` | wait for child    |

Important OS concepts.

---

# 19. Example With Bash

When you run:

```bash id="’wini275"
ls
```

Bash:

```text id="’wini276"
1. forks
2. child execs /usr/bin/ls
3. parent waits
```

Classic Unix design.

---

# 20. Environment Variables Per Process

Each process has its own:

* environment variables
* current directory
* open files

Example:

```bash id="’wini277"
export NAME=MOHAMMAD
```

Child processes inherit it.

---

# 21. Open Files Per Process

Linux treats many things as files:

* sockets
* pipes
* devices

View open files:

```bash id="’wini278"
lsof
```

---

# 22. Process Priorities

Linux scheduler manages CPU time.

Niceness:

```bash id="’wini279"
nice -n 10 app
```

Lower priority.

---

# 23. Daemons

Background service processes are called:

```text id="’wini280"
daemons
```

Examples:

* sshd
* systemd
* nginx
* dockerd

Usually end with:

```text id="’wini281"
d
```

---

# 24. Important Real-World Examples

| Application      | Process Name |
| ---------------- | ------------ |
| Java Spring Boot | java         |
| Node.js          | node         |
| PostgreSQL       | postgres     |
| Docker           | dockerd      |
| Nginx            | nginx        |

---

# 25. Professional Commands

| Command  | Purpose                |
| -------- | ---------------------- |
| `ps aux` | list processes         |
| `top`    | live monitoring        |
| `htop`   | interactive monitoring |
| `kill`   | terminate              |
| `pkill`  | kill by name           |
| `pgrep`  | search by name         |
| `pstree` | hierarchy              |

---

# 26. Important Mental Model

Linux system is basically:

```text id="’wini282"
kernel managing processes
```

Everything you do:

* browser
* VSCode
* terminal
* Docker
* Java
* SSH

is just processes interacting with the kernel.

---

# 27. Commands to Practice

```bash id="’wini283"
ps aux
top
htop
pstree
echo $$
pgrep bash
kill PID
```

Understanding processes is foundational for:

* Linux
* Docker
* Kubernetes
* Backend systems
* DevOps
* Operating systems
* Performance tuning
* Security
