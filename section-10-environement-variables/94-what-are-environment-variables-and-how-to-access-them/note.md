## 94. What are Environment Variables and how to access them?

## 🔹 What are Environment Variables?

![Image](https://images.openai.com/static-rsc-4/oW1Eb7Phq1hST7sRqW1IOUkG2vHyZ6ZdVulpJlJNHC2tQdJnz7r1tjXRG7UyfSXqTDtsrxHgd_Kh2wU84nDafGm4YOFzpdabJpSmaDwFzFGRtEkHz6SOQ-x7oMreK_SolzkYwTxV5kZuSWp7sqstNUNlNB8zqIWA1PD8dO3YixJ9AAMhUlbWjNq4YgvoOmgX?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/5XUN85OgjUYUXKXCPmzPfcwUkNSbcIaywaQG5ISQg7HsP4XI6HOCb2vLRlTvW6KcYEiJhlv-2b4fLef2OOJEFSCnRzFdvWbP5iKrNCwtesH7qFDaGCtD01IGWFx2SS2eBH_q6BJqYkwq1tP7ycrvB_Xkns6RYGMD0Oh2Ci4sqmPMg2vM90-YqiLXeXAYydsd?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/mV_sUMtw_b3KzesvuR2rJPSpGX-_XKRUcup_9EQzANnrX8mcqblwAitsbTCQGqywLWR166zTjetq0Zx8DaRVsQg63n30pW4HpZjmSE7PF96emfPHjfxeYGQHEUXtwMuX7i-92NQVkSwFqJdzbuk6lUjwWTlzxAFVqcuaFyhiV8MfLAJqlUjGYW4rMcKpbz7e?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/Elf24FDH9Q5xpLMnoKpF54TuMHF-tNlc_tTJG944PejhLV9bTlWdMR67aFge0YIkN6RtKmAvQEuiiMcdfFPIHvUi9UJTiLiLOTd_-pdfN4N9wKXHX_El0TdJ1tgbAVGc1yfzo9COwA35QJX3k_5liifsdmkoW_hhLQg7heMHyPWyvEXKSEus_CcDNSPGYVGa?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/CuzVljwCkefb4AqJzHZXv9xV15k0-OXT87_XacRLLlxLSIxEUtiSbsAw09IIA353N7GAcQzvbCjc8TA3sXXBzG4mqJJSwGbAHgw7vzi4Y0PPf8wiA4FsfHbgOoOXI1YqJxVICN6hiYM8LYdYe9AGb2enAhdYJb0mK7m8_YL5_FlgWtDmkO8N2lDOsvqmhRgW?purpose=fullsize)

> **Environment variables** are **named values stored by the shell/OS** that programs can use while running.

Think of them as:

```text
KEY = VALUE
```

---

## 🔹 Simple idea

```text
PATH = /usr/bin:/bin:/usr/local/bin
HOME = /home/mohammad
USER = mohammad
```

👉 These values **affect how your system behaves**

---

## 🔹 Why are they important?

They control things like:

* Where programs are located (`PATH`)
* Your home directory (`HOME`)
* Current user (`USER`)
* Configuration for apps (DB URLs, API keys, etc.)

---

## 🔹 How to view environment variables

### 🔸 1. Show all variables

```bash
printenv
```

or

```bash
env
```

---

### 🔸 2. Show a specific variable

```bash
echo $HOME
```

👉 `$` means: “get the value of this variable”

---

## 🔹 Example

```bash
echo $USER
```

👉 Output:

```text
mohammad
```

---

## 🔹 Most important variable: `PATH`

👉 This is **CRITICAL**

```bash
echo $PATH
```

Example:

```text
/usr/local/bin:/usr/bin:/bin
```

### What it means:

* When you run a command like `ls`
* The shell searches these folders to find it

---

## 🔹 Create your own variable

```bash
MY_NAME="Mohammad"
echo $MY_NAME
```

👉 Output:

```text
Mohammad
```

---

## 🔹 Make it available to other programs (`export`)

```bash
export MY_NAME="Mohammad"
```

👉 Now child processes (like scripts) can use it

---

## 🔹 Temporary vs Permanent

### 🔸 Temporary (current session only)

```bash
export VAR=value
```

---

### 🔸 Permanent (important 🔥)

Add to:

```bash
~/.bashrc
```

Example:

```bash
export JAVA_HOME=/usr/lib/jvm/java-17
```

Then run:

```bash
source ~/.bashrc
```

---

## 🔹 Real-world examples (VERY IMPORTANT for you 💡)

### 🔸 1. Database config (Spring Boot style)

```bash
export DB_URL=jdbc:postgresql://localhost:5432/mydb
export DB_USER=admin
```

---

### 🔸 2. API keys

```bash
export API_KEY=123456
```

👉 Used in backend apps (secure config)

---

### 🔸 3. Add custom commands to PATH

```bash
export PATH=$PATH:/home/mohammad/my-scripts
```

👉 Now you can run your scripts like normal commands 🔥

---

## 🔹 Check all variables with details

```bash
set
```

---

## 🔹 Remove variable

```bash
unset MY_NAME
```

---

## 🔹 Mental Model

```text
Environment Variables = global settings for your shell + programs
```

---

## 🔹 Summary

| Concept    | Meaning                  |
| ---------- | ------------------------ |
| `$VAR`     | Access variable          |
| `export`   | Make variable global     |
| `printenv` | Show variables           |
| `PATH`     | Where commands are found |

---

## 🔥 Pro Insight (important for your career)

You will use environment variables in:

* Spring Boot configs (`application.yml` via env)
* Docker containers
* CI/CD pipelines
* Cloud deployments (AWS, etc.)

👉 They are **essential for production systems**

---

## 🚀 Next Level

If you want, I can teach:

* `$PATH` deeply (how commands are resolved)
* `.bashrc` vs `.profile`
* Environment variables in Docker & Spring Boot (very useful for you)

Just tell me 👍

