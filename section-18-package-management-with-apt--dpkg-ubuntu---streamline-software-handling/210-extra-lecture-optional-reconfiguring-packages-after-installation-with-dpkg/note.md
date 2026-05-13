## 210. Extra lecture (optional): Reconfiguring Packages after Installation with dpkg

When you install a package in Debian/Ubuntu systems, some packages ask configuration questions during installation.

Examples:

* MySQL asks for root password
* `tzdata` asks for timezone
* `keyboard-configuration` asks for keyboard layout
* `postfix` asks for mail server type

These answers are usually stored by the package system.

The command:

```bash
sudo dpkg-reconfigure package-name
```

lets you **rerun the configuration step later** without reinstalling the package.

---

# Basic Syntax

```bash
sudo dpkg-reconfigure <package>
```

Example:

```bash
sudo dpkg-reconfigure tzdata
```

This reopens the timezone selection wizard.

---

# Common Real Examples

## 1. Reconfigure Timezone

```bash
sudo dpkg-reconfigure tzdata
```

You will see:

* geographic area
* city
* timezone selection

Useful when:

* dual boot changed timezone
* wrong timezone after installation
* server moved to another country

---

## 2. Reconfigure Keyboard Layout

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Useful when:

* wrong keyboard language
* special keys not working
* layout mismatch

After changing:

```bash
sudo service keyboard-setup restart
```

or reboot.

---

## 3. Reconfigure Locales

Locales control:

* language
* encoding
* UTF-8 support
* sorting rules

Command:

```bash
sudo dpkg-reconfigure locales
```

You can enable:

* `en_US.UTF-8`
* `ar_PS.UTF-8`
* etc.

Then choose the default locale.

Check current locale:

```bash
locale
```

---

# What Happens Internally?

Debian packages may contain:

* installation scripts
* configuration scripts

Inside package metadata there are scripts like:

```bash
postinst
config
prerm
postrm
```

`dpkg-reconfigure` reruns the package's configuration scripts.

---

# Where Are Answers Stored?

Usually in:

```bash
/var/cache/debconf/
```

Debian uses a system called:

```text
debconf
```

which manages configuration questions and answers.

You can inspect stored answers:

```bash
sudo debconf-show tzdata
```

Example output:

```text
tzdata/Zones/Asia: Jerusalem
tzdata/Areas: Asia
```

---

# Reconfigure Without Interactive UI

Sometimes useful in automation/scripts:

```bash
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure tzdata
```

This avoids interactive menus.

Very common in:

* Dockerfiles
* CI/CD
* servers
* automation

---

# Different Interface Modes

Debconf can display:

* dialog UI
* readline text
* GTK UI
* noninteractive

You can choose:

```bash
sudo dpkg-reconfigure debconf
```

Then select interface style.

---

# Important Difference

## `apt reinstall`

```bash
sudo apt reinstall package
```

* reinstalls files
* may rerun scripts

But:

## `dpkg-reconfigure`

```bash
sudo dpkg-reconfigure package
```

* ONLY reruns configuration phase
* usually faster
* safer

---

# Example Workflow

Suppose PostgreSQL timezone or locale is wrong.

You may do:

```bash
sudo dpkg-reconfigure locales
sudo dpkg-reconfigure tzdata
```

instead of reinstalling PostgreSQL.

---

# Advanced: Low Priority Questions

Some package questions are hidden by default.

You can show all questions:

```bash
sudo dpkg-reconfigure -plow package-name
```

Priority levels:

* critical
* high
* medium
* low

Example:

```bash
sudo dpkg-reconfigure -plow tzdata
```

---

# Useful Inspection Commands

## List package files

```bash
dpkg -L package-name
```

## Show package status

```bash
dpkg -s package-name
```

## Check installed packages

```bash
dpkg -l
```

---

# Very Important Concept

Linux packages are not just files.

A package can contain:

* binaries
* services
* configs
* setup logic
* scripts
* dependency rules

`dpkg-reconfigure` exposes this "setup logic" again after installation.

That is why Debian-based systems are highly automatable and manageable at scale.

---

# Practice Exercises

Try these safely:

```bash
sudo dpkg-reconfigure tzdata
```

```bash
sudo dpkg-reconfigure locales
```

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Inspect answers:

```bash
sudo debconf-show tzdata
```

Explore package metadata:

```bash
dpkg -L tzdata
```

```bash
dpkg -s tzdata
```
