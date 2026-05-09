## 171. Monitoring Processes: The `ps` Command


```bash
ps 

bash # start another process 

ps # list all processses in the current terminal 

ps -A 
ps -e # list all the processes from all users and all sessions 

ps -f # show extended information 

ps -ef 

ps -p 1234 , 1235 # limit the processes that we are interested 

ps -ef | less 

ps -ef | grep 1234 

ps -l # show entries in long format 
ps -lf 


```

# Monitoring Processes with `ps`

The command:

```bash id="jlwm284"
ps
```

means:

```text id="’লb1"
process status
```

It displays information about running processes.

---

# 1. Basic `ps`

```bash id="’wini285"
ps
```

Shows processes attached to:

```text id="’wini286"
current terminal session
```

Example:

```text id="’wini287"
PID TTY          TIME CMD
4211 pts/0    00:00:00 bash
4300 pts/0    00:00:00 ps
```

---

# 2. Start Another Process

Example:

```bash id="’wini288"
bash
```

Now you started another shell process.

Run:

```bash id="’wini289"
ps
```

You will now see multiple bash processes.

---

# 3. Show ALL Processes

---

## `ps -A`

```bash id="’wini290"
ps -A
```

or:

```bash id="’wini291"
ps -e
```

Both mean:

```text id="’wini292"
show every process on system
```

---

# 4. Extended Information

```bash id="’wini293"
ps -f
```

`-f` means:

```text id="’wini294"
full format
```

Example columns:

| Column | Meaning        |
| ------ | -------------- |
| UID    | user           |
| PID    | process ID     |
| PPID   | parent process |
| C      | CPU usage      |
| STIME  | start time     |
| TTY    | terminal       |
| TIME   | CPU time       |
| CMD    | command        |

---

# 5. Full System + Full Format

Very common:

```bash id="’wini295"
ps -ef
```

Combination of:

| Option | Meaning       |
| ------ | ------------- |
| `-e`   | all processes |
| `-f`   | full format   |

---

Example:

```text id="’wini296"
UID   PID  PPID CMD
root    1     0 /sbin/init
```

---

# 6. Filter Specific PIDs

Example:

```bash id="’wini297"
ps -p 1234,1235
```

Only show selected processes.

Very useful for debugging.

---

# 7. Paging Large Output

Because `ps -ef` can be huge:

```bash id="’wini298"
ps -ef | less
```

You can scroll safely.

Controls:

| Key     | Action |
| ------- | ------ |
| `j` / ↓ | down   |
| `k` / ↑ | up     |
| `/`     | search |
| `q`     | quit   |

---

# 8. Searching Processes

Example:

```bash id="’wini299"
ps -ef | grep 1234
```

or:

```bash id="’wini300"
ps -ef | grep chrome
```

---

Professional safer version:

```bash id="’wini301"
ps -ef | grep '[c]hrome'
```

avoids matching grep itself.

---

# 9. Long Format

```bash id="’wini302"
ps -l
```

Shows:

```text id="’wini303"
long format
```

with technical info like:

| Column | Meaning         |
| ------ | --------------- |
| F      | flags           |
| S      | state           |
| PRI    | priority        |
| NI     | nice value      |
| ADDR   | memory          |
| SZ     | size            |
| WCHAN  | waiting channel |

---

# 10. Long + Full

```bash id="’wini304"
ps -lf
```

Very detailed output.

Useful for advanced debugging.

---

# 11. Important Process States

In `ps` you often see:

| State | Meaning               |
| ----- | --------------------- |
| `R`   | running               |
| `S`   | sleeping              |
| `D`   | uninterruptible sleep |
| `T`   | stopped               |
| `Z`   | zombie                |

Example:

```text id="’wini305"
S
```

means process sleeping/waiting.

Most processes are sleeping most of the time.

---

# 12. PPID — Parent Process ID

Example:

```text id="’wini306"
PID   PPID
4300  4211
```

Meaning:

```text id="’wini307"
process 4211 created process 4300
```

Linux processes form a tree.

---

# 13. Common Useful `ps` Patterns

---

## Show current shell PID

```bash id="’wini308"
echo $$
```

---

## Show process tree

```bash id="’wini309"
ps -ef --forest
```

Very nice hierarchy display.

---

## Sort by memory

```bash id="’wini310"
ps aux --sort=-%mem
```

---

## Sort by CPU

```bash id="’wini311"
ps aux --sort=-%cpu
```

---

# 14. BSD vs UNIX Syntax

Linux `ps` supports two styles:

| Style | Example  |
| ----- | -------- |
| UNIX  | `ps -ef` |
| BSD   | `ps aux` |

---

Important:

```bash id="’wini312"
ps aux
```

does NOT use dashes.

Historic compatibility reason.

---

# 15. Understanding `ps aux`

Very common command.

| Option | Meaning                            |
| ------ | ---------------------------------- |
| `a`    | all users                          |
| `u`    | user-oriented format               |
| `x`    | include processes without terminal |

---

# 16. Example Real Workflow

Suppose server slow.

You do:

```bash id="’wini313"
ps aux --sort=-%cpu | head
```

Find top CPU consumers.

Or:

```bash id="’wini314"
ps aux --sort=-%mem | head
```

Find RAM-heavy processes.

Very common in DevOps.

---

# 17. `ps` Snapshot vs `top`

Important difference:

| Tool  | Behavior          |
| ----- | ----------------- |
| `ps`  | one-time snapshot |
| `top` | live updating     |

---

# 18. Very Useful Real Commands

---

## Find Java processes

```bash id="’wini315"
ps -ef | grep java
```

---

## Find Spring Boot app

```bash id="’wini316"
ps -ef | grep '[j]ava'
```

---

## Find process using port

```bash id="’wini317"
sudo lsof -i :8080
```

---

## Find VSCode

```bash id="’wini318"
ps aux | grep '[c]ode'
```

---

# 19. Professional Linux Monitoring Stack

Typical tools:

| Tool     | Purpose                |
| -------- | ---------------------- |
| `ps`     | process snapshot       |
| `top`    | live monitoring        |
| `htop`   | interactive monitoring |
| `pstree` | hierarchy              |
| `lsof`   | open files             |
| `strace` | syscall tracing        |

---

# 20. Commands to Memorize

```bash id="’wini319"
ps
ps -e
ps -ef
ps aux
ps -lf
ps -p PID
ps aux --sort=-%cpu
ps aux --sort=-%mem
ps -ef --forest
```

These are foundational Linux administration commands.
