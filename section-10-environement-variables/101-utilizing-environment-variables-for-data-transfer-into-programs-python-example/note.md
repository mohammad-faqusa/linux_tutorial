## 101. Utilizing Environment Variables for Data Transfer into Programs (Python example)
## 🔹 Using Environment Variables to Pass Data into Programs (Python)

![Image](https://images.openai.com/static-rsc-4/i6EvrkG4HfSvBmOfz9e4v10kI8kn2wrEdvdXRC4j_Bt6VDrgv-9hhtyBFlxZ5iT7ZydMBBzgVxqHYjYLJprgj_PFdR3xMmUsg2-_iRsdStoUb6_s1jo8GL44ht2vmWaO1EUFh358-MXmT4UMzYgnJqkOqTm__0LvKI4my_O5ORSF6D3eS7TJitTQag-CtKNJ?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/Y5Ls_LNuvg-H8bacfUos-4RRlluyO_9zl9G_CRVFnuNQ2DhzDT4k_i6NfQdTpk9n7VjTAwXQentzzQBQhlTTG_rwQUTSlPFlZS1pGGTwLMZdsAatX3hyS9sqmOsCz0UDic9gWi_luSOghtH1T2LNz4M7wRSD_PB7vfngx4A270ucN-6rZF2kS7hw2-JLjkIc?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/9FSO2IK2DT8cWPSshkDGvpA5gHO5HdhitXCKkkWugeTxw4Nz0kz0LdH8JB9a1qqF_ro0CQV1LF-7LR4sauRvDSnyJmU7R7pEhAle0Q4JIHGOSW3YCBlzurzDAh1jmTB2FLXLL8uAv6kmcfzXV3lkCsloXnbtP8t2vYBiOFzNjZTIsT-gs8CBJqxybIisNOY-?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/b9-sIxd0zqK8DwwnPHc5ittic1dcnLaw0WrMb0VeincFOXeRNLALTzoZ7rJu_eIoaABk58T7y6Bv8zi_fM3e0Yrx_kVNrzRX7o-32FIZWbiBRr7fTxXxCExRSjK5dFieC4x2C8umPda9nhGLKqD_IGKq0tll3nIb9QWXxdzVHN3rLC_mYRu14V3fynVOS3wI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/--NkJZ7743OJx16n0mJIYUWdlkl_cycTNJx6tqCs_Duz3FJ2NOLIIVZJXX6y7mtovyVS4cSwH_N1CWsH8lJKS-Hv-japuHlp578jJyMoh-I9X0L3JFI5ZsBoqjf77zAl9dChsOAzdsuAEEHuJQQzDRTfPgRGkOln2OaKJ-rAtOmFrL-1r3nTAdO87yDANtcQ?purpose=fullsize)

> **Idea:** Instead of hardcoding values (DB URLs, API keys), you **inject them from the shell** via environment variables.
> Your Python app reads them at runtime.

---

# 🔹 1) Set variables in the shell

```bash
export DB_HOST=localhost
export DB_PORT=5432
export API_KEY=abc123
```

---

# 🔹 2) Read them in Python

```python
import os

db_host = os.environ.get("DB_HOST")
db_port = os.environ.get("DB_PORT")
api_key = os.environ.get("API_KEY")

print("DB:", db_host, db_port)
print("API:", api_key)
```

👉 `os.environ.get("VAR")` returns:

* the value if it exists
* `None` if not set (safe)

---

## 🔸 Safer pattern (with defaults / required checks)

```python
import os
import sys

db_host = os.environ.get("DB_HOST", "127.0.0.1")  # default
db_port = int(os.environ.get("DB_PORT", "5432"))

api_key = os.environ.get("API_KEY")
if not api_key:
    print("Missing API_KEY")
    sys.exit(1)
```

---

# 🔹 3) Run the program

```bash
python app.py
```

👉 It picks values from the environment

---

# 🔹 4) One-time (inline) variables

```bash
DB_HOST=prod.db.com API_KEY=secret python app.py
```

👉 Only for this command (doesn’t persist)

---

# 🔹 5) Using a `.env` file (common in projects)

## Example `.env`

```env
DB_HOST=localhost
DB_PORT=5432
API_KEY=abc123
```

## Load in Python

```python
from dotenv import load_dotenv
import os

load_dotenv()  # reads .env

print(os.getenv("DB_HOST"))
```

👉 Install:

```bash
pip install python-dotenv
```

---

# 🔹 6) Real-world use (VERY IMPORTANT 💡)

### 🔸 Backend configs

* DB connection strings
* Redis URLs
* Feature flags

### 🔸 Secrets

* API keys
* Tokens
* Passwords
  👉 Never commit these to Git

---

# 🔹 7) With your stack (Spring Boot idea applies too)

Even though you use Spring Boot, same principle:

```bash
export DB_URL=jdbc:postgresql://localhost:5432/mydb
export DB_USER=admin
```

👉 Apps read from environment → clean + secure

---

# 🔹 8) Debugging variables

```bash
printenv | grep DB
```

---

# 🔹 Mental Model

```text
Shell (export VAR=value)
        ↓
Environment
        ↓
Program (Python reads via os.environ)
```

---

# 🔹 Common mistakes ⚠️

* ❌ Forget `export` → Python can’t see it
* ❌ Hardcoding secrets → security risk
* ❌ Assuming variable exists → crash

---

# 🔹 Summary

| Step | Action                        |
| ---- | ----------------------------- |
| 1    | `export VAR=value`            |
| 2    | Read in Python (`os.environ`) |
| 3    | Run program                   |
| 4    | Use `.env` for projects       |

---

# 🔥 Pro Insight (for your career)

Environment variables are used everywhere:

* Docker (`-e VAR=value`)
* Kubernetes (ConfigMaps / Secrets)
* CI/CD pipelines
* Cloud (AWS, GCP)

👉 This is **production-level configuration management**

---

## 🚀 Next Step

If you want, I can show:

* Using env variables in Docker containers
* Spring Boot + env variables (very relevant to you)
* Secure secrets management (real-world DevOps 🔥)

Just tell me 👍
