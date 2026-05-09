## 187. Advanced `top` Usage (Deep Dive)

# 187. Advanced `top` Usage (Deep Dive)

Basic `top` usage is only the beginning.

`top` is actually a powerful interactive monitoring system.

You can:

* monitor specific users
* track selected processes
* customize fields
* view threads
* analyze CPU cores
* inspect scheduling behavior
* save layouts
* troubleshoot performance bottlenecks

---

# 1. Launching `top` with Options

---

## Monitor Specific PID

```bash id="f4jlwm"
top -p 1234
```

Monitor only process `1234`.

Multiple PIDs:

```bash id="m9v0yl"
top -p 1234,5678
```

Very useful for debugging one application.

---

# 2. Monitor a Specific User

```bash id="fy8a0t"
top -u mohammad
```

Shows only processes owned by user `mohammad`.

---

# 3. Batch Mode

Useful for logging or scripts.

```bash id="j17r8m"
top -b
```

`-b` = batch mode.

Instead of interactive UI, output becomes plain text.

---

## Save to File

```bash id="k3u0a7"
top -b -n 1 > processes.txt
```

Explanation:

| Option | Meaning    |
| ------ | ---------- |
| `-b`   | batch mode |
| `-n 1` | run once   |

---

# 4. Change Refresh Interval

```bash id="djlwmx"
top -d 1
```

Refresh every 1 second.

Example:

```bash id="utkg6v"
top -d 0.5
```

Twice per second.

---

# 5. Threads vs Processes

Normally `top` shows processes.

To show individual threads:

Press:

```text id="mdj70y"
H
```

(capital H)

Now each thread appears separately.

Very useful for:

* Java
* browsers
* databases
* multithreaded applications

---

# 6. Per-CPU Core Monitoring

Press:

```text id="v2b4zt"
1
```

You will see separate CPU statistics for each core.

Example:

```text id="o5q2jl"
%Cpu0
%Cpu1
%Cpu2
%Cpu3
```

Useful for:

* CPU affinity
* core imbalance
* single-thread bottlenecks

---

# 7. Understanding CPU Usage More Deeply

---

## User Space (`us`)

Programs running normally.

Examples:

* Firefox
* Java
* Python

---

## System (`sy`)

Kernel work.

Examples:

* drivers
* filesystem
* networking

High `sy` can indicate:

* kernel-heavy workloads
* excessive I/O
* networking pressure

---

## I/O Wait (`wa`)

CPU idle while waiting for disk operations.

High `wa` often means:

* slow disk
* overloaded SSD/HDD
* database bottleneck

---

## Steal Time (`st`)

Seen mainly in virtual machines.

Means:

> hypervisor temporarily took CPU away

High `st` = overloaded VM host.

---

# 8. Memory Analysis in `top`

---

## VIRT

Virtual memory size.

Includes:

* mapped files
* libraries
* allocated virtual address space

Can look huge.

---

## RES

Resident memory.

Actual RAM currently used.

Most important memory column.

---

## SHR

Shared memory.

Usually shared libraries.

---

# 9. Sorting Interactively

Inside `top`:

| Key | Sort    |
| --- | ------- |
| `P` | CPU     |
| `M` | memory  |
| `T` | runtime |
| `N` | PID     |

---

# 10. Forest / Tree View

Some versions support:

```text id="9h0l7w"
V
```

Shows parent-child hierarchy.

Example:

```text id="bbxjnn"
systemd
 ├─ sshd
 │   └─ bash
 │       └─ top
```

Very useful for understanding process ancestry.

---

# 11. Killing Processes from `top`

Press:

```text id="yj4d6m"
k
```

Enter:

```text id="2jjpq2"
PID
```

Then signal.

Common signals:

| Signal | Meaning |
| ------ | ------- |
| 15     | SIGTERM |
| 9      | SIGKILL |
| 19     | SIGSTOP |
| 18     | SIGCONT |

---

# 12. Renicing from `top`

Press:

```text id="t1txdw"
r
```

Then:

* PID
* nice value

Example:

```text id="rjlwm2"
10
```

Lower priority.

---

# 13. Searching for Processes

Press:

```text id="e7lzv2"
/
```

Then enter process name.

Example:

```text id="h6m9kg"
firefox
```

---

# 14. Filtering Processes

Press:

```text id="fyjlwm"
o
```

Then filters like:

```text id="0x8m6l"
USER=root
```

Or:

```text id="rcq4qs"
%CPU>10
```

---

# 15. Highlight Running Tasks

Press:

```text id="gkgjlwm"
y
```

Highlights active tasks.

---

# 16. Color Modes

Press:

```text id="bn0f5v"
z
```

Enable/disable colors.

---

# 17. Customizing Columns

Press:

```text id="jlwm4r"
f
```

You can:

* add/remove columns
* reorder fields
* choose displayed metrics

Useful fields:

| Field   | Meaning                  |
| ------- | ------------------------ |
| PPID    | parent PID               |
| UID     | user ID                  |
| WCHAN   | sleeping kernel function |
| TIME    | CPU time                 |
| COMMAND | full command             |

---

# 18. Understanding Load Average Properly

This confuses many people.

---

## Load ≠ CPU %

Load measures:

# Runnable or waiting tasks.

A process waiting for disk I/O can increase load even if CPU is mostly idle.

---

## Example

High load + low CPU usage often means:

```text id="a2rv6q"
disk bottleneck
```

NOT CPU bottleneck.

---

# 19. Diagnosing Common Problems

---

## High CPU Usage

Sort by CPU:

```text id="hpnm0g"
P
```

Investigate top processes.

---

## High RAM Usage

Sort by memory:

```text id="vjlwmq"
M
```

Look at:

* RES
* swap usage

---

## System Lag but Low CPU

Check:

```text id="jlwmzx"
wa
```

High I/O wait indicates storage problem.

---

## Zombie Processes

Look for:

```text id="wjlwm1"
Z
```

in process state.

---

# 20. Saving Configuration

`top` remembers settings.

After customizing:

Press:

```text id="8yd8y9"
W
```

(capital W)

Settings saved to:

```text id="jlwm8m"
~/.config/procps/toprc
```

---

# 21. Real-World Example Workflow

Suppose server becomes slow.

---

## Step 1

Run:

```bash id="jlwm6z"
top
```

---

## Step 2

Check:

* load average
* CPU idle
* memory
* swap
* I/O wait

---

## Step 3

Sort by CPU:

```text id="jlwm3m"
P
```

---

## Step 4

Find suspicious PID.

Inspect:

```bash id="jlwm5x"
ps -fp PID
```

---

## Step 5

If necessary:

```bash id="jlwm99"
kill PID
```

---

# 22. Useful Companion Tools

| Tool      | Purpose                     |
| --------- | --------------------------- |
| `htop`    | modern interactive monitor  |
| `iotop`   | disk I/O monitor            |
| `iftop`   | network monitor             |
| `vmstat`  | system statistics           |
| `free -h` | memory summary              |
| `pidstat` | per-process stats           |
| `sar`     | historical performance data |

---

# 23. Installing Helpful Tools

```bash id="jlwm7v"
sudo apt install htop iotop sysstat
```

---

# 24. Key Mental Model

`top` answers these questions:

| Question                   | Indicator           |
| -------------------------- | ------------------- |
| CPU overloaded?            | high `%CPU`         |
| RAM exhausted?             | low free RAM + swap |
| Disk bottleneck?           | high `wa`           |
| Too many tasks?            | high load average   |
| Which process responsible? | process table       |

---

# 25. Most Important Advanced Keys

| Key | Function         |
| --- | ---------------- |
| `1` | per-core CPUs    |
| `H` | show threads     |
| `P` | sort CPU         |
| `M` | sort memory      |
| `T` | sort runtime     |
| `k` | kill             |
| `r` | renice           |
| `f` | customize fields |
| `o` | filter           |
| `V` | tree view        |
| `W` | save config      |
| `q` | quit             |
