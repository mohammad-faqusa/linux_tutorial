## 191. Job Listing and Foregrounding: The `jobs` and `fg` Commands
# 191. Job Listing and Foregrounding: The `jobs` and `fg` Commands

Linux shells like `bash` support **job control**.

This allows you to:

* run processes in background
* stop processes temporarily
* resume them later
* switch processes between background and foreground

Two important commands are:

| Command | Purpose                   |
| ------- | ------------------------- |
| `jobs`  | list shell jobs           |
| `fg`    | bring a job to foreground |

---

# 1. Creating a Background Job

Start a command with `&`:

```bash id="a1"
sleep 100 &
```

Example output:

```text id="a2"
[1] 24567
```

Meaning:

| Part    | Meaning          |
| ------- | ---------------- |
| `[1]`   | job number       |
| `24567` | process ID (PID) |

The process is now running in the background.

Your terminal becomes usable immediately.

---

# 2. Listing Jobs with `jobs`

Run:

```bash id="a3"
jobs
```

Example:

```text id="a4"
[1]+ Running    sleep 100 &
```

---

# Understanding the Output

---

## `[1]`

The shell-assigned job ID.

NOT the PID.

You reference jobs using:

```text id="a5"
%1
```

---

## `+`

Means:

# current/default job

If you type:

```bash id="a6"
fg
```

the `+` job is chosen automatically.

---

## `-`

Means:

# previous job

Example:

```text id="a7"
[1]- Running sleep 100 &
[2]+ Running sleep 200 &
```

---

# 3. Starting Multiple Jobs

Example:

```bash id="a8"
sleep 100 &
sleep 200 &
sleep 300 &
```

Now:

```bash id="a9"
jobs
```

Output may look like:

```text id="a10"
[1]   Running sleep 100 &
[2]-  Running sleep 200 &
[3]+  Running sleep 300 &
```

---

# 4. Bringing a Job to Foreground: `fg`

---

## Bring current job

```bash id="a11"
fg
```

This brings the `+` job into foreground.

Your terminal becomes attached to it again.

---

## Bring specific job

```bash id="a12"
fg %1
```

This foregrounds job 1.

---

# 5. Foreground Behavior

Foreground processes:

* control the terminal
* receive keyboard input
* receive terminal signals like:

  * `Ctrl + C`
  * `Ctrl + Z`

Background processes normally do not.

---

# 6. Example Workflow

---

## Step 1

Start job:

```bash id="a13"
sleep 500 &
```

---

## Step 2

Check jobs:

```bash id="a14"
jobs
```

---

## Step 3

Bring to foreground:

```bash id="a15"
fg %1
```

Now the shell waits for the process.

---

## Step 4

Pause it:

```text id="a16"
Ctrl + Z
```

Output:

```text id="a17"
[1]+ Stopped sleep 500
```

---

## Step 5

Resume in background:

```bash id="a18"
bg %1
```

---

# 7. Job States

| State   | Meaning   |
| ------- | --------- |
| Running | executing |
| Stopped | paused    |
| Done    | finished  |

---

# 8. Difference Between Job ID and PID

Very important.

---

## PID

OS-level process ID.

Example:

```text id="a19"
24567
```

Used with:

```bash id="a20"
kill 24567
```

---

## Job ID

Shell-level identifier.

Example:

```text id="a21"
%1
```

Used with:

```bash id="a22"
fg %1
bg %1
kill %1
```

---

# 9. Foregrounding Interactive Programs

Very common use case.

Example:

```bash id="a23"
nano notes.txt
```

Press:

```text id="a24"
Ctrl + Z
```

Now:

```bash id="a25"
jobs
```

Shows:

```text id="a26"
[1]+ Stopped nano notes.txt
```

Return to it:

```bash id="a27"
fg
```

---

# 10. Internally What Happens?

When you run:

```bash id="a28"
fg %1
```

The shell:

1. gives terminal control to that process group
2. sends `SIGCONT` if stopped
3. waits for process to finish or stop again

This is real UNIX job control.

---

# 11. Useful Job Commands

| Command   | Purpose                |
| --------- | ---------------------- |
| `jobs`    | list jobs              |
| `fg`      | foreground current job |
| `fg %2`   | foreground job 2       |
| `bg`      | background stopped job |
| `kill %1` | kill job 1             |
| `jobs -l` | show jobs with PIDs    |

---

# 12. `jobs -l`

Very useful.

Example:

```bash id="a29"
jobs -l
```

Output:

```text id="a30"
[1]+ 24567 Running sleep 100 &
```

Now you see both:

* job ID
* PID

---

# 13. Important Limitation

`jobs` only shows:

# jobs belonging to the CURRENT shell session

Not all system processes.

For all processes use:

```bash id="a31"
ps -ef
```

---

# 14. Mental Model

```text id="a32"
shell
 ├─ job 1
 ├─ job 2
 └─ job 3
```

The shell acts like a mini process manager for your terminal session.

---

# 15. Summary

| Concept    | Meaning                     |
| ---------- | --------------------------- |
| `&`        | run in background           |
| `jobs`     | list shell-managed jobs     |
| `fg`       | bring job to foreground     |
| `%1`       | job identifier              |
| PID        | operating system process ID |
| `Ctrl + Z` | stop foreground job         |
| `bg`       | resume in background        |
