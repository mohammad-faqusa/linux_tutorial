## 224. Software Version Control with DNF Modules for Ensuring Stability (Part 1)

### why do we need modules

* software should work reliably and consistently
* sometimes:

  * we want security updates
  * but we do NOT want major version upgrades

example:

* an application may only support:

  * `postgresql 15`
* upgrading automatically to:

  * `postgresql 16`
* may break:

  * compatibility
  * extensions
  * applications

---

### what are DNF modules ?

* a DNF module is:

  * a grouped collection of packages

* it usually represents:

  * an application
  * programming language
  * runtime
  * database
  * toolchain

examples:

* nodejs
* postgresql
* php
* nginx
* ruby

---

## important concept : streams

* each module may contain multiple versions called:

  * streams

example:

```text id="n6v1w2"
nodejs:
  18
  20
  22
```

* each stream represents a different major version

---

## why are streams useful ?

* they allow us to:

  * choose a stable version
  * avoid unwanted upgrades
  * keep compatibility with applications

---

## list available modules

```bash id="3u0q4f"
dnf module list
```

---

## example output

```text id="9gc7r2"
Name        Stream      Profiles
nodejs      18          common [d]
nodejs      20
postgresql  15
postgresql  16
```

---

## meaning of symbols

### `[d]`

* means:

  * default stream

example:

```text id="4c5b7p"
nodejs 18 common [d]
```

means:

* stream `18` is the default version

---

## enable a module stream

```bash id="6v4mt7"
sudo dnf module enable [name]:[stream]
```

example:

```bash id="z5f8qw"
sudo dnf module enable nodejs:20
```

meaning:

* use Node.js version 20 packages

---

## after enabling

* install packages normally:

```bash id="m9cxq1"
sudo dnf install nodejs
```

* DNF now installs:

  * packages from stream 20

---

## important note

* only one stream can usually be enabled at a time

example:

* cannot simultaneously enable:

  * `nodejs:18`
  * and `nodejs:20`

---

## why this matters in servers

example:

* enterprise app tested only on:

  * PHP 8.1

without modules:

* system updates might upgrade PHP unexpectedly

with modules:

* we lock the system to:

  * PHP 8.1 stream

this improves:

* stability
* predictability
* compatibility
