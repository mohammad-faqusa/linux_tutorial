## 143. Filesystem Hierarchy Standard (Part 3): /proc, /root, /run, /sbin, /srv, /sys

Great—this is the **final (and more “system-level”) part** of FHS. These directories matter a lot for **servers, debugging, and DevOps work** 👇

---

# 🔹 1) `/proc` — Kernel & process info (you already know 🔥)

![Image](https://images.openai.com/static-rsc-4/Ucabel-ubzDH0MqpRM80lBpaIHGYS-b8zoFjvzRBq0LHR_LvoHU7ZSO0GnIdCTLo2aNm0WBWvClqlpjJndbR0qmQg1GPQGAeP1kjORnOqon9vqOEAvTkaXsdxgMAeSOy0ShU6jrnV_wYIho-gldwQ1GYGkOGsGhqpGkTy-E3PjAoMp2BH0AUXsxLl8o80l7m?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/amONHNDRpPaTYr3BDnE5_QaElF12nLakR2eMOQGtYfwkYr4NV2FRHL2VohTK70OFremYl5uR7Gzm29-cKBgQzvkO83jn-y9kLjGguLjbjYLg8IhRpnv2VZqQqn2ds9pgBjfrzxyrYRX2Yz5NQuLRQpetmqBVskJ5P29504DQxTjDQR3da73y3tsEnVB2KCbC?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/f8plrg_Fc87cwBBKX-gawHbz_3libt8GEQWWe2lE3EPmTRDeosIh_z3kvoh8uZo7nlc4QEnNOi1E7I3XzIdnwsKT1QFrZ2NbfZcqYN4eQFwOFFah_DcdHcC1f1Riqe-vkpM0TWIQzX85Q2AAPnwdQEztr22B4ckpH2A82RXfAh_9CTvVQn9STFs8GLR5fG_4?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/zxGN9iOFIlKb840oJA8umN4H5GHzEefuaq3q8wXlCVb9IwdNTVxu6QnQb-gKaqTf2DdoT1fY8ql_0MTUuVufk9iVqCojogLL3SiZYpDmhI20VvxSHuZoItZXfab5N2LRMK2PepNIDOVBuP0X3cy_MhAiWue0yLBjjQsMl9HBTj1iZedCKaLNdqmZlqVSXxmx?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/y9SzT2Xnv7iZ65gK-xaIjj-J3yQX6ZzFy6-DVpP-C-axtdum2KUb3vWrNb-MDbxif9B3TAjq7Ndnt48cTWC_wuwFSIb7b-w-aih3s5JaAFWBR_Ya_ss77Gd2XamWgvGHVIg9IXltDmBYUrAvuyVqpyn7ZD2LJ3xK-nEAVSEfCQch88qs2aX01EVDECWqlScL?purpose=fullsize)

👉 Virtual filesystem (in RAM)

* system info
* process info

Examples:

```bash id="m6xbhk"
cat /proc/cpuinfo
cat /proc/meminfo
```

---

# 🔹 2) `/root` — root user home

👉 Home directory for **root user (admin)**

```bash id="4qx0f5"
/root
```

---

### 🔥 Important

| User        | Home         |
| ----------- | ------------ |
| normal user | `/home/user` |
| root user   | `/root`      |

---

### 🧠 Why separate?

👉 Security + isolation

---

# 🔹 3) `/run` — Runtime data

👉 Stores **temporary system info during runtime**

```bash id="bl7tcy"
/run
```

---

### Examples:

```bash id="oqvv2l"
/run/nginx.pid
/run/systemd/
```

---

### 🔥 Important

* cleared on reboot ❗
* stored in RAM

---

### 🧠 Think:

```text id="l22hvx"
/run → "what is running NOW"
```

---

# 🔹 4) `/sbin` — System binaries

👉 Commands for **system administration**

```bash id="o92jjy"
/sbin
```

---

### Examples:

```bash id="mrq0ns"
reboot
shutdown
mount
fsck
```

---

### 🔥 Difference from `/bin`

| `/bin`        | `/sbin`               |
| ------------- | --------------------- |
| user commands | admin/system commands |

---

# 🔹 5) `/srv` — Service data

👉 Data served by services

```bash id="d81d3q"
/srv
```

---

### Examples:

```bash id="uq6m4p"
/srv/www/       # website files
/srv/ftp/       # FTP server
```

---

### 🧠 Think:

```text id="3drlr1"
/srv → "data served to users"
```

---

# 🔹 6) `/sys` — System / hardware info (advanced)

![Image](https://images.openai.com/static-rsc-4/Z3wmbbzI1Oi-rYoWSKAhzduC-PESXTyB6sbZWZ7ooXlmEPo627RlVZnqKN1bZ1ZOeYR_I3ShOqCRh33qZNZ0_qgikT6VKzSuHyfpNtdopiHvi9YEhv44m-wYN7CbjZehZMEaJqvpp_pvm-9bt-Q46efWFNugudX0ojq25x_P0P0guTeeKgdDLyQKzN6OqBdH?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/AkcxvOJ9xueR8LtWDUADDuYsORyqc-02hxQ-iHBoD21r9bQmVmzKmta36Xy8Hy3WnlCWwiQRC0_lFJDGFxOPIC7etlnlJ78P09XXi04QpZGlKpz_uUAitRnLKLx9nm-xn-QBwOFes3-UBK5-d6fwTf2RG_OuuOTnTtBjInYV5w-cXeI4XCVP_BPrfmqSFNpc?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/UP_xiZ69faRF4BWA9RJJn19efWSHlJzz3fyAt1Y_pqD0fo6mGE8GFT29GaV4FpK7SgqrmWbgpe9ev1KmTggaOJyLoki23-rg-mFkUY0D-wXoOksINjsXxBmF4z7D7_Ry7ofgNitc3AbALwL8ePsb0y1aRGuV0gL8ES3usA-6d057xuvrQPoDQweuj8ZC2--R?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/owHD1kWSVzZqCo1WsGtarKPNvbYvYNXlevtp2cK9FgCgAMbbPK23QTCaXk_BB4mR-SyXm1W26I2PyImoJsBJ8qop15SNEeg6qL0CT-tET2yL_IcG4ip5H79Gb_MJ7WluUglA3SAFJphByJTmLLGQ_v2udps3CSG5ndofCQhR8Qst8-XFYDee_3AnCw0Fp9vF?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/O30t3FvyZbuhmSUMDimI7uhIfoLQnPOWopt9yGVKJJJwpyoXwiGlF053KsXLAoPYEnIpNXgDWP4sM7JkFzhZaLjEVKeSCu4OTJXYSsoq2xWQvCM2XTwp_oPLrGMFVnPOH_nhgHLACaAf5f1oQxWKUxzGsXrzLVuI6mOO5eNHZw2S_9btpCFXgb1SOBWLb_5W?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/-cKYYMasyYLguOQz0kNfUZK4dUTRKtIzu7uxft8_C_wx-gumgl9KidkD-WXRjKxUXOzksmbJeQgUWur2ti_gHp3sGNMImOfYWdgi-6tXOBcOLMhY-m5HArmQskuYB0uHeETasnFFeOGgMAvRSupjNVtzMzAc4AdI9-EcdrjvkzT3faXjeMqIrawvjHV8y3A7?purpose=fullsize)

👉 Another virtual filesystem (like `/proc`)

* represents hardware devices
* exposes kernel structures

---

### Examples:

```bash id="0bph47"
/sys/class/
/sys/devices/
```

---

### 🔥 Difference from `/proc`

| `/proc`               | `/sys`                    |
| --------------------- | ------------------------- |
| process + system info | hardware + kernel objects |

---

# 🔥 Full Picture (Part 3)

```text id="ct6cfy"
/
├── proc  → kernel/process info
├── root  → root user home
├── run   → runtime data
├── sbin  → admin commands
├── srv   → service data
└── sys   → hardware/kernel interface
```

---

# 🔥 Real-world understanding (IMPORTANT)

### Backend server example:

| Purpose             | Directory |
| ------------------- | --------- |
| running processes   | `/proc`   |
| root admin files    | `/root`   |
| service state (PID) | `/run`    |
| admin commands      | `/sbin`   |
| website data        | `/srv`    |
| hardware info       | `/sys`    |

---

# 🔥 Key Insights

* `/proc` & `/sys` → **virtual (kernel-generated)**
* `/run` → **temporary (RAM, reset on reboot)**
* `/sbin` → **admin tools**
* `/srv` → **data served to users**
* `/root` → **root user home**

---

# 🔥 Interview Answer

> In FHS Part 3, `/proc` and `/sys` are virtual filesystems exposing kernel and hardware information, `/root` is the home directory of the root user, `/run` stores runtime data, `/sbin` contains system administration binaries, and `/srv` holds data served by system services.

---

# 🔥 Final Advice (for YOU)

Now you should start thinking like this:

👉 “Where does this belong in a real server?”

* App → `/opt`
* Config → `/etc`
* Logs → `/var`
* Runtime → `/run`
* Debug → `/proc`

👉 This mindset = **real backend engineer level** 💪

---

If you want next level 🚀

I can give you:
👉 a **real production server structure for your Spring Boot apps**
👉 how companies organize Linux servers properly

Just tell me 👍
