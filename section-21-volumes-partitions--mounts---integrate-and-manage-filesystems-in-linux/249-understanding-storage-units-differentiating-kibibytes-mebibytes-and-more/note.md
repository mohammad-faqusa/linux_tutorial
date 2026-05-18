# 249. Understanding Storage Units: Differentiating Kibibytes, Mebibytes and More

![Image](https://images.openai.com/static-rsc-4/c9EQCfkySO6P0DCdMNfZ9Jd4NzjiamVQ2T3HlhO_9XuPbSJJ2lZBQzSbtoWgkpABueKfr4A7r0PZEl_2JmYiB_mQeo2g08i-Dl4UkJ8dzNjM7MNNU6VRsvaJzGJgcN8FlcwZzkrhxnPUCLIYJ3-7i-kH1r--wJBkppqINlnJH9IZhKQnM8e7MMfMZltDLtlA?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/oEKT5EUsGv8RRqKEneTUzIqeszkT9cYIu6pMYSVB8NKzbb4KmOaw_wsVKOPx0qGFiN-nZbDsqYIBcNPE-cABh_Mz8EDUPn0nnwQhBWdzBdDD8hxG0sOs07OcSrnUlY93v9NXZhEPqFXIgpU_3Ohc1dr-YVH-O70BXDZuvpnmdkuppW2OxLZjHdnbQO9Md1pw?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/4WskHvmCKa-K7QTqfqwvHdGa_0-3CYiClU0YK2Wbl75MfFpXpC5zvhWiEbfRyZul15qdcG7sSTt4dG-93_50EURorDjJ5sYZPmk9lvitpAa9gcPqANkQMuVgwAdKxQtl6sFi1DXkdzfBT1je4ptPNTHc5gqnoc04zRINsvp0Q5ktqoUXdg0bNEl6Sa90s1Q5?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/cglgSu_6FIPVhdjtIojo_S5LRc1RzKXThavSAGy-BYZP_gEFXCiNNgsza1TRISdelG1I_pP4FhRW1e2w22rs9ELT62PQ5v5JVBzoCfWYyaIgHiJbv3y8--cq0taon5TlwquX1St9oLW6-jriJ_o6T6MrwuS0o6zkkFBicahpmH_zZiGfaKt2GiueQilroUbf?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/A0u4qQ8pBNLo91x4X7a0jcI6WMwFLpXys47RieTbMoR2uQia4mgVEAEGexUyaXKivQcJL3iusBXBx6kBB8q97f9IZ_2dhMiUaD2eqE40p8ykIOILh6HZ7EBY99Fm75w1VVZDUp-XdZmBsoEl1MqVfMYn2sq8y3-uNyzmlXRdVlRPIjuLyvEv0UTiQyL1QRJp?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/WGQmkJP7f3k5gA8Kakk9O8uN-ldbt8KJ2tfcbY1ZhQYEdy-c6Xrps8PDn-xJwIPD-mRTtkY9cab0FuxcICV7lFyF4H_SksWlQSKGBkdr6wOkp01LY7PihOxp1-lbwgEgmn-rh20jAXNbUndHb1cL2bv_p0sN3VGD810GvzjEzvzBkwr_ujcyndY4UUt2OcPl?purpose=fullsize)

## why does `50,000MiB` appear as about `48GB`?

because:

* `MiB` and `GB` are NOT the same units
* they use different base systems

---

# binary vs decimal units

## binary units

used heavily in:

* operating systems
* Linux tools
* RAM calculations
* low-level computing

based on:

```text id="unit001"
1024 = 2^10
```

---

## decimal units

used heavily in:

* hard drive marketing
* SSD manufacturers
* USB storage labels

based on:

```text id="unit002"
1000 = 10^3
```

---

# basic byte relationships

## bit vs byte

```text id="unit003"
8 bits = 1 byte
```

---

# binary units (IEC standard)

## kibibyte

```text id="unit004"
1 KiB = 1024 bytes
```

---

## mebibyte

```text id="unit005"
1 MiB = 1024 KiB
       = 1024^2 bytes
```

---

## gibibyte

```text id="unit006"
1 GiB = 1024 MiB
       = 1024^3 bytes
```

---

# decimal units (SI standard)

## kilobyte

```text id="unit007"
1 KB = 1000 bytes
```

---

## megabyte

```text id="unit008"
1 MB = 1000^2 bytes
```

---

## gigabyte

```text id="unit009"
1 GB = 1000^3 bytes
```

---

# comparison table

| Binary              | Decimal            | Difference |
| ------------------- | ------------------ | ---------- |
| 1 KiB = 1024 bytes  | 1 KB = 1000 bytes  | 2.4%       |
| 1 MiB = 1024² bytes | 1 MB = 1000² bytes | 4.9%       |
| 1 GiB = 1024³ bytes | 1 GB = 1000³ bytes | 7.4%       |
| 1 TiB = 1024⁴ bytes | 1 TB = 1000⁴ bytes | 10%        |

difference increases as sizes grow.

---

# example: why 50,000MiB becomes about 48GB

## convert MiB to bytes

50000\times1024^2\ \text{bytes}

---

## convert to decimal GB

\frac{50000\times1024^2}{1000^3}\approx52.4\ GB

---

## convert to binary GiB

\frac{50000}{1024}\approx48.8\ GiB

---

so:

```text id="unit010"
50,000 MiB ≈ 48.8 GiB
```

many tools may display:

```text id="unit011"
48G
```

which often actually means:

```text id="unit012"
48 GiB
```

---

# why this becomes confusing

historically:

* terminology was inconsistent

---

# JEDEC standard confusion

older JEDEC standards used:

```text id="unit013"
1 MB = 1024^2 bytes
1 GB = 1024^3 bytes
```

which mathematically matches:

```text id="unit014"
MiB
GiB
```

NOT:

```text id="unit015"
MB
GB
```

according to modern SI standards.

---

# where JEDEC-style notation is still used

## Windows

Windows often displays:

```text id="unit016"
GB
```

while actually calculating:

```text id="unit017"
GiB
```

example:

* 512GB SSD may appear around:

```text id="unit018"
476 GB
```

inside Windows

but internally:

* Windows is actually showing:

```text id="unit019"
476 GiB
```

---

## RAM

RAM uses binary sizing:

```text id="unit020"
8GB RAM = 8 × 1024^3 bytes
```

not decimal

---

## CPU cache

cache sizes:

* KB
* MB

usually binary interpretation

---

## older macOS versions

older macOS versions also used binary interpretation.

modern macOS now mostly uses:

```text id="unit021"
decimal SI units
```

like storage manufacturers.

---

# Linux behavior

Linux tools vary.

## binary-oriented tools

examples:

```bash id="unit022"
free -h
lsblk
df -h
```

often display:

```text id="unit023"
KiB MiB GiB
```

sometimes shortened as:

```text id="unit024"
K M G
```

while still meaning binary units.

---

## explicit IEC display

```bash id="unit025"
lsblk --bytes
```

or:

```bash id="unit026"
df -H
```

vs:

```bash id="unit027"
df -h
```

difference:

* `-h`

  * binary units
* `-H`

  * decimal units

---

# example with df

binary:

```bash id="unit028"
df -h
```

decimal:

```bash id="unit029"
df -H
```

---

# storage manufacturer trick

SSD labeled:

```text id="unit030"
500 GB
```

means:

```text id="unit031"
500 × 1000^3 bytes
```

OS may display:

```text id="unit032"
~465 GiB
```

users think:

```text id="unit033"
space is missing
```

but actually:

* units differ

---

# important practical idea

## storage devices

usually marketed using:

```text id="unit034"
decimal units
```

---

## operating systems

often display:

```text id="unit035"
binary units
```

---

# useful commands

show block device sizes:

```bash id="unit036"
lsblk
```

exact bytes:

```bash id="unit037"
lsblk --bytes
```

filesystem usage:

```bash id="unit038"
df -h
```

decimal display:

```bash id="unit039"
df -H
```

RAM:

```bash id="unit040"
free -h
```

---

# important takeaway

## binary units

```text id="unit041"
KiB MiB GiB TiB
```

base:

```text id="unit042"
1024
```

---

## decimal units

```text id="unit043"
KB MB GB TB
```

base:

```text id="unit044"
1000
```

---

# why this matters in Linux

important for:

* partition sizing
* filesystem planning
* disk calculations
* cloud storage
* RAM interpretation
* Docker/Kubernetes storage limits
* backup planning
