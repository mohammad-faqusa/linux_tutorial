## 193. Suspending and Resuming Jobs with `fg`

# 193. Suspending and Resuming Jobs with `fg`

One of the most powerful UNIX shell features is:

# Job Control

This allows you to:

* pause programs
* resume them later
* move them between foreground and background

The main tools are:

| Command    | Purpose                        |
| ---------- | ------------------------------ |
| `Ctrl + Z` | suspend current foreground job |
| `bg`       | resume in background           |
| `fg`       | resume in foreground           |

---

# 1. What Does “Suspending” Mean?

Suspending means:

# Temporarily pausing a process without terminating it.

The process:

* stays in memory
* keeps its current state
* stops executing instructions

---

# 2. Start a Foreground Job

Example:

```bash id="s1"
sleep 300
```

Now:

* terminal is blocked
* process runs in foreground

---

# 3. Suspend the Job

Press:

```text id="s2"
Ctrl + Z
```

Output:

```text id="s3"
[1]+ Stopped sleep 300
```

What happened?

The shell sent:

```text id="s4"
SIGTSTP
```

to the foreground process.

---

# 4. What is `SIGTSTP`?

`SIGTSTP` means:

# Terminal Stop Signal

It tells the process:

> Pause execution.

Unlike `SIGKILL`, the process is NOT destroyed.

---

# 5. Verify Suspended Jobs

Run:

```bash id="s5"
jobs
```

Output:

```text id="s6"
[1]+ Stopped sleep 300
```

State is now:

```text id="s7"
Stopped
```

---

# 6. Resume in Background: `bg`

Run:

```bash id="s8"
bg
```

Output:

```text id="s9"
[1]+ sleep 300 &
```

Now:

* process continues running
* terminal becomes usable

---

# What internally happened?

The shell sent:

```text id="s10"
SIGCONT
```

which means:

# Continue execution

---

# 7. Bring Back to Foreground: `fg`

Run:

```bash id="s11"
fg
```

Now:

* process becomes foreground again
* terminal attaches to it

---

# 8. Full Example Workflow

---

## Step 1

Start program:

```bash id="s12"
sleep 500
```

---

## Step 2

Suspend it:

```text id="s13"
Ctrl + Z
```

---

## Step 3

Check jobs:

```bash id="s14"
jobs
```

---

## Step 4

Resume in background:

```bash id="s15"
bg
```

---

## Step 5

Bring back:

```bash id="s16"
fg
```

---

# 9. Multiple Jobs Example

Start:

```bash id="s17"
sleep 100 &
sleep 200 &
```

Then:

```bash id="s18"
jobs
```

Output:

```text id="s19"
[1]- Running sleep 100 &
[2]+ Running sleep 200 &
```

Foreground job 1:

```bash id="s20"
fg %1
```

---

# 10. Important Signals in Job Control

| Signal  | Meaning              |
| ------- | -------------------- |
| SIGINT  | interrupt (`Ctrl+C`) |
| SIGTSTP | suspend (`Ctrl+Z`)   |
| SIGCONT | continue execution   |
| SIGTERM | graceful terminate   |
| SIGKILL | force kill           |

---

# 11. Difference Between Stop and Kill

| Action          | Result             |
| --------------- | ------------------ |
| Stop (`Ctrl+Z`) | process paused     |
| Kill (`Ctrl+C`) | process terminated |

Stopped process can resume.

Killed process is gone.

---

# 12. Seeing Process States

Use:

```bash id="s21"
ps -o pid,state,cmd
```

Common states:

| State | Meaning  |
| ----- | -------- |
| R     | running  |
| S     | sleeping |
| T     | stopped  |
| Z     | zombie   |

After `Ctrl + Z`:

```text id="s22"
T
```

appears.

---

# 13. Real Interactive Example

Try with:

```bash id="s23"
nano notes.txt
```

Then:

```text id="s24"
Ctrl + Z
```

Now nano pauses.

Later:

```bash id="s25"
fg
```

returns exactly where you left off.

This is real process suspension.

---

# 14. How Shells Implement This

The shell manages:

* process groups
* terminal ownership
* signals

When using `fg`:

1. shell gives terminal control to process group
2. sends `SIGCONT`
3. waits for job

---

# 15. Background Processes and Terminal Input

Background processes usually cannot safely read terminal input.

If they try, Linux may stop them automatically with:

```text id="s26"
SIGTTIN
```

or:

```text id="s27"
SIGTTOU
```

---

# 16. Key Mental Model

Think of jobs like paused apps:

| Action | Similar Idea         |
| ------ | -------------------- |
| Ctrl+Z | minimize app         |
| bg     | let it run minimized |
| fg     | reopen app           |

---

# 17. Summary

| Command    | Purpose                |
| ---------- | ---------------------- |
| `Ctrl + Z` | suspend foreground job |
| `jobs`     | list jobs              |
| `bg`       | continue in background |
| `fg`       | continue in foreground |
| `fg %1`    | foreground job 1       |

---

# 18. Process Lifecycle Example

```text id="s28"
foreground
   ↓ Ctrl+Z
stopped
   ↓ bg
background running
   ↓ fg
foreground again
```
