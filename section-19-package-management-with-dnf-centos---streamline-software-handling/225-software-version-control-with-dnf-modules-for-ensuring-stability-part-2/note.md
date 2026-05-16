## 225. Software Version Control with DNF Modules for Ensuring Stability (Part 2)

### DNF : module installation

* after enabling a stream:

  * we can install module packages

---

## install a module

```bash id="t6p2k8"
dnf module install [name]
```

example:

```bash id="4z6f9m"
sudo dnf module install nodejs
```

* installs:

  * the default stream
  * and default profile

---

## install a specific stream/profile

```bash id="2w7xqp"
dnf module install [name]:[stream]/[profile]
```

example:

```bash id="9nv4rq"
sudo dnf module install nodejs:18/development
```

meaning:

* install:

  * nodejs stream 18
  * using profile `development`

---

## alternative syntax

```bash id="0n3x1f"
dnf install @[name]:[stream]/[profile]
```

example:

```bash id="6h5n0a"
sudo dnf install @nodejs:18/development
```

* equivalent to:

```bash id="8f9w1v"
sudo dnf module install nodejs:18/development
```

---

# what is a profile ?

* a profile is:

  * a predefined package set inside a module

example:

```text id="5x1m4k"
nodejs:
  common
  development
  minimal
```

---

## example profiles

### minimal

* installs:

  * only essential runtime packages

---

### development

* installs:

  * runtime
  * npm
  * development tools
  * headers
  * build dependencies

---

## show available profiles

```bash id="2s6r8u"
dnf module info nodejs
```

or

```bash id="7p3d0y"
dnf module info nodejs:18
```

---

# removing module packages

## remove a specific profile

```bash id="1f0w9z"
sudo dnf module remove [name]:[stream]/[profile]
```

example:

```bash id="4j7n2q"
sudo dnf module remove nodejs:18/development
```

meaning:

* removes:

  * packages installed by that profile

---

## remove all module packages

```bash id="5u2m8b"
sudo dnf module remove --all [name]
```

example:

```bash id="7x3r1n"
sudo dnf module remove --all nodejs
```

meaning:

* uninstall ALL packages installed from:

  * nodejs module

---

# disabling a module

```bash id="3b8q0f"
sudo dnf module disable [name]
```

example:

```bash id="9v1y5t"
sudo dnf module disable nodejs
```

meaning:

* prevents packages from this module from being installed

---

## why disable a module ?

* useful when:

  * we want packages from another repository
  * we want custom versions
  * module packages conflict with third-party repos

---

# resetting a module

```bash id="4d7k2s"
sudo dnf module reset [name]
```

example:

```bash id="8n6r3w"
sudo dnf module reset nodejs
```

---

## what does reset do ?

* removes:

  * enabled stream selection

* returns module state to:

  * default

---

## important

### reset does NOT:

* uninstall packages

### reset DOES:

* forget:

  * enabled stream
  * selected profile state

---

# common workflow example

## enable stream

```bash id="1u8m6p"
sudo dnf module enable nodejs:20
```

---

## install development profile

```bash id="5k2z9x"
sudo dnf module install nodejs:20/development
```

---

## later remove packages

```bash id="3x7c1v"
sudo dnf module remove --all nodejs
```

---

## reset module state

```bash id="7j4b8q"
sudo dnf module reset nodejs
```
