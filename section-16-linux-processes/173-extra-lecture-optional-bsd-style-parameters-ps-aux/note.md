## 173. Extra lecture (optional): BSD-style parameters (`ps aux`)


```bash
ps -ef 

ps aux 
ps a u x 

ps a # all processes from all users 

ps u # user oritented format 

ps x # show processes without a tty (=processes outside of a terminal)


```

# BSD-Style Parameters in `ps`

Linux `ps` supports an older BSD-style syntax where options are written:

```text id="ex3s3i"
WITHOUT dashes
```

Example:

```bash id="’wini346"
ps aux
```

This is extremely common in Linux administration.

---

# 1. Two `ps` Syntax Families

| Style      | Example  |
| ---------- | -------- |
| UNIX/POSIX | `ps -ef` |
| BSD        | `ps aux` |

Linux supports both for historical compatibility.

---

# 2. UNIX Style Example

```bash id="’wini347"
ps -ef
```

Meaning:

| Option | Meaning       |
| ------ | ------------- |
| `-e`   | all processes |
| `-f`   | full format   |

---

# 3. BSD Style Example

```bash id="’wini348"
ps aux
```

Meaning:

| Option | Meaning                                |
| ------ | -------------------------------------- |
| `a`    | processes from all users with terminal |
| `u`    | user-oriented format                   |
| `x`    | include processes without terminal     |

---

# 4. BSD Options Can Be Separated

These are equivalent:

```bash id="’wini349"
ps aux
```

```bash id="’wini350"
ps a u x
```

because BSD options are parsed individually.

Usually people write:

```bash id="’wini351"
ps aux
```

for convenience.

---

# 5. `ps a`

```bash id="’wini352"
ps a
```

Shows:

```text id="’wini353"
all processes attached to terminals
```

from all users.

Without `a`, you normally only see your current terminal processes.

---

# 6. `ps u`

```bash id="’wini354"
ps u
```

Shows:

```text id="’wini355"
user-oriented format
```

with extra columns like:

| Column | Meaning         |
| ------ | --------------- |
| USER   | owner           |
| %CPU   | CPU usage       |
| %MEM   | memory usage    |
| VSZ    | virtual memory  |
| RSS    | resident memory |

Much more informative.

---

# 7. `ps x`

```bash id="’wini356"
ps x
```

Shows processes:

```text id="’wini357"
without a TTY
```

TTY means terminal.

---

# 8. What Is a TTY?

TTY = terminal session.

Examples:

| Process         | Has TTY? |
| --------------- | -------- |
| bash shell      | yes      |
| interactive vim | yes      |
| systemd service | no       |
| nginx daemon    | no       |
| Docker daemon   | no       |

---

# 9. Why `x` Is Important

Without `x`, many important background services are hidden.

Example:

```bash id="’wini358"
ps a
```

may NOT show:

* system services
* daemons
* GUI apps
* desktop processes

But:

```bash id="’wini359"
ps ax
```

will.

---

# 10. Most Common Real Command

```bash id="’wini360"
ps aux
```

This became the classic Linux “show everything” command.

---

# 11. Example Output

```bash id="’wini361"
ps aux
```

Example:

```text id="’wini362"
USER       PID %CPU %MEM    VSZ   RSS TTY   STAT START TIME COMMAND
mohammad  4211  0.1  1.2 123456 54321 pts/0 Sl   10:00 0:01 code
```

---

# 12. Important Columns

| Column  | Meaning       |
| ------- | ------------- |
| PID     | process ID    |
| %CPU    | CPU usage     |
| %MEM    | RAM usage     |
| STAT    | process state |
| COMMAND | executable    |

---

# 13. Process States (`STAT`)

Common values:

| State | Meaning  |
| ----- | -------- |
| `R`   | running  |
| `S`   | sleeping |
| `T`   | stopped  |
| `Z`   | zombie   |

Extra letters may appear:

| Letter | Meaning            |
| ------ | ------------------ |
| `s`    | session leader     |
| `l`    | multithreaded      |
| `+`    | foreground process |

Example:

```text id="’wini363"
Ssl+
```

---

# 14. Useful Real Examples

---

## Find Chrome

```bash id="’wini364"
ps aux | grep '[c]hrome'
```

---

## Find Java apps

```bash id="’wini365"
ps aux | grep '[j]ava'
```

---

## Sort by memory

```bash id="’wini366"
ps aux --sort=-%mem
```

---

## Sort by CPU

```bash id="’wini367"
ps aux --sort=-%cpu
```

---

# 15. Why `ps aux` Is So Popular

Because it gives:

* all users
* all processes
* detailed format
* daemon processes
* GUI processes
* background services

in one command.

---

# 16. Important Difference

---

## `ps`

Shows only current shell processes.

---

## `ps aux`

Shows nearly everything on the system.

Huge difference.

---

# 17. TTY vs No TTY

Example:

```bash id="’wini368"
ps -ef
```

You may see:

```text id="’wini369"
? 
```

under TTY column.

Meaning:

```text id="’wini370"
no terminal attached
```

Typical for daemons/services.

---

# 18. Mental Model

```text id="’wini371"
a  → all users
u  → detailed user format
x  → include no-terminal processes
```

Combined:

```text id="’wini372"
ps aux
```

≈ “show almost everything in detailed format”.

---

# 19. Most Important Commands to Memorize

```bash id="’wini373"
ps
ps aux
ps -ef
ps ax
ps u
ps aux --sort=-%cpu
ps aux --sort=-%mem
```

These are core Linux monitoring commands used daily by:

* sysadmins
* backend engineers
* DevOps engineers
* security engineers
* SREs
