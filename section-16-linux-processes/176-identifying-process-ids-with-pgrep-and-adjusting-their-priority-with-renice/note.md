## 176. Identifying Process IDs with `pgrep` and adjusting their Priority with `renice`


```bash 
ps -ef | grep firefox 

pgrep firefox 

renice -n 10 $(pgrep firefox) 
renice -n 10 $(grep -f firefox ) 

pgrep -f firefox 

```

# Identifying Processes with `pgrep` and Changing Priority with `renice`

When managing Linux systems, you often need to:

1. find a process PID
2. change its scheduling priority

Linux provides two very useful tools:

| Command  | Purpose                            |
| -------- | ---------------------------------- |
| `pgrep`  | find process IDs                   |
| `renice` | change niceness of running process |

These are commonly used together.

---

# 1. Why `pgrep` Exists

Before `pgrep`, people often did:

```bash id="’wini578"
ps aux | grep chrome
```

Problem:

```text id="’wini579"
grep itself appears in results
```

Messy.

---

# 2. `pgrep` Solution

Example:

```bash id="’wini580"
pgrep chrome
```

Output:

```text id="’wini581"
4211
4215
4220
```

Cleanly prints matching PIDs.

---

# 3. Basic Syntax

```bash id="’wini582"
pgrep process_name
```

Example:

```bash id="’wini583"
pgrep bash
```

---

# 4. Find Full Command Matches

Sometimes process name truncated.

Use:

```bash id="’wini584"
pgrep -f spring
```

`-f` searches full command line.

Very useful for:

* Java apps
* Spring Boot
* Python scripts
* Docker commands

---

# 5. Show PID + Process Name

Example:

```bash id="’wini585"
pgrep -a chrome
```

Output:

```text id="’wini586"
4211 /opt/google/chrome/chrome
```

`-a` = show arguments too.

---

# 6. Match Exact Name

```bash id="’wini587"
pgrep -x bash
```

Avoids partial matches.

---

# 7. Find Newest Process

```bash id="’wini588"
pgrep -n bash
```

Newest matching process.

---

# 8. Find Oldest Process

```bash id="’wini589"
pgrep -o bash
```

Oldest matching process.

---

# 9. Example Workflow

Start CPU-heavy process:

```bash id="’wini590"
yes > /dev/null
```

Find PID:

```bash id="’wini591"
pgrep yes
```

Suppose:

```text id="’wini592"
619824
```

Now you can:

* inspect it
* kill it
* renice it
* trace it

---

# 10. Changing Priority — `renice`

`renice` changes niceness of:

```text id="’wini593"
already running process
```

---

# 11. Basic Syntax

```bash id="’wini594"
renice NICE_VALUE -p PID
```

Example:

```bash id="’wini595"
renice 10 -p 619824
```

Meaning:

```text id="’wini596"
change process to nice 10
```

(lower priority)

---

# 12. Observe It

Check with:

```bash id="’wini597"
ps -l -p 619824
```

Look at:

```text id="’wini598"
NI
```

column.

---

# 13. Lower Priority as Normal User

Normal users can only:

```text id="’wini599"
increase niceness
```

(lower priority)

Example:

```bash id="’wini600"
renice 19 -p 619824
```

Allowed.

---

# 14. Increase Priority Requires Root

Example:

```bash id="’wini601"
sudo renice -10 -p 619824
```

Requires sudo.

Because:

```text id="’wini602"
higher priority affects system fairness
```

---

# 15. Real Example

---

## Start Process

```bash id="’wini603"
yes > /dev/null
```

---

## Find PID

```bash id="’wini604"
pgrep yes
```

---

## Lower Priority

```bash id="’wini605"
renice 19 -p PID
```

---

## Monitor

```bash id="’wini606"
top
```

Observe:

* `NI` column changes
* scheduler treats process more politely

---

# 16. Using `top` to Observe

Run:

```bash id="’wini607"
top
```

Look at:

| Column | Meaning            |
| ------ | ------------------ |
| `PR`   | scheduler priority |
| `NI`   | niceness           |

---

# 17. Nice vs Renice

| Command  | Purpose                         |
| -------- | ------------------------------- |
| `nice`   | start new process with niceness |
| `renice` | change existing process         |

---

# 18. Combined Example

Start low-priority process:

```bash id="’wini608"
nice -n 15 yes > /dev/null
```

Later change it:

```bash id="’wini609"
renice 5 -p PID
```

---

# 19. Real-World Usage

Common uses:

| Scenario          | Solution   |
| ----------------- | ---------- |
| background backup | high nice  |
| video rendering   | high nice  |
| database server   | lower nice |
| audio processing  | lower nice |
| batch jobs        | high nice  |

---

# 20. Multiple Processes

You can renice several PIDs:

```bash id="’wini610"
renice 10 -p 1111 2222 3333
```

---

# 21. Renice by User

Example:

```bash id="’wini611"
sudo renice 5 -u mohammad
```

Changes all user processes.

---

# 22. Relation to Scheduling

Niceness influences:

```text id="’wini612"
Linux scheduler decisions
```

Specifically:

* CPU fairness
* time slices
* scheduling frequency

---

# 23. Important Insight

Niceness affects:

```text id="’wini613"
CPU scheduling priority
```

NOT:

* memory limits
* disk usage
* network speed

---

# 24. Useful Monitoring Combination

---

## Find process

```bash id="’wini614"
pgrep yes
```

---

## Watch context switching

```bash id="’wini615"
watch -d -n 0.5 "grep ctxt /proc/PID/status"
```

---

## Change priority

```bash id="’wini616"
renice 19 -p PID
```

---

## Observe scheduler

```bash id="’wini617"
top
```

Excellent learning workflow.

---

# 25. Commands to Memorize

```bash id="’wini618"
pgrep name
pgrep -a name
pgrep -f pattern
renice 10 -p PID
sudo renice -10 -p PID
ps -l -p PID
top
```