## 184. Process Endings: Process Reaping, Orphan & Zombie Processes

## 184. Process Endings: Process Reaping, Orphan & Zombie Processes

When a Linux process finishes, the story is **not immediately over**.

Linux keeps a small amount of information about the dead process until its parent collects it.
This leads to important concepts:

* **Process termination**
* **Reaping**
* **Zombie processes**
* **Orphan processes**

---

# 1. Normal Process Ending

A process can end in several ways:

```c
exit(0);
return 0;
```

Or by signals:

```bash
kill -TERM PID
kill -KILL PID
```

When a process finishes:

1. The kernel frees most resources:

   * memory
   * open files
   * CPU scheduling data

2. But the kernel keeps a tiny record containing:

   * PID
   * exit status
   * resource usage

Why?

Because the parent process may want to know:

* Did the child succeed?
* Did it crash?
* What exit code did it return?

---

# 2. Process Reaping

The parent process must collect the child's exit status.

This is called:

# **Reaping**

Usually done with:

```c
wait()
waitpid()
```

Example idea:

```c
pid = fork();

if (pid == 0) {
    exit(5);
}
else {
    wait(NULL);
}
```

After `wait()`:

* the kernel removes the remaining process entry
* the process completely disappears

---

# 3. Zombie Processes

A zombie process is:

# A dead process whose parent has NOT collected its exit status yet.

The process is already dead, but its process table entry still exists.

---

## Characteristics of Zombies

Zombie processes:

* consume almost no memory
* are not running
* cannot be killed normally
* still have a PID

In `ps`:

```bash
ps aux
```

You may see:

```text
Z
```

or:

```text
<defunct>
```

Example:

```bash
sleep 1 &
```

If the parent ignores the child after it exits, a zombie may appear briefly.

---

## Why Zombies Exist

Because Linux preserves the child's termination information for the parent.

Without zombies:

* parent could not retrieve exit codes
* process accounting would break

---

# 4. Creating a Zombie (Demo)

Example C program:

```c
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();

    if (pid == 0) {
        printf("Child exiting\n");
        return 0;
    } else {
        sleep(30); // parent ignores child
    }
}
```

During those 30 seconds:

```bash
ps aux | grep defunct
```

You may see:

```text
[program] <defunct>
```

That is the zombie.

---

# 5. Removing Zombies

A zombie disappears when:

* parent calls `wait()`
* OR parent exits

If parent exits first:

* zombie gets adopted by PID 1 (`systemd` or `init`)
* PID 1 reaps it automatically

---

# 6. Orphan Processes

An orphan process is:

# A running child whose parent has terminated.

Example:

```text
parent dies
child still running
```

Linux does NOT leave it unmanaged.

The orphan is adopted by:

```text
PID 1
```

Usually:

* `systemd`
* or old `init`

---

## Example

```bash
bash
 └── sleep 1000
```

If the shell dies unexpectedly:

```text
sleep 1000
```

continues running.

Its new parent becomes PID 1.

Check using:

```bash
ps -o pid,ppid,cmd
```

You may see:

```text
PID   PPID CMD
1234     1 sleep 1000
```

PPID = 1 means adopted orphan.

---

# 7. Important Difference

| Zombie                               | Orphan             |
| ------------------------------------ | ------------------ |
| Already dead                         | Still running      |
| Waiting for parent to collect status | Parent disappeared |
| Uses process table slot              | Runs normally      |
| State = Z                            | Normal state       |
| Problem if many accumulate           | Usually harmless   |

---

# 8. Why Too Many Zombies Are Bad

Each zombie occupies:

* a PID
* a process table entry

Too many zombies can exhaust the process table.

Then Linux may fail to create new processes.

---

# 9. Finding Zombies

```bash
ps aux | grep Z
```

Or:

```bash
ps -el | grep Z
```

---

# 10. Cleaning Up Zombies

Usually fix the parent process.

Options:

### Kill/restart parent

```bash
kill parentPID
```

Then PID 1 adopts and reaps zombies.

Or fix the application bug causing missing `wait()` calls.

---

# 11. Process Lifecycle Summary

```text
fork()
   ↓
running process
   ↓
process exits
   ↓
zombie state
   ↓
parent calls wait()
   ↓
fully removed
```

Or:

```text
parent dies first
   ↓
child becomes orphan
   ↓
PID 1 adopts child
```
