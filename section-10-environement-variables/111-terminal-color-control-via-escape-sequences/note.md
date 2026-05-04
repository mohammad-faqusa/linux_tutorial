## 111. Terminal Color Control via Escape Sequences

## 🔹 Terminal Color Control via Escape Sequences (ANSI)

![Image](https://images.openai.com/static-rsc-4/LvU0yg3mIKJu1eZFj-gwruMcKOXc1ehZI1X2xOj2zo15f_fBHngd21kM_sRMfGJYJj3PcszSLJMTd9hS1xkwBGKTgCdvZUpeYL7i4m_r7F8WQqb0FlJ-f0AKJc3DF0GPVzc-PSx5_AmkL1v6_1Q3VPoWHKlIaN7rzvB1gaO5HVp3EVD_unpjOIUlDBDgS2W9?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/RIGLuJzQHfoGiPTJvqn5LGYWoJReXXDKPTgxKaKsVqgv12RhiAkm9a5yscYnaD9bWzoH7NYCUk4Iku7wQFLSogNf9fJ_iM8AdSNWr-sq0EiTy-gyYi8RMb1Aly8ZXlqobz1vvqHMnDu1uBkZ28bCLGuGr2D9hX76KDu_mX5NBQvEpkaIhWo0cz-9gvnSAMBI?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/WChG50gjkH92_kb8MfrNZui5Gq-tIxZObJJsxqFzrUle9eMCsKoH7F0reouVRhX7_ZngEinvs9IIo-m0gpgzrHNiAjTXN2R7v-AVPjRl2MbcLl0LUYoaQo4AxPLlXVvIT1vY_Xhbpf2UxntMy_bpuo6ch_UC5Zw357J5EvxDIW-pTcnP5KuxKCWgqBcd_mLt?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/H0TTxYeV12obzQU3kfj42lGOIclyFUCZpJJmact96gajL9r1Axf1A8qoOmpAzM5mN2G2C7KyUAHyMZkZnKTM_CD6M-zJ9veX_IUG2d6mxqWljLk_UDxIltWZzWxtgyvc4xY957foKUWLCmqbSkBZK3h-6veGxk-6T0kSFizRIsOMODYuaUyhOCwyDRp6lBRb?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/aYj7fJnoah_FxlcIlgErjElPlUnmuXeRRkUyaJbtmBPLtHcNetVCGx4R5nG-HyLc4Z6Y9xviipZWMEI1HCgSNyoQA7YA0Am-KgECtUyg4r5ISUbq_30iKBIEWt4RhPeRyOhQLeemxhTdMOXoaYpUDoTxyfSex3D39qsvkAmleVWlEZBBvrRoVgCBzaMlO4v0?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/rLukypkryiS2MYHZt3FgxzlPpCh51NYfVTCaj8oKyaZyTAEesbiQkLwHD0dEzYIs5c5Hj-wa4zpOlq2rTUc1goSZe4SroVCaAmq4SGM-xnSpjKlDkgRWkBCoavXMS_ehMxffLzN0C7rKE8sacXmQ0KX-V_lMWgyhppDuIHrPSIFfiIJ29V_PxqiS0Nd2RgdH?purpose=fullsize)

> You can control text **color, style, and formatting** in the terminal using **ANSI escape sequences**.

---

# 🔹 1) Basic Structure

```text
\e[<codes>m
```

* `\e` → escape character
* `[` → start sequence
* `m` → apply formatting

---

## 🔸 Example

```bash id="8vmdul"
echo -e "\e[31mHello\e[0m"
```

👉 Red text, then reset

---

# 🔹 2) Foreground Colors

| Code | Color   |
| ---- | ------- |
| 30   | Black   |
| 31   | Red     |
| 32   | Green   |
| 33   | Yellow  |
| 34   | Blue    |
| 35   | Magenta |
| 36   | Cyan    |
| 37   | White   |

---

## 🔸 Example

```bash id="6otyoz"
echo -e "\e[36mCyan Text\e[0m"
```

---

# 🔹 3) Background Colors

👉 Add **10**

| Code | Color   |
| ---- | ------- |
| 40   | Black   |
| 41   | Red     |
| 42   | Green   |
| 43   | Yellow  |
| 44   | Blue    |
| 45   | Magenta |
| 46   | Cyan    |
| 47   | White   |

---

## 🔸 Example

```bash id="dc1y03"
echo -e "\e[30;47mBlack on White\e[0m"
```

---

# 🔹 4) Combine foreground + background

```bash id="v9plmv"
echo -e "\e[32;44mGreen text on blue background\e[0m"
```

👉 Use `;` between codes

---

# 🔹 5) Text Styles

| Code | Effect                   |
| ---- | ------------------------ |
| 0    | Reset                    |
| 1    | Bold                     |
| 4    | Underline                |
| 7    | Reverse                  |
| 5    | Blink (rarely supported) |

---

## 🔸 Example

```bash id="hqeq3q"
echo -e "\e[1;31mBold Red\e[0m"
```

---

# 🔹 6) Reset (VERY IMPORTANT)

```bash
\e[0m
```

👉 Always reset or your terminal stays colored

---

# 🔹 7) 256 Colors (Advanced 🎨)

```bash id="h77yo3"
echo -e "\e[38;5;196mBright Red\e[0m"
```

* `38;5;<n>` → foreground
* `48;5;<n>` → background

---

# 🔹 8) True Color (24-bit RGB)

```bash id="dxpgbi"
echo -e "\e[38;2;255;100;0mCustom Orange\e[0m"
```

👉 Full RGB control

---

# 🔹 9) Real-world uses (VERY IMPORTANT 💡)

## 🔸 Logs

```bash id="cghz55"
echo -e "\e[31mERROR\e[0m Something failed"
```

---

## 🔸 Scripts

```bash id="7yj4mz"
echo -e "\e[32mSUCCESS\e[0m Operation completed"
```

---

## 🔸 Prompts (`PS1`)

```bash id="b5x0dr"
PS1="\[\e[32m\]\u@\h\[\e[0m\]:\w\$ "
```

---

# 🔹 10) Common mistakes ⚠️

* ❌ Using `:` instead of `;`
* ❌ Forgetting `-e` in `echo`
* ❌ Not resetting colors
* ❌ Not wrapping colors in `\[` `\]` inside `PS1`

---

# 🔹 Mental Model

```text
text → apply escape sequence → colored output → reset
```

---

# 🔹 Summary

| Feature    | Syntax      |
| ---------- | ----------- |
| Foreground | `\e[31m`    |
| Background | `\e[41m`    |
| Style      | `\e[1m`     |
| Reset      | `\e[0m`     |
| Combine    | `\e[31;47m` |

---

# 🔥 Pro Insight (for you)

You’ll use this in:

* CLI tools
* Bash scripts
* Logging systems
* DevOps dashboards

👉 Makes your tools **professional + readable**

---

## 🚀 Next Step

I can help you:

* Build a **beautiful PS1 prompt (Git + colors + status)**
* Create a **logging system with colored output**

Just tell me 👍


