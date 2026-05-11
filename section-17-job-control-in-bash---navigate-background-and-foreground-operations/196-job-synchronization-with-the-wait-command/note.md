## 196. Job Synchronization with the `wait` Command

### 196. Job Synchronization with the `wait` Command

In Linux, the **`wait` command** is used to **synchronize processes (jobs)** by making the shell pause until one or more background jobs finish.

---

## 🔹 Basic idea

When you run a process in the background:

```bash
sleep 5 &
```

The shell immediately continues. But sometimes you want the shell (or script) to **wait until it finishes**.

That’s where `wait` comes in.

---

## 🔹 Simple usage

### Wait for all background jobs

```bash
wait
```

👉 The shell will pause until **all background processes are done**.

---

### Example

```bash
sleep 3 &
sleep 5 &
wait
echo "All done"
```

🧠 Output behavior:

* both `sleep` processes run in parallel
* `echo "All done"` runs only after both finish

---

## 🔹 Wait for a specific process (PID)

You can wait for a particular process ID:

```bash
sleep 10 &
pid=$!
wait $pid
echo "sleep finished"
```

### 🔑 Important variable:

* `$!` → gives PID of last background job

---

## 🔹 Wait for multiple jobs

```bash
sleep 2 &
sleep 4 &
pid1=$!
pid2=$!

wait $pid1
wait $pid2

echo "both finished"
```

---

## 🔹 What happens internally?

* Each background job runs independently
* `wait` tells the shell:

  > “Do not continue until this process exits”

This is called **job synchronization**.

---

## 🔹 Exit status capture

`wait` also captures the exit code:

```bash
sleep 2 &
wait $!
echo $?
```

* `$?` → exit status of the waited process
* useful for error handling in scripts

---

## 🔹 Real-world usage

### ✔ Parallel tasks in scripts

```bash
task1 &
task2 &
task3 &

wait
echo "All tasks completed"
```

### ✔ Build pipelines / CI systems

Used in:

* deployment scripts
* testing pipelines
* batch processing systems

---

## 🔹 Difference: `wait` vs `fg`

| Command | Purpose                                |
| ------- | -------------------------------------- |
| `wait`  | waits silently in scripts              |
| `fg`    | brings job to foreground (interactive) |

---

## 🧠 Key takeaway

* `&` → runs process in background
* `wait` → synchronizes and pauses until completion
* `$!` → tracks background process PID
* essential for **parallel execution control in shell scripting**

---

If you want, I can also show you a **real production-style script using wait (like parallel downloads or microservices startup ordering)**.
