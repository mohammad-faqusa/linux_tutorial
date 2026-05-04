## 141. Filesystem Hierarchy Standard (Part 1): / (root), /bin, /boot, /dev, /etc

Great—this is the **foundation of Linux structure**. If you understand this, you won’t feel lost in any system 👇

---

# 🔥 What is the Filesystem Hierarchy Standard (FHS)?

> The **Filesystem Hierarchy Standard (FHS)** defines how directories are organized in Linux.

👉 It answers:

```text
Where should things live in the system?
```

---

# 🔹 1) `/` — Root directory

![Image](https://images.openai.com/static-rsc-4/N7FkJ6-GzCBweuFM_jnd78IUHt66pmHpS9tFVnXb5w04ZA8y1l2m9cHEUoSnfFf-u9I2sySe1QogyffESshrabar7WgphTL6x1uNLwuOfrBZJUVWG5bWUqb-xZbOMNRO5nzATIXdPQajlRoInUToxqg12UbGQbhrDgDGZajAhEX0ZPgqz47sx6aaKanoIxRT?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/RytlGPdXgSEiLIUlf4lU5sE2wda368ox-GlurxIbvihziXzINBdIRKpjqsLL2KME7rROezDLSCqw9JrI5Bw1xIimPk44nQClttjwDNdixw1FA8atch18R8y2QtcXcgSSueW6wHsmXSUjZkXW0PBxFxPngP7pF9IqSZm0sQPTdpww9jAMgqWQwhpSFvC8jcDM?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/_2W8pPbgDkMLWWWzG7CIbTXurCitAUt5LqnP5ow1GxSnYB2Epq14rG2RS-YVsOPQkGSyHEQf6uauNqTc5wkTjSCkvB-IMes_uBin_nED2hBn-xX5meO5RM5z7BUB4kxJqR9FT_JTW-9cEh--nsaTJDDgPr_fzyKubFAzWiaH6Evz08rf6uXbIaJNMJ4VNlwn?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/TYcjhzO7FTvC0EXfuVM5SDwI7hSY6JGsZMO5Hh_ItrXsLe9Bw1HnXUnaEQBwmMQpF6N9vupq9InFd-TAFexj-56LE75Prvf_9ihKWk4wetU-I-YCMcjB77fULtxaNI78Ds-nDl-NtIPOWw7vLmN4dlbgn8GX6AGumwuPoi0N23-mSaHzrwKHlmAzw5TO89kI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/EOlAd4aPG7dckWbHaVz8JchZFPZQ6rot6haqj85EuRCVR1U2TN1hc8qxxMRxwZa7ZWRPEdo5-qvwsKHWQzaEbPNVvDEiaj_D6MEEgcMPsjN1iJlb92_Oi6Yn0rwmmADwdciVwr0VlmWMNYvfO3Rl6Le9sLam36iRKOUmyGIxq5Hi3MuUPsEiidd-Cc1iRQor?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/r_TTDrJ0k5pwAoG5Bgw-p40d1OryVhinI6JVo_9hjEyfC6ukvdhAxuC0LdqKrupoAxU0YTonbieJ1V3bzOQJzqPH64UulAGmVlkh-O-XCbu8V2oqp1O2soKCQaCQPri4HLvr7ATX26c81J5b62ry8SdVlVj5ajG8m-Qjc2dgbOFHNvzZwjPO7F8EJ0VFk7LV?purpose=fullsize)

👉 This is the **top of everything**

```bash id="1mqb21"
/
```

* All files and directories start here
* There is **no parent above `/`**

---

# 🔹 Think:

```text id="l5dyj2"
/ → everything starts here
```

---

# 🔹 2) `/bin` — Essential binaries

👉 Contains **basic commands** needed for the system to run

```bash id="cdgrcc"
/bin
```

### Examples:

```bash id="bm7gvm"
ls
cp
mv
cat
echo
```

---

### 🔥 Why important?

* Available even in **rescue mode**
* Needed before system fully boots

---

# 🔹 3) `/boot` — Boot files

👉 Contains files needed to **start the system**

```bash id="fprbk6"
/boot
```

### Includes:

* Linux kernel (`vmlinuz`)
* bootloader files (GRUB)
* initramfs

---

### 🔥 Think:

```text id="dttng0"
/boot → "how the system starts"
```

---

# 🔹 4) `/dev` — Device files

👉 You already studied this 🔥

```bash id="n8f14r"
/dev
```

### Examples:

```bash id="1ubmrf"
/dev/sda     # disk
/dev/null    # discard
/dev/tty     # terminal
```

---

### 🔥 Purpose

```text id="z9h9hl"
/dev → interface to hardware
```

---

# 🔹 5) `/etc` — Configuration files (VERY IMPORTANT)

👉 Stores system-wide **configuration**

```bash id="nm0uq1"
/etc
```

---

### Examples:

```bash id="63sfmw"
/etc/passwd      # users
/etc/hostname    # system name
/etc/fstab       # disk mounts
/etc/nginx/      # server config
```

---

### 🔥 Important rule

```text id="w28q1v"
/etc → configs, NOT executables
```

---

# 🧠 Real-world connection (VERY IMPORTANT for YOU)

When you deploy apps:

* Config → `/etc`
* Binaries → `/bin` or `/usr/bin`
* Logs → `/var/log` (next lesson)

---

# 🔥 Summary

| Directory | Purpose            |
| --------- | ------------------ |
| `/`       | root of system     |
| `/bin`    | essential commands |
| `/boot`   | boot files         |
| `/dev`    | devices            |
| `/etc`    | configuration      |

---

# 🔥 Mental Model

```text id="sjpk44"
/       → root
├── bin → commands
├── boot → startup
├── dev → hardware
└── etc → config
```

---

# 🔥 Interview Answer

> The Filesystem Hierarchy Standard defines the structure of directories in Linux. The root directory `/` contains all other directories, `/bin` stores essential binaries, `/boot` contains boot files, `/dev` represents devices, and `/etc` holds system configuration files.

---

# 🔥 Important Advice (for you)

Don’t memorize blindly ❌
Understand the **purpose of each folder** ✅

---

If you want next level 🚀

I’ll explain Part 2:
👉 `/usr`, `/var`, `/home`, `/tmp` (VERY important for backend + servers)

Just tell me 👍


