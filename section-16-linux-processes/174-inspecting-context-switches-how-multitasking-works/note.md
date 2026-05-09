## 174. Inspecting Context Switches: How Multitasking Works


### how does multitasking work 
* the switching between tasks is called scheduling

### can we inspect this 

* if our CPU switches from one program to another, it is called "context switch" 

```bash
cat /proc/[process ID]/status | grep ctxt 
```

```bash
watch -n 0.5 grep ctxt /proc/81696/status 
```

# Inspecting Context Switches: How Multitasking Works

Your CPU can execute only a limited number of instructions at a time (usually one thread per CPU core at a given instant).

Yet Linux appears to run:

* browser
* terminal
* music
* Docker
* databases
* Java apps

all simultaneously.

This happens because of:

```text id="jlwm441"
scheduling
```

---

# 1. Scheduling

The Linux kernel contains a component called:

```text id="’wini442"
scheduler
```

Its job:

```text id="’wini443"
decide which process gets CPU time
```

The scheduler rapidly switches CPU execution between processes.

This creates:

```text id="’wini444"
multitasking
```

---

# 2. Context Switch

When CPU stops executing one process and starts another:

```text id="’wini445"
context switch
```

occurs.

---

# 3. What Gets Switched?

The kernel must save process state:

* CPU registers
* stack pointer
* instruction pointer
* scheduling state
* memory mappings

Then restore another process state.

---

# 4. Simple Visualization

Imagine CPU timeline:

```text id="’wini446"
time →
[A][A][B][B][C][A][D][D]
```

CPU rapidly jumps between processes.

Each jump = context switch.

---

# 5. Why Processes Switch

Processes frequently stop because they:

* wait for keyboard input
* wait for disk I/O
* wait for network
* call `sleep()`
* finish time slice

Then scheduler chooses another process.

---

# 6. Voluntary vs Nonvoluntary Switches

Linux tracks two categories:

| Type         | Meaning                       |
| ------------ | ----------------------------- |
| voluntary    | process willingly yielded CPU |
| nonvoluntary | kernel forcibly interrupted   |

---

# 7. Voluntary Example

Run:

```bash id="’wini447"
sleep 30
```

Process immediately says:

```text id="’wini448"
I don't need CPU now
```

Kernel switches to another process.

This is:

```text id="’wini449"
voluntary context switch
```

---

# 8. Nonvoluntary Example

Run:

```bash id="’wini450"
yes > /dev/null
```

This process constantly consumes CPU.

Kernel interrupts it repeatedly so other processes can run.

That creates:

```text id="’wini451"
nonvoluntary context switches
```

---

# 9. Inspect Context Switches

Linux exposes process information through:

```text id="’wini452"
/proc
```

virtual filesystem.

---

# 10. Check Context Switch Counts

Example:

```bash id="’wini453"
cat /proc/1234/status | grep ctxt
```

Example output:

```text id="’wini454"
voluntary_ctxt_switches:        120
nonvoluntary_ctxt_switches:      15
```

---

# 11. Meaning of These Numbers

---

## Voluntary

Process paused willingly.

Examples:

* waiting for input
* sleeping
* waiting for network

---

## Nonvoluntary

Scheduler forcibly preempted process.

Usually because:

```text id="’wini455"
time slice expired
```

---

# 12. Live Monitoring With `watch`

Example:

```bash id="’wini456"
watch -n 0.5 grep ctxt /proc/81696/status
```

Meaning:

| Part        | Purpose                        |
| ----------- | ------------------------------ |
| `watch`     | rerun command repeatedly       |
| `-n 0.5`    | every 0.5 seconds              |
| `grep ctxt` | show only context-switch lines |

---

# 13. Observe Real Scheduling

Try this experiment.

---

## Terminal 1

Run CPU-heavy process:

```bash id="’wini457"
yes > /dev/null
```

---

## Terminal 2

Find PID:

```bash id="’wini458"
pgrep yes
```

Suppose PID is:

```text id="’wini459"
4211
```

Monitor:

```bash id="’wini460"
watch -n 0.5 grep ctxt /proc/4211/status
```

You will see:

```text id="’wini461"
nonvoluntary_ctxt_switches
```

increase rapidly.

Because scheduler keeps interrupting it.

---

# 14. Compare With Sleeping Process

Run:

```bash id="’wini462"
sleep 100
```

Find PID:

```bash id="’wini463"
pgrep sleep
```

Monitor:

```bash id="’wini464"
watch -n 0.5 grep ctxt /proc/PID/status
```

Mostly:

```text id="’wini465"
voluntary_ctxt_switches
```

increase.

Because process willingly sleeps.

---

# 15. System-Wide Context Switches

Use:

```bash id="’wini466"
vmstat 1
```

Look at column:

```text id="’wini467"
cs
```

Meaning:

```text id="’wini468"
context switches per second
```

---

# 16. Example Output

```text id="’wini469"
cs
24567
```

Means:

```text id="’wini470"
24,567 context switches per second
```

on entire system.

---

# 17. Why Context Switching Matters

Context switching has overhead.

Kernel must:

* save CPU state
* restore another process
* manage scheduling queues
* possibly flush CPU caches

Too many switches can hurt performance.

---

# 18. Real Backend Example

Suppose Java server creates:

```text id="’wini471"
100,000 threads
```

CPU spends huge time switching between them.

Performance drops.

This is why modern systems use:

* thread pools
* async I/O
* event loops
* reactive systems

---

# 19. Important Linux Insight

Most processes are NOT actively using CPU.

Most are waiting for:

* disk
* network
* user input
* locks
* timers

So Linux constantly switches among processes efficiently.

---

# 20. Commands to Practice

---

## Current shell context switches

```bash id="’wini472"
grep ctxt /proc/$$/status
```

`$$` = current shell PID.

---

## Live monitoring

```bash id="’wini473"
watch -n 0.5 grep ctxt /proc/$$/status
```

---

## CPU-heavy process

```bash id="’wini474"
yes > /dev/null
```

---

## Find PID

```bash id="’wini475"
pgrep yes
```

---

## System-wide switching

```bash id="’wini476"
vmstat 1
```

---

# 21. Mental Model

```text id="’wini477"
CPU rapidly jumps between processes
```

That jumping is:

```text id="’wini478"
context switching
```

controlled by the Linux scheduler.

