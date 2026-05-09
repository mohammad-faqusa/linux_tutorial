## 188. Monitoring System Activity: the `htop` Program (Alternative to `top`)

# 188. Monitoring System Activity: the `htop` Program (Alternative to `top`)

htop is a modern, interactive replacement for `top`.

It gives the same system information but in a **much easier and more visual way**.

---

# 1. Installing `htop`

On Ubuntu:

```bash id="k1m7qv"
sudo apt update
sudo apt install htop
```

Run it:

```bash id="m9xw2a"
htop
```

---

# 2. Why `htop` is Better than `top`

| Feature           | `top`         | `htop`          |
| ----------------- | ------------- | --------------- |
| Interface         | text-heavy    | colored, visual |
| Mouse support     | ❌             | ✅               |
| Scrolling         | limited       | smooth          |
| Killing processes | keyboard only | easy menu       |
| Tree view         | basic         | built-in        |
| CPU visualization | simple        | per-core bars   |

---

# 3. Main Screen Overview

When you open `htop`, you see:

## Top section (System Summary)

### CPU usage per core

Each CPU core is shown as a colored bar:

* Green → user processes
* Red → kernel processes
* Blue → low-priority processes
* Yellow → I/O wait

---

### Memory + Swap

Example:

```
Mem:  3.2G / 8G
Swap: 0 / 2G
```

Shows:

* used RAM
* total RAM
* swap usage

---

### Load Average

Same as `top`:

* 1 min
* 5 min
* 15 min

---

# 4. Process List (Main Table)

You’ll see columns like:

| Column  | Meaning        |
| ------- | -------------- |
| PID     | process ID     |
| USER    | owner          |
| PRI     | priority       |
| NI      | nice value     |
| VIRT    | virtual memory |
| RES     | real RAM usage |
| CPU%    | CPU usage      |
| MEM%    | memory usage   |
| TIME+   | CPU time used  |
| Command | process name   |

---

# 5. Navigation (Very Important)

Unlike `top`, you can use:

## Arrow keys

* ↑ ↓ → ← navigate

## Mouse

* click to select
* scroll

---

# 6. Sorting Processes

Click or press:

### Sort by CPU

```
F6 → CPU%
```

### Sort by Memory

```
F6 → MEM%
```

Or use:

```text id="q8m2ld"
P = CPU sort
M = memory sort
T = time sort
```

---

# 7. Searching Processes

Press:

```text id="s1v9qa"
F3
```

Type:

```
firefox
```

It highlights matching processes.

---

# 8. Killing Processes

Select a process → press:

```text id="k9m2wd"
F9
```

You get a menu:

| Signal       | Meaning       |
| ------------ | ------------- |
| SIGTERM (15) | graceful stop |
| SIGKILL (9)  | force kill    |
| SIGSTOP (19) | pause         |

Then press Enter.

---

# 9. Tree View (Very Important)

Press:

```text id="t3p8ab"
F5
```

This shows parent-child structure:

Example:

```
systemd
 ├─ gnome-shell
 │   ├─ firefox
 │   └─ terminal
```

This is extremely useful for:

* understanding process hierarchy
* debugging orphan processes
* tracing applications

---

# 10. Showing Threads

Press:

```text id="h7q1cz"
H
```

Now you can see:

* processes → threads

Useful for:

* Java apps
* web servers
* databases

---

# 11. Per-Core CPU View

Each CPU core shows separate bars:

Example:

```
CPU0 ██████
CPU1 ██
CPU2 ██████████
CPU3 █
```

Helps detect:

* unbalanced workloads
* single-thread bottlenecks

---

# 12. Nice Value (Priority Control)

In `htop`:

* lower NI → higher priority
* higher NI → lower priority

Example:

| NI  | Meaning          |
| --- | ---------------- |
| -20 | highest priority |
| 0   | normal           |
| 19  | lowest priority  |

You can change it using:

```
F7 / F8
```

---

# 13. Filtering Processes

Press:

```text id="f6m2lp"
F4
```

Then type:

```
chrome
```

Only matching processes are shown.

---

# 14. Useful Function Keys Summary

| Key | Action            |
| --- | ----------------- |
| F1  | help              |
| F2  | setup             |
| F3  | search            |
| F4  | filter            |
| F5  | tree view         |
| F6  | sort              |
| F7  | increase priority |
| F8  | decrease priority |
| F9  | kill process      |
| F10 | exit              |

---

# 15. Real Use Cases

## 1. Find CPU hog

* press `P`
* sort by CPU
* kill heavy process if needed

---

## 2. Memory leak detection

* sort by MEM%
* watch processes growing continuously

---

## 3. Debug system slowdown

Check:

* CPU bars
* load average
* swap usage

---

## 4. Identify zombie/orphan behavior

Look for:

* weird parent-child trees
* unusual process states

---

# 16. `htop` vs `top` (Simple Mental Model)

* `top` → raw engine (powerful but harder)
* `htop` → dashboard (user-friendly control center)

---

# 17. Key Insight

If you understand:

* CPU usage
* memory usage
* load average
* process tree

then `htop` becomes your **real-time system microscope**.

---

If you want, next step I can show you:

👉 how to use `htop` to debug a real CPU/memory problem step-by-step (like a production server issue)
