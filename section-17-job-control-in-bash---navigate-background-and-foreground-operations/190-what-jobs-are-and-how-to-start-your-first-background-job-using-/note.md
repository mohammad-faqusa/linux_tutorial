## 190. What Jobs are and how to start your First Background Job (using `&`)

# 190. Jobs and Your First Background Job (`&`)

In Linux, a **job** is simply a process that is managed by your **current shell session**.

So when you run a command in the terminal, the shell treats it as a *job*.

---

# 1. Foreground vs Background

## Foreground job

When you run:

```bash id="fg1"
sleep 10
```

* the terminal is blocked
* you cannot type new commands
* the process controls the terminal

This is a **foreground job**.

---

## Background job

If you add `&`:

```bash id="bg1"
sleep 10 &
```

Now:

* the process runs in the background
* you get your terminal back immediately
* you can keep typing commands

Example output:

```text id="bg2"
[1] 12345
```

Meaning:

* `[1]` → job number
* `12345` → process ID (PID)

---

# 2. What is a Job?

A **job** is:

> A shell-tracked process (or group of processes) that you can control using job commands.

The shell keeps a table like:

| Job ID | PID   | State   |
| ------ | ----- | ------- |
| 1      | 12345 | Running |
| 2      | 12360 | Stopped |

---

# 3. View Jobs

Use:

```bash id="jobs1"
jobs
```

Example output:

```text id="jobs2"
[1]+ Running   sleep 100 &
```

---

# 4. Foreground → Background (Ctrl + Z)

If you start a process:

```bash id="fg2"
sleep 100
```

Then press:

```text id="ctrlz"
Ctrl + Z
```

It becomes:

* paused (stopped)
* moved to background state

Example:

```text id="jobs3"
[1]+ Stopped sleep 100
```

---

# 5. Resume in Background (`bg`)

To continue it in background:

```bash id="bg3"
bg
```

Now it runs again in background.

---

# 6. Bring Back to Foreground (`fg`)

To bring it back:

```bash id="fg3"
fg
```

Or specific job:

```bash id="fg4"
fg %1
```

---

# 7. Job vs Process (Important Difference)

| Concept | Meaning                     |
| ------- | --------------------------- |
| Process | OS-level execution unit     |
| Job     | Shell-managed process group |

So:

* every job contains one or more processes
* jobs are controlled by shell (`bash`, `zsh`, etc.)

---

# 8. Practical Example

## Step 1: Start background jobs

```bash id="ex1"
sleep 50 &
sleep 60 &
```

Output:

```text id="ex2"
[1] 11111
[2] 11112
```

---

## Step 2: Check jobs

```bash id="ex3"
jobs
```

---

## Step 3: Stop one job

```bash id="ex4"
kill %1
```

Note: `%1` = job ID (not PID)

---

# 9. Job States

| State   | Meaning            |
| ------- | ------------------ |
| Running | actively executing |
| Stopped | paused             |
| Done    | finished           |

---

# 10. Sending Jobs to Background After Start

Example:

```bash id="ex5"
sleep 100
```

Press:

```text id="ctrlz2"
Ctrl + Z
```

Then:

```bash id="ex6"
bg
```

Now it continues in background.

---

# 11. Why Jobs Are Useful

Jobs allow you to:

* run multiple commands at once
* keep terminal free
* manage long tasks

Examples:

* file downloads
* compilation
* server processes
* scripts

---

# 12. Advanced Job Control Commands

| Command   | Purpose               |
| --------- | --------------------- |
| `jobs`    | list jobs             |
| `fg`      | bring to foreground   |
| `bg`      | resume in background  |
| `kill %1` | kill job              |
| `disown`  | detach job from shell |

---

# 13. Example of `disown`

If you don’t want a job tied to terminal:

```bash id="ex7"
sleep 1000 &
disown
```

Now even if terminal closes:

* process continues running

---

# 14. Key Idea Summary

* `&` → start background job
* `Ctrl + Z` → pause job
* `bg` → resume in background
* `fg` → bring to foreground
* `jobs` → list shell jobs

---

