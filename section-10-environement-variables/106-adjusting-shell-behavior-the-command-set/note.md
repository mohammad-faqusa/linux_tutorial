## 106. Adjusting Shell Behavior: the Command `set`

## 🔹 Adjusting Shell Behavior with `set`

![Image](https://images.openai.com/static-rsc-4/s3jyL00gGWmHySDj99LcqdjxUPHlzVgnx56bZP_msO5Chv2q29QESI77wSYLCfzO1CODoSm05-Es9eFWmmEQVH09fzy6cDBjnm41HqrEqVPS9KDVgeuB9VJ8b-zSv6gjHz_GrFlMKP4Jfb6TIWfG-V87ABsrdxFLSOpB1eJRiug-Gy55gujfCFw2ZFYbPixF?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/veDoC2WBk4dUO5lP_TOIlGsaIllQxtQrTgrnCZ8JwrVs2p6GMbNUr_3fWq43sXmCSFW0lGWkpi-nTrmSaH44xjxdhGDhBuH8NNGzo6FKGySvDCXl0g7yNTH5kylC6E06RWx8RU2sTO0p_3_jo3wM02BktGp8ycIIBdltSSSQAtNbOaHf5CFqkDzgXMEGWnna?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/KgyDxrQSxAe3wyByo7n1Q2_rp5jEmMNGyATJrQlvVtOUuvdAEy5tXD6WTaKrYBMN8i1d-8n5ZrGmFsdmDHTs4W8eJch7E_YufJ-yw1K9S14YmAmeV_Loeayc0rvo4_6MtxwQdRCOcsA4AMMNsoGKFmZN0-sRvhEKdgCJTXx0QcTVVKEO9DLSEu5Kd8njmtdO?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/cy2lwGHITkYdsWsSsf3_cKSZM2EvglzbKbUgG1qlfSN9FpGP1RMWl-1cLVbq3esLNrJpEziD6BVDR5bQNjNfL0s1J7b-wgnQoOtBikyWxv6WgmRbagCvY2_vziTJakExoNQoBhA-g1ch-QyAsHaU1A8pbokvMBPF9HNtaYcPl9UwOmivz4miFRY-k_mNUZbg?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/ll_gxXsgm5JZvHYD-bJ0iz5CRpayPpQU1fqdWsdpu8X2etG9ZvMQlgA3QDOGCviTNfZmcP8UrCAxj__uiyGWRMGgv-oOITgrHUnua6bXljLV8PYVus3yC91d5Nfv8lDj2t8G25GVx95cPKdVLo4UA5v8iHZCMR8UDFTLaTngQBtc1JxEEoHa5Rnv_zPMFZjq?purpose=fullsize)

> The `set` command **controls how your shell behaves**—especially useful in scripts for safety and debugging.

---

# 🔹 1) Basic idea

```bash
set [options]
```

👉 It turns **features ON or OFF** inside the current shell

---

# 🔹 2) Show all variables & functions

```bash
set
```

👉 Prints:

* shell variables
* functions
* environment variables

---

# 🔹 3) Most IMPORTANT options (you must know)

---

## 🔸 `set -e` → Exit on error

```bash
set -e
```

👉 If any command fails → script stops immediately

### Example

```bash
set -e
mkdir test
cd test
rm not_exist_file   # ❌ script stops here
echo "This won't run"
```

---

## 🔸 `set -u` → Error on undefined variable

```bash
set -u
```

👉 Using a variable that is not defined = error

```bash
echo $MY_VAR   # ❌ error if not set
```

---

## 🔸 `set -x` → Debug mode

```bash
set -x
```

👉 Prints every command before execution

### Example

```bash
set -x
echo "Hello"
```

👉 Output:

```text
+ echo Hello
Hello
```

---

## 🔸 `set +x` → Turn OFF debug

```bash
set +x
```

---

## 🔸 `set -o pipefail` → Fix pipeline errors (VERY IMPORTANT 🔥)

```bash
set -o pipefail
```

👉 Normally:

```bash
false | true
```

👉 returns success ❌

👉 With pipefail:

* If ANY command fails → whole pipeline fails

---

# 🔹 4) Combine them (BEST PRACTICE 🔥)

```bash
set -euo pipefail
```

👉 This means:

* `-e` → stop on error
* `-u` → no undefined variables
* `-o pipefail` → pipeline safety

---

# 🔹 5) Example real script

```bash
#!/bin/bash

set -euo pipefail

echo "Starting script..."

echo "User: $USER"

mkdir mydir
cd mydir

echo "Done"
```

---

# 🔹 6) Check current options

```bash
set -o
```

👉 Shows ON/OFF status

---

# 🔹 7) Turn OFF options

```bash
set +e
set +u
```

---

# 🔹 Mental Model

```text
set → changes how shell reacts to errors, variables, debugging
```

---

# 🔥 Pro Insight (VERY IMPORTANT for you 💡)

In real backend / DevOps work:

👉 Always start scripts with:

```bash
set -euo pipefail
```

Because it:

* prevents silent bugs
* avoids hidden failures
* makes debugging easier

---

# 🔹 Common mistakes ⚠️

* ❌ Not using `set -e` → script continues with errors
* ❌ No `pipefail` → pipelines hide failures
* ❌ No `-u` → undefined variables cause silent bugs

---

# 🔹 Summary

| Option        | Meaning                     |
| ------------- | --------------------------- |
| `-e`          | exit on error               |
| `-u`          | error on undefined variable |
| `-x`          | debug (print commands)      |
| `-o pipefail` | pipeline safety             |

---

## 🚀 Where you are now

You now understand:

* shell behavior
* env variables
* startup files
* execution control

👉 This is **solid intermediate Linux knowledge**

---

## 👉 Next Step

I can show you:

* Writing production-ready bash scripts
* Argument parsing (`$1`, `$@`)
* Real DevOps automation examples 🔥

Just tell me 👍
