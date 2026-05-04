## 142. Filesystem Hierarchy Standard (Part 2): /home, /lib, /media, /mnt, /opt


Great—this part of FHS is **very practical**, especially for development, servers, and even your future freelancing work 👇

---

# 🔹 1) `/home` — User directories

![Image](https://images.openai.com/static-rsc-4/ajGxNGRUqa30POH9He3QGmJYx7Ba_q1x6KAAgxrBSMyH7DItBfwVoOF57tGcGw5nyW3mQ2T53pl00AvSdV5EUUF0vC1mSYDhkMmw_cof0tw9UQwFlrIHdNXoCV4qa7sa7iinesjY1gR-cstHyhgHRqsfeR5C1sjmLifdiJHea1gv974OTZRaryhE-R5HJ6Je?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/2M2CZAINU6987jkURVjpVfWb170CoNJ_XyEIMpfKrX6uoE86UZS6OnhtncmMKulbQHzvnIGB0PO7ntBmS7iKNIR4OZirSldx-M8Sh66iFqFL7Ta6BTa11jwnMnYS58f5Lp3jmF2dAHA1HEguVhstXGJQ8uOShyTlXjEMFIp36jJHGqTM_BvFGyhydkwQ_liO?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/8FwBtV072murawuJHB2tbn4771Iqh5H9bTUiRdMCfddEOMK11T3iz3ly2JOy1ofmW8M1uZdL9XQh4MU6sFxaXt-SwKweYGyAh1wLyvh7nTa0qSnvPYpIqFajmWdj_yFHtZKKf3DYSTwwVsphFBdwlnoGMn2gZP34LSN-YZu1ogXuNS4x97asPIZA-_38ve8g?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/fPeaU5VKcmR1IrhUwWFGouugTkp7IsNI6jjp9eluRKINa27YSBuNOJVY6iD07cdJ8qX0WGeTv2yBXCjDk8nUbeHvPRAwTyDr9I2m2euzdUpIn1VPAWFW9YsQ25U_s9KRsAK0jqxjz3AE9DmeLSyJ0NwauIG9DpBYxxDfALq5rBgB6uqF-qOlQ0Wkb_1QQjKV?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/y8BvQKIyP0G-0HGTTnaCqvlpGEEMRkvs1velt1imgywl1VBW_62_5BO7V_tAIqub6EJ5f5ci0IbuE6PUQhnnFpg2epb5FhcUPWC4hjiiObOiqRTFUxm17j0e0sfUHFnZQFiHEEVgK7Hq3tZED67AywKwFcbjxN7yMLwpawKkUabvPh29s8qs98RyxZfNOB8c?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ot2-PRFd9TCq0orrPZKHu9CR22aD_JFaYDYrjqqdLf0J2mXej46pSylP-f80GDGcJZi6vafDzrU8545diK4VZ0WKs7OQc03KXA-2Ns3GK__9Jcy3BvE8QpxVYT7qx5ZK9yRj4lKXpf_exEQk_t7-GF_TEP7_hOnZZvVPTsZKBETZ76cSLUHLF6UxCrWESyMx?purpose=fullsize)

👉 Each user has their own folder:

```bash
/home/mohammad
/home/user1
```

---

### 🔥 Contains:

* personal files
* projects
* downloads
* configs (`.bashrc`, `.profile`)

---

### 🧠 For YOU:

👉 Your coding projects live here:

```bash
/home/mohammad/projects/
```

---

# 🔹 2) `/lib` — Essential libraries

👉 Contains **shared libraries** needed by programs

```bash
/lib
```

---

### 🔥 Think:

```text
/bin/ls → needs /lib libraries to run
```

---

### Examples:

```bash
/lib/x86_64-linux-gnu/
```

---

### 🧠 Simple idea:

```text
/lib → "dependencies for system programs"
```

---

# 🔹 3) `/media` — Auto-mounted devices

![Image](https://images.openai.com/static-rsc-4/206qWwxSWUPaubzxFDFnhgUUUFpkB6Dlv83FB4JR4j48liISh1haxHYrc6F71uLRosqd2AHSg3dxFvqLhgGvxlMIVFmT-LK3MSsi2bkpJQGh6R_545zNdQywu92CP7Q5diqJmkwKY0D5KsaDH2q1pXnQ-4oU-fiDfU3UMu7G89lAqUdglTE683-nL_1MQiH-?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/x22XFz-yWcdW8_aebrzMx1qmfAech749ZLkp7fi9Vt8zyeFAsKT3jG52UMUH1O5uQbNS-4ZNTKwB2Ky8K-421lyCHOykdkhThJHvviucm_BL626-hW9SDKZA6I9o0wKJDby8ka-Is5fnh_ZEG2M3DDAEkZOmgrssdKmPfQI_Uy1eVVFio8Amw9eUP5U1E4Ua?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/yhgLJAPiz074kBzXK1dAOFAikDAFpIlb8p73EWIASvx4dLn_u0IAWN4HJgstsUavjpdCzNoFdd4J6gfflee1ojmcM86itCFUzdnuQg2BAmcEybWFFn3t5qcyymMMC5uznPpluG5LbyMATVAb7kwkX56IS4rC-gxx1WVXsNi1MG9Ns8FwPWTM_FmJQAxb7RVt?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/VMbj6oP6HTYnkg3i50l2WzlvqMd64-ZiWciXLe6bL3oLLr_yvwjfxiqNBO9zWxUEf9tICrNrbBunBOjII0b46AHTh3o-G0BYl4Sx5_vj7--b-6oJY3UtMpPP9wZM_G7yY2upKVGXrvAC9uqmGYE8gSv5eEdfnnVNgvcW8fEfr_KzpdQLqkeVKN6JCwTINCE6?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/JngIpGRNGFBdRVC5BzhRJnMmoq612Of8b6T-bF69Ou2NXT_3vFeRK4dPlldy6et586yuojJrKO40LzLGDqO3Sa1U-gmSWqwGzwiv1YQyuxXPXZMYLxfKiFTtAfKUsAeiFjo_98IMkXAQJRaXRZeKKs_X1iSRfDxTQ3AYovxKfnHLOzlPMkh6Rbpjctn-7fQx?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/EbROoo83P6aJzG5xEfma8sLrAe9oF1lkVBNGeCNJcfna4gLJSJfORb7B0wJthm_DJQSZzVEcIUngj5XmpDmKQhEopMUkszdHWHOZ3zrEgQk274nUaOThowGeYI8tl7Oxi_K230mibd3FC3o5641J5cKo2dFg3VfECrg9-4kD0EH9FCRzeC0HEETQCeYkb59N?purpose=fullsize)

👉 Used when you plug:

* USB
* external disk
* CD/DVD

---

### Example:

```bash
/media/mohammad/USB_DRIVE
```

---

### 🔥 Behavior:

* auto-created
* auto-mounted by system

---

# 🔹 4) `/mnt` — Manual mount point

👉 Used for **temporary/manual mounting**

```bash
/mnt
```

---

### Example:

```bash
sudo mount /dev/sda1 /mnt
```

---

### 🔥 Difference from `/media`:

| `/media`  | `/mnt`     |
| --------- | ---------- |
| automatic | manual     |
| for users | for admins |

---

### 🧠 Use case:

* testing disks
* mounting partitions
* debugging

---

# 🔹 5) `/opt` — Optional software

👉 For **third-party applications**

```bash
/opt
```

---

### Examples:

```bash
/opt/google/
/opt/intellij/
/opt/myapp/
```

---

### 🔥 Used when:

* software not from package manager
* custom installs

---

### 🧠 For YOU:

👉 If you build your own app:

```bash
/opt/my-backend-app/
```

---

# 🔥 Real System Structure (Important)

```text
/
├── home   → users
├── lib    → system libraries
├── media  → USB devices
├── mnt    → manual mounts
└── opt    → optional software
```

---

# 🔥 Real-World Understanding (VERY IMPORTANT)

### Example: You deploy a backend app

| Type      | Location         |
| --------- | ---------------- |
| app files | `/opt/myapp`     |
| config    | `/etc/myapp`     |
| logs      | `/var/log/myapp` |
| user data | `/home/user`     |

---

# 🔥 Summary

| Directory | Purpose              |
| --------- | -------------------- |
| `/home`   | user files           |
| `/lib`    | system libraries     |
| `/media`  | auto-mounted devices |
| `/mnt`    | manual mounts        |
| `/opt`    | third-party apps     |

---

# 🔥 Interview Answer

> In the FHS, `/home` contains user directories, `/lib` holds essential shared libraries, `/media` is used for automatically mounted removable devices, `/mnt` is for temporary manual mounts, and `/opt` stores optional third-party software.

---

# 🔥 Important Advice (for you)

Start thinking like this:

👉 “Where should I put my app in production?”

Correct answer:

```text
/opt → app
/etc → config
/var → logs
```

---

If you want next level 🚀

I’ll explain Part 3:
👉 `/usr`, `/var`, `/tmp`, `/srv` (VERY important for backend + servers)

Just tell me 👍
