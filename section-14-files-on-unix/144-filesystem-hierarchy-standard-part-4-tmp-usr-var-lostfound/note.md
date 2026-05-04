## 144. Filesystem Hierarchy Standard (Part 4): /tmp, /usr, /var, /lost+found

---

# 🔹 1) `/tmp` — Temporary files

![Image](https://images.openai.com/static-rsc-4/bHqOptP_g6AtuR8jxINoNehZUQCH-EdFMhQQVxbUz3jBxtCYeROCMvvJ5oXFCGfOi0HVB_FcvenBvuRODem_7Zj68eOiLcGfcxDaOrToaQCtlrrF840BoiqXjSD_uPakk04JRZxPez-6adkkv6rAU3YSarsl4WHEM6v1M3TX5xYa-brguuxDRxLnMCJDmWg4?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/7mde_MGuZ-k8PqnZkqVsnizOF6VIl1F-DoFLpHvsKoaTPWKcu9VbFRsLHRnn0UyYxffSryY7AA4nPdRLiPzKmxztdogXvZWaVxCSczIf-XChMdymNPU5x49Ahaez7UMxRuX09gp5kXNWkgZAc03qERIISNNMuP0NMW1N1FYgnKEkL1whzFJkX9QMx0ccdVYm?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/QFLcghkUQjAKOYZKKtBY-WoVF5n05N7UCV_rmlc7NSoBBwndywoaUkYI8Ul8_HsC3LbJ9jvd2jjjVOvnZBEZnWN0hXlT01lPufPYXaaZGKJHwnTG2_wLi9h3HHKuGXeHTM3rxGvmlLJKKrb69Raa6SXeBG8vrEDJAjcyBtTnk-QcOAbg0J4rQ8pTx8S464dA?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/K-5vADcqPhLiFI03sUo7YiU5QqP-rLM8mWvmyJ6QIxKgQDbNm7FalH1JvijpisSCm_M9E7UsN2o0GtzxJqSNbt8R3Va09nPbFE_UGX4sGHlQtj5S75WqOFlhP598LGSmUXvwNbdhXOVbFXxc5JTsKsFutbaj93SmHwX1x4e09Uqk0LkEhZkFKC7d_L_oMQ6h?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/GFwKYOfRSUvd1IIO7G3FhKLdtq2v0LBlFJGuSerJe_fXDMMK8-bpfIGpzrXnJiX8CrchAd1B9Zq3gTSF-3ovd8beq1yDu3AzuwVOCiOwTiRphGg8S0x1WRyDoXJmWIhW9iFc31kS16Hx7pNvXPcJVq_huUKZ1BJMvRgstHIKZ40XX-ExyddSZ-v8sUnbgDLZ?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/5f8dgPC7vYq8LoZ9vLjf6q53_G7MxGubOABMOiZOlRZjRsVjfgaGfkwGr-4MUcnMLyrlE1-_vvJlEK6AKDLtYn6223xAJ9aByWxu2EvRObj9ZAXTACfbCtNVDax22sSJ4R36wBMOWOxfdum_K9dJe7u6L861TxkXlZ33_RVcL6NCrDaE9rMnbBGlwmX2pLl3?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/SY7H_EJy3UZh7X_90t6gQSDk_sM8X1WfOt9nKcm3-RY2Nj2hwd342hYHfCX65s4Z8rlWKReiOZsVvb8oNYaPEkdWW3rvi-tFuoX2kbSyC0I3DtxA6G9ej_1M4ZpGJcgM51IFpEYyRvTqbmRElAWf_X3Zc6RUj2hLFMMbAGgcOW8RbsIymQPPRyYYmw88wWf0?purpose=fullsize)

👉 Used for **short-lived temporary data**

```bash
/tmp
```

### 🔥 Key properties

* world-writable (any user can write)
* often **cleared on reboot**
* not guaranteed to persist

---

### 🔹 Examples

```bash
/tmp/upload_123.tmp
/tmp/session_cache/
```

---

### 🧠 For YOU

👉 Your apps may store:

* temp uploads
* intermediate files

---

### ⚠️ Important

Don’t store important data here ❌

---

# 🔹 2) `/usr` — User programs & libraries

![Image](https://images.openai.com/static-rsc-4/fPeaU5VKcmR1IrhUwWFGouugTkp7IsNI6jjp9eluRKINa27YSBuNOJVY6iD07cdJ8qX0WGeTv2yBXCjDk8nUbeHvPRAwTyDr9I2m2euzdUpIn1VPAWFW9YsQ25U_s9KRsAK0jqxjz3AE9DmeLSyJ0NwauIG9DpBYxxDfALq5rBgB6uqF-qOlQ0Wkb_1QQjKV?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/TYcjhzO7FTvC0EXfuVM5SDwI7hSY6JGsZMO5Hh_ItrXsLe9Bw1HnXUnaEQBwmMQpF6N9vupq9InFd-TAFexj-56LE75Prvf_9ihKWk4wetU-I-YCMcjB77fULtxaNI78Ds-nDl-NtIPOWw7vLmN4dlbgn8GX6AGumwuPoi0N23-mSaHzrwKHlmAzw5TO89kI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/F_LNEPHTC-Whxjru3Wi1CqbO4uGHZG5x_TpCNa4QdTe7thYozeYxzB9XnYvA2F1Y8Ik2n2siJraBTI4UtNK84p8cnE5STVWqLYKkJ1nHKGY5HklPXz6sKqhGuI9V8X9LBaSGk0EHUvmAUvIbhJuhQPdgYOy_7hJXKGXIe5I6WwFRHMIvX8n63sKhwN43nQLJ?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/9l5ZpkJboo5L8uMnK9xIeh0TMF4bOWw1JEFrXd8kWf-Cyk1_pxs585UWicMxVlM58axhTvqQgEBhsXluxkjNmIJPPSRVYx_mCLx5XxJ1BHuuldPehy1w77H0EAxE34tD_q_VsqPSRea8cYciaoFa4_6aT0MIIuh16awRascsdBxHiRaTv5o1JMvN0MA4yEy3?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ohnpI6VqZ9bJqFrQnYE485XflEpo1eaEv17I3mQ-FXyXwmWMLsXms7SEMdMjk7d16pgfqKv1zqHEje_LseWN1ik-ZYgCJ_NUA-rK16mCe-m-qMeKB8h8Q2uLK0YojRKWjLu9D2ii2cjl1zHbL4t-HzPDJLykKRNKQJPq_CSzAf62LCrN7zPWVqnRwokob6i_?purpose=fullsize)

👉 Contains **most installed software**

```bash
/usr
```

---

### 🔥 Important subfolders

| Folder       | Purpose                   |
| ------------ | ------------------------- |
| `/usr/bin`   | user commands             |
| `/usr/lib`   | libraries                 |
| `/usr/share` | shared data (docs, icons) |
| `/usr/local` | custom installed programs |

---

### 🧠 Think

```text
/usr → "everything installed in the system"
```

---

### 🔥 For YOU

* system packages → `/usr/bin`
* your custom builds → `/usr/local/bin`

---

# 🔹 3) `/var` — Variable data (VERY IMPORTANT)

![Image](https://images.openai.com/static-rsc-4/6_ZYC3ShmajvSrJMciARBGTgD9T0S74mjXERbLz8JDboabzKMVGEFkuXsKlbb5XxC3df2r21xf6CeJryOkdowewv4cHhn6OKIpVqnCnZbd5pY0D_Jf2Yn3wW11y1to4BnttKCKk3eKNv6_-UiR1_-vZ7oLzRc6yt1qMTuJNfTxCavUZve1Jjb71Ybf-7yH2S?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/auFKSA86fhwmfHrdFdSQG4ZHv6dGAfG5NBLsx8LuWbEwqKLbfad5tofsIJZDaPBb97uPxIXgJe7BZEYg6srRQVdQotpy0OwhCoHF8YShu5evCpbNnYt9DOfTxb-eQyB7-LqHWiAyixmUDjDAhTfrgoq_plrIGvAA8yMJQDZ6DIGrV8suW-mpVpF8OGVIec5_?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/oVzV5nkEESmh5Q45ntC7CHfJHhumLr81XOFgFB2L6VFVngosYL7T45tSnm8ajJjXshLJaymj3mCCBFIpqW5cB3uok2Y2gPSQqL0ntzAsdxTraPrUCuwrLmcv74aqIJ5TnlR4YELEI7AR9fFvg6BMHuu9CwTzZXTWMBqqHTbeZTiq-Jsaz2IKnBqHeHgzN7tS?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/o-5biCVekZWIXUxiPLuJvLnpla2h4JAWXCAVHoSLdKYyIgKrJLMbwTfcl5GkgGhvwic3EjDRUIiDxaAhRC5DXuBaynN-OpA9CXRozx_tl-wirMffmChTiGnOpa3Ad449wZMUjG0KdlUjL0o_8TIC6Cq8alJgYpzmXZbiic42n0g50sg9MZVZg4_KlsxDRy-V?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/uWIemluh0CyFfj_6vyHl4eyE17wIy5oTAtlVkmI7ghX9THm5znoliB2bdb2zdVZesT3J5cErQ5RY0TQWS68XzjoW6R44OL9XntNykGH2fiWJ4mT-abTzFpPwN0IuRPR9mM3DkPBvGiBC8dmRdLqMbJjw1ZptmNmaHXpXWAyEh_TNHTCgBS53_CakqyGfOoQO?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/z2xzDnxnZ2Va-6gWKM_qG-7d1uBvMymMfjpNJk29swGEZOF466CvghYxhCqn42ZRyJHMNkSOqE7nHByDWZvFv7-tIJ1SNd2STMyoP8ucyxA_Mz-PpSnDumcmMtS7aX2b_k9c1Imb5WTTjC5ln5fB__y1OnJ1AiCQZ_UPjhGJdHTrA7p2XJ_PRowoHz_ZcMd2?purpose=fullsize)

👉 Stores data that **changes frequently**

```bash
/var
```

---

### 🔥 Important subfolders

| Folder       | Purpose     |
| ------------ | ----------- |
| `/var/log`   | logs        |
| `/var/lib`   | app data    |
| `/var/cache` | cache files |
| `/var/spool` | queued jobs |

---

### 🔹 Examples

```bash
/var/log/syslog
/var/log/nginx/
/var/lib/mysql/
```

---

### 🧠 For YOU (VERY IMPORTANT)

👉 Your backend app:

* logs → `/var/log/myapp`
* runtime data → `/var/lib/myapp`

---

# 🔹 4) `/lost+found` — Recovered files

👉 Special folder created by filesystem (ext4)

```bash
/lost+found
```

---

### 🔥 Purpose

Used when:

* system crashes
* disk corruption
* `fsck` (filesystem repair) runs

👉 recovered files are placed here

---

### ⚠️ Notes

* usually empty
* don’t delete it
* system manages it

---

# 🔥 Full Final Structure (All Parts Combined)

```text
/
├── bin      → basic commands
├── boot     → boot files
├── dev      → devices
├── etc      → config
├── home     → users
├── lib      → libraries
├── media    → auto mounts
├── mnt      → manual mounts
├── opt      → optional apps
├── proc     → kernel info
├── root     → root home
├── run      → runtime data
├── sbin     → admin tools
├── srv      → service data
├── sys      → hardware info
├── tmp      → temp files
├── usr      → installed software
├── var      → logs & variable data
└── lost+found → recovered files
```

---

# 🔥 Real Production Example (IMPORTANT)

For your future backend app:

| Type       | Location         |
| ---------- | ---------------- |
| app        | `/opt/myapp`     |
| config     | `/etc/myapp`     |
| logs       | `/var/log/myapp` |
| temp files | `/tmp`           |
| binaries   | `/usr/local/bin` |

---

# 🔥 Key Insights

* `/tmp` → temporary (can be deleted anytime)
* `/usr` → installed software
* `/var` → dynamic data (logs, DBs)
* `/lost+found` → recovery folder

---

# 🔥 Interview Answer

> In FHS Part 4, `/tmp` is used for temporary files, `/usr` contains user-level programs and libraries, `/var` stores variable data like logs and databases, and `/lost+found` is used by the filesystem to recover lost files after crashes.

---

# 🔥 Final Advice (for you)

If you master all 4 parts of FHS:

👉 You can:

* debug servers
* deploy apps properly
* work like a real DevOps engineer

---
