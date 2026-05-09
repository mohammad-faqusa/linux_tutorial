## 186. Monitoring System Activity: the `top` Program

# 186. Monitoring System Activity: the `top` Program

`top` is one of the most important Linux monitoring tools.

It shows:

* running processes
* CPU usage
* memory usage
* system load
* uptime
* process activity in real time

It is basically a live version of:

```bash id="jlwm8u"
ps
```

---

# 1. Starting `top`

Run:

```bash id="yv0u3t"
top
```

You will see a continuously updating screen.

Example:

```text id="t9wg5u"
top - 20:10:01 up 3:12,  1 user,  load average: 0.25, 0.30, 0.18
Tasks: 210 total,   1 running, 209 sleeping
%Cpu(s):  5.0 us,  2.0 sy, 92.0 id
MiB Mem :  16000 total,  8000 free,  5000 used, 3000 buff/cache
MiB Swap:   2000 total,  2000 free

PID USER   PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
1234 root   20  0  500m 50m 20m S 15.0  0.3  0:10 firefox
```

---

# 2. Understanding the Top Header

---

## First Line

Example:

```text id="mztj5v"
top - 20:10:01 up 3:12,  1 user,  load average: 0.25, 0.30, 0.18
```

### Meaning

| Part           | Meaning         |
| -------------- | --------------- |
| `20:10:01`     | current time    |
| `up 3:12`      | system uptime   |
| `1 user`       | logged-in users |
| `load average` | system workload |

---

# 3. Load Average

Example:

```text id="gwocm6"
0.25, 0.30, 0.18
```

These are averages over:

| Number | Time            |
| ------ | --------------- |
| first  | last 1 minute   |
| second | last 5 minutes  |
| third  | last 15 minutes |

---

## What does load mean?

Load average measures:

# How many processes are waiting for CPU time.

---

## General Rule

On a 4-core CPU:

| Load | Meaning    |
| ---- | ---------- |
| 1.0  | light      |
| 4.0  | fully busy |
| >4.0 | overloaded |

---

# 4. Tasks Line

Example:

```text id="smrypd"
Tasks: 210 total, 1 running, 209 sleeping
```

Shows process states.

| State    | Meaning               |
| -------- | --------------------- |
| running  | actively executing    |
| sleeping | waiting               |
| stopped  | paused                |
| zombie   | dead unreaped process |

---

# 5. CPU Line

Example:

```text id="k8iqtm"
%Cpu(s): 5.0 us, 2.0 sy, 92.0 id
```

---

## CPU Categories

| Field | Meaning                 |
| ----- | ----------------------- |
| `us`  | user-space CPU usage    |
| `sy`  | kernel/system CPU usage |
| `id`  | idle                    |
| `wa`  | waiting for disk I/O    |
| `hi`  | hardware interrupts     |
| `si`  | software interrupts     |

---

## Example

```text id="r96u7f"
92% idle
```

means CPU is mostly free.

---

# 6. Memory Section

Example:

```text id="i8lw7r"
MiB Mem : 16000 total, 8000 free, 5000 used, 3000 buff/cache
```

---

## Terms

| Field      | Meaning          |
| ---------- | ---------------- |
| total      | installed RAM    |
| free       | unused RAM       |
| used       | active memory    |
| buff/cache | filesystem cache |

---

## Important Linux Concept

Linux intentionally uses free RAM as cache.

So low "free memory" is often normal.

---

# 7. Swap

Example:

```text id="f7g13y"
MiB Swap: 2000 total, 100 free
```

Swap is disk space used as overflow RAM.

Heavy swap usage usually means memory pressure.

---

# 8. Process Table

Lower section:

```text id="0c8fr2"
PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
```

---

## Important Columns

| Column  | Meaning             |
| ------- | ------------------- |
| PID     | process ID          |
| USER    | owner               |
| PR      | scheduler priority  |
| NI      | nice value          |
| VIRT    | virtual memory      |
| RES     | real RAM used       |
| S       | process state       |
| %CPU    | CPU usage           |
| %MEM    | memory usage        |
| TIME+   | total CPU time used |
| COMMAND | process name        |

---

# 9. Process States

| State | Meaning               |
| ----- | --------------------- |
| R     | running               |
| S     | sleeping              |
| D     | uninterruptible sleep |
| T     | stopped               |
| Z     | zombie                |

---

# 10. Interactive Commands Inside `top`

While `top` is running:

---

## Quit

```text id="rjgn6e"
q
```

---

## Kill a Process

Press:

```text id="i0vb8n"
k
```

Then enter:

* PID
* signal number

Usually:

```text id="sljlwm"
15
```

for SIGTERM.

---

## Renice Process

Press:

```text id="c6lckd"
r
```

Then:

* PID
* nice value

---

## Sort by CPU

Press:

```text id="ljlwmg"
P
```

(capital P)

---

## Sort by Memory

Press:

```text id="9t1hm7"
M
```

(capital M)

---

## Show Full Command Lines

Press:

```text id="88h0mf"
c
```

---

## Change Refresh Speed

Press:

```text id="nv0wn7"
d
```

Then enter seconds.

Example:

```text id="3x5bvv"
0.5
```

updates twice per second.

---

# 11. Practical Example

Run a CPU-heavy task:

```bash id="rm9b5y"
yes > /dev/null
```

Then open:

```bash id="0y1ydw"
top
```

You will see:

* high CPU usage
* `yes` consuming CPU

Stop it:

```bash id="43fudf"
CTRL + C
```

Or kill from `top`.

---

# 12. Better Modern Alternative: `htop`

Install:

```bash id="qtxm1m"
sudo apt install htop
```

Run:

```bash id="zhhx7u"
htop
```

Advantages:

* colored UI
* mouse support
* easier navigation
* tree view
* easier killing processes

---

# 13. Common Workflow

```bash id="0jy5xp"
top
```

Then:

1. find high CPU process
2. note PID
3. investigate:

```bash id="7h5grd"
ps -fp PID
```

4. terminate if necessary:

```bash id="ty1i0j"
kill PID
```

---

# 14. Summary

| Command      | Purpose                  |
| ------------ | ------------------------ |
| `top`        | real-time system monitor |
| `htop`       | enhanced top             |
| `top -p PID` | monitor specific PID     |
| `P`          | sort by CPU              |
| `M`          | sort by memory           |
| `k`          | kill process             |
| `r`          | renice process           |
| `q`          | quit                     |
