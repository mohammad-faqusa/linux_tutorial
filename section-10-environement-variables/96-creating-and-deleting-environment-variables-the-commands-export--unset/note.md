## 96. Creating and Deleting Environment Variables: the Commands `export` & `unset`

## 🔹 Creating & Deleting Environment Variables: `export` & `unset`

![Image](https://images.openai.com/static-rsc-4/mV_sUMtw_b3KzesvuR2rJPSpGX-_XKRUcup_9EQzANnrX8mcqblwAitsbTCQGqywLWR166zTjetq0Zx8DaRVsQg63n30pW4HpZjmSE7PF96emfPHjfxeYGQHEUXtwMuX7i-92NQVkSwFqJdzbuk6lUjwWTlzxAFVqcuaFyhiV8MfLAJqlUjGYW4rMcKpbz7e?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/OsRD8Xs2Ss0xjZULY-pE8n8ebAdUp0kdXNiTP4SNiQHleu0_nxjCF1H-SdR_iXvukovayg7ekc-XFO258KCj62JyVwMQrsv9Ynk_Q7Vi5JtL9ZX2nFwzWA3FATNMGqW2f2dVw-W216OicwlDxIVHa_HuJlX0d5cv8brLmMMCLU41BPVxx1jT2e4ibbVhLok6?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/DWWz52UcnT8sV0Lh3Ryo5MX2776-lV0RAzabSvcUkdaA-oivDOH7puil0g1KT--We7X2-J_COK_n_aL03ETfiUGtVBUZGo9SPR178igqRRFpqgFKi8UCSkgCnl9dii08OjatXG2lhL3IjE0B7IyRNzIErk2G4XfTlret6dRV-qdw8fS7D6ic0yXpi3WG6sg8?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ZE-rklz98DuWUjZuVR48Qlnv6C2cSAJiWUsVmxS2iwVDsI-Uu9RfycqlosxQE23bt90AYatMIiCYAEEtofgquG-zL6-qMclLBz02cyAVV_8j8oNTJz0yMM4GOtQ0CRa38KI545ZSBxKCPrYliocxq7T4gKVTPxQEZ6hS9GI1r-Z8OXtrH0f-Bn64L7z-5R0y?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/iL3JlHYZhtJa353Tb2lziutkLZGaxJw2aD7nxL0Yx4J6tWeIZhyjgMBfGGS2vSjt8Hm5XCRHO1vH5pM7RXmENpb-BmqeEbloziY1LWJlorftiIX9IZnvhL9A2SLw-XRdztob0TM2xXmp4qowxkBZgsfU2MYPjrOIS36BAE_S4A4aJoHhm0zZxMHzofMRwfN_?purpose=fullsize)

---

# 🔸 1) `export` — create/share variables

> **`export` makes a variable available to child processes (programs, scripts, subshells).**

---

## 🔹 Create a shell variable (local only)

```bash
MY_NAME="Mohammad"
echo $MY_NAME
```

✔ Works in the current shell
❌ Not visible to child processes

---

## 🔹 Make it an environment variable

```bash
export MY_NAME="Mohammad"
```

### Verify

```bash
printenv MY_NAME
```

---

## 🔹 Why `export` matters (scope)

```bash
MY_VAR="hello"
bash -c 'echo $MY_VAR'   # empty (not exported)

export MY_VAR="hello"
bash -c 'echo $MY_VAR'   # prints "hello"
```

👉 **Only exported variables are inherited by child processes**

---

## 🔹 Update `PATH` (very common)

```bash
export PATH="$PATH:/home/mohammad/my-scripts"
```

👉 Now your scripts run like normal commands

---

# 🔸 2) `unset` — delete variables

> **`unset` removes a variable from the shell (and environment).**

---

## 🔹 Example

```bash
export TEMP_VAR="123"
echo $TEMP_VAR   # 123

unset TEMP_VAR
echo $TEMP_VAR   # empty
```

---

# 🔹 Temporary vs Permanent

## 🔸 Temporary (current session only)

```bash
export DB_URL=jdbc:postgresql://localhost:5432/app
```

👉 Lost when you close the terminal

---

## 🔸 Permanent (important 🔥)

Add to:

```bash
~/.bashrc
```

Example:

```bash
export JAVA_HOME=/usr/lib/jvm/java-17
export PATH="$PATH:$JAVA_HOME/bin"
```

Then apply:

```bash
source ~/.bashrc
```

---

# 🔹 Real-world examples (for you 💡)

## 🔸 1. Spring Boot config

```bash
export DB_URL=jdbc:postgresql://localhost:5432/mydb
export DB_USER=admin
export DB_PASS=secret
```

---

## 🔸 2. API keys (never hardcode!)

```bash
export OPENAI_API_KEY=your_key_here
```

---

## 🔸 3. Run app with env

```bash
DB_PORT=5432 java -jar app.jar
```

👉 Inline variable for one command

---

# 🔹 Inspect variables

```bash
printenv        # environment only
set             # all shell variables
```

---

# 🔹 Mental Model

```text
VAR=value        → local to shell
export VAR=value → global (to child processes)
unset VAR        → remove it
```

---

# 🔹 Common pitfalls ⚠️

* Forgetting `export` → app can’t see the variable
* Overwriting `PATH`:

  ```bash
  export PATH=/new/path   # ❌ removes old paths
  export PATH="$PATH:/new/path"  # ✅ correct
  ```
* Using `unset` in scripts without checking → may break logic

---

# 🔹 Summary

| Command            | Purpose                   |
| ------------------ | ------------------------- |
| `export VAR=value` | create/share env variable |
| `VAR=value`        | create local variable     |
| `unset VAR`        | delete variable           |

---

## 🚀 Next Step

If you want, I can show you:

* `.bashrc` vs `.profile` vs `/etc/environment`
* Using env variables in Docker & Spring Boot (very relevant to your stack)
* Debugging “env not found” issues in production 🔥


