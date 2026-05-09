## 175. Controlling Process Priorities by Setting the Niceness

# Controlling Process Priorities with Niceness

Linux may run:

* browsers
* databases
* terminals
* Java apps
* Docker containers

all at the same time.

So scheduler needs a way to decide:

```text id="jlwm496"
which process should get CPU preference
```

This is where:

```text id="’wini497"
niceness
```

comes in.

---

# 1. What Is Niceness?

Niceness controls:

```text id="’wini498"
process scheduling priority
```

Important idea:

```text id="’wini499"
higher niceness = lower priority
```

because process is being “nice” to others.

---

# 2. Niceness Range

Linux nice values:

```text id="’wini500"
-20  → highest priority
  0   → default
 19   → lowest priority
```

---

# 3. Easy Mental Model

| Nice Value | Meaning            |
| ---------- | ------------------ |
| `-20`      | selfish/aggressive |
| `0`        | normal             |
| `19`       | very polite        |

---

# 4. Default Priority

Most processes start with:

```text id="’wini501"
nice = 0
```

---

# 5. View Niceness

Use:

```bash id="’wini502"
ps -l
```

Look at:

```text id="’wini503"
NI
```

column.

Example:

```text id="’wini504"
NI
 0
```

---

# 6. Start Process With Custom Niceness

Example:

```bash id="’wini505"
nice -n 10 yes > /dev/null
```

Meaning:

| Part    | Meaning                    |
| ------- | -------------------------- |
| `nice`  | start with custom niceness |
| `-n 10` | nice value = 10            |

This process gets LOWER CPU priority.

---

# 7. Compare Two Processes

---

## Terminal 1

```bash id="’wini506"
yes > /dev/null
```

(default nice = 0)

---

## Terminal 2

```bash id="’wini507"
nice -n 19 yes > /dev/null
```

(very low priority)

---

Now monitor:

```bash id="’wini508"
top
```

You’ll see scheduler favors the higher-priority process.

---

# 8. Why This Matters

Suppose you run:

* video rendering
* backups
* indexing
* compression

You may NOT want them slowing system.

So run them with:

```text id="’wini509"
high niceness
```

(low priority)

---

# 9. Negative Niceness

Lower nice value = higher priority.

Example:

```bash id="’wini510"
sudo nice -n -10 app
```

Requires root.

Why?

Because high-priority processes can starve system.

---

# 10. Why Normal Users Cannot Use Negative Nice

Otherwise users could make all processes:

```text id="’wini511"
highest priority
```

and destroy system responsiveness.

---

# 11. Change Priority of Existing Process — `renice`

Example:

```bash id="’wini512"
renice 10 -p 4211
```

Meaning:

```text id="’wini513"
change PID 4211 to nice 10
```

---

# 12. Increase Priority

Requires sudo:

```bash id="’wini514"
sudo renice -5 -p 4211
```

---

# 13. Observe in `top`

Run:

```bash id="’wini515"
top
```

Look for:

```text id="’wini516"
NI
```

column.

---

# 14. Niceness vs Priority

Linux internally computes actual scheduler priority using:

* niceness
* scheduler class
* CPU behavior
* fairness algorithms

Niceness is only ONE factor.

---

# 15. Real Scheduling Behavior

Higher-priority process generally:

* gets CPU sooner
* keeps CPU longer
* gets interrupted less

---

# 16. Example Real Use Cases

---

## Low Priority Backup

```bash id="’wini517"
nice -n 19 tar -czf backup.tar.gz folder/
```

---

## Low Priority Build

```bash id="’wini518"
nice -n 15 mvn package
```

---

## Important Real-Time Task

```bash id="’wini519"
sudo nice -n -10 audio_app
```

---

# 17. CPU-Bound vs I/O-Bound

Niceness mostly affects:

```text id="’wini520"
CPU-bound processes
```

Processes waiting on disk/network already sleep frequently.

---

# 18. Interaction With Context Switching

Scheduler uses priorities when deciding:

```text id="’wini521"
which process runs next
```

Niceness influences scheduling decisions and context switches.

---

# 19. See Nice Value in `ps`

Example:

```bash id="’wini522"
ps -o pid,ni,cmd
```

Output:

```text id="’wini523"
 PID  NI CMD
4211   0 bash
4300  10 yes
```

---

# 20. Related Command — `ionice`

Linux also supports:

```text id="’wini524"
I/O priority
```

using:

```bash id="’wini525"
ionice
```

Different from CPU niceness.

---

# 21. Important Real-World Insight

Niceness does NOT guarantee exact CPU percentages.

Linux scheduler is complex.

Niceness simply biases scheduling fairness.

---

# 22. Practical Experiment

---

## Start normal CPU hog

```bash id="’wini526"
yes > /dev/null
```

---

## Start nice process

```bash id="’wini527"
nice -n 19 yes > /dev/null
```

---

## Monitor

```bash id="’wini528"
top
```

Compare CPU distribution.

Stop:

```bash id="’wini529"
pkill yes
```

---

# 23. Important Mental Model

```text id="’wini530"
lower nice number = more CPU priority
higher nice number = less CPU priority
```

---

# 24. Commands to Memorize

```bash id="’wini531"
nice -n 10 command
renice 10 -p PID
top
ps -l
ps -o pid,ni,cmd
```

These are fundamental Linux process-management tools used in:

* backend systems
* servers
* DevOps
* databases
* performance tuning
* cloud infrastructure
