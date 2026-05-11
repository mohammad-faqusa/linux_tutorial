## 195. Suspending Jobs with Output using stty
### 195. Suspending Jobs with Output using `stty`

In Linux terminal job control, **`stty`** (short for *set teletype*) is used to configure terminal behavior, including how processes respond to signals like **Ctrl+Z** (suspend).

---

## 🔹 What is “suspending a job”?

When you press:

* **Ctrl + Z**

the running foreground process is **paused (suspended)** and sent to the background in a *stopped state*.

Example:

```bash
ping google.com
```

Press:

```
Ctrl + Z
```

You will see:

```
[1]+  Stopped     ping google.com
```

---

## 🔹 What does `stty` have to do with this?

Normally, the terminal defines how control characters behave:

* Ctrl + C → interrupt (`SIGINT`)
* Ctrl + Z → suspend (`SIGTSTP`)

You can view current settings:

```bash
stty -a
```

---

## 🔹 Disabling or modifying suspend behavior

You can change how suspension works using `stty`.

### 🚫 Disable Ctrl + Z (suspend key)

```bash
stty susp undef
```

Now Ctrl + Z will NOT suspend the process anymore.

---

### 🔄 Restore default behavior

```bash
stty susp ^Z
```

---

## 🔹 Why “suspending jobs with output” matters

Some programs:

* keep printing output even after suspension
* or behave oddly if terminal control is modified

Example:

```bash
yes hello
```

If suspended:

* output may still appear briefly depending on buffering
* terminal may look “frozen” or flooded when resumed

---

## 🔹 Managing suspended jobs

After suspending:

### List jobs

```bash
jobs
```

### Resume in foreground

```bash
fg %1
```

### Resume in background

```bash
bg %1
```

---

## 🧠 Key idea

* `Ctrl + Z` → sends **SIGTSTP (stop signal)**
* `stty` → controls whether terminal even interprets that key
* job continues or stops based on terminal + process handling

---

If you want, I can also explain:

* difference between **SIGSTOP vs SIGTSTP**
* or how `stty` is used in scripting and TTY control internally
