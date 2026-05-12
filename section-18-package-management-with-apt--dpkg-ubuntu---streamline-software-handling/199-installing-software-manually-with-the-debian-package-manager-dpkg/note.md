# 199. Installing Software Manually with `dpkg`

---

# `dpkg`: Debian Package Manager

dpkg is the low-level package manager used in Debian-based systems such as:

* Debian
* Ubuntu

At the lowest level:

```text id="m0rytz"
dpkg is responsible for installing .deb packages
```

Higher-level tools like:

* `apt`
* `apt-get`

eventually rely on `dpkg` underneath.

---

# Debian Packages

Software is distributed as:

```text id="o7t18x"
.deb
```

files.

Example:

```bash id="lvw5p0"
sudo dpkg -i package.deb
```

---

# What is a `.deb` File?

A `.deb` file is NOT just a simple executable.

It is actually:

```text id="p4hmyu"
a compressed archive containing:
- program files
- metadata
- installation scripts
- dependency information
```

Internally, `.deb` uses the:

```text id="k34u4s"
ar archive format
```

similar to how `.zip` or `.tar` archives work.

---

# What Does a `.deb` Package Usually Contain?

Typical contents:

```text id="t7wdcm"
program binaries
configuration files
documentation
dependency metadata
pre/post installation scripts
```

---

# How Do We Get Packages?

Later, package managers like `apt` will download packages automatically.

But currently we are learning manual installation.

So we manually:

1. search
2. download
3. install

the package ourselves.

---

# Ubuntu Package Repository

Ubuntu packages can be found here:

[packages.ubuntu.com](https://packages.ubuntu.com?utm_source=chatgpt.com)

This website allows you to:

* search packages
* browse versions
* select Ubuntu releases
* download `.deb` files manually
* inspect dependencies

---

# Checking Your Ubuntu Version

Before downloading packages, you should know your Ubuntu release.

Command:

```bash id="jqjmk5"
lsb_release -a
```

Example output:

```text id="k4bb6r"
Distributor ID: Ubuntu
Description:    Ubuntu 24.04 LTS
Release:        24.04
Codename:       noble
```

This matters because packages are built for specific distributions and versions.

---

# How to Download a Package Manually

---

## Step 1 — Open Ubuntu Packages Website

Go to:

[Ubuntu Packages Repository](https://packages.ubuntu.com?utm_source=chatgpt.com)

---

## Step 2 — Search for a Package

Example:

```text id="1bcb6l"
htop
```

---

## Step 3 — Choose Distribution Version

Examples:

* jammy
* noble
* focal

Choose the one matching your Ubuntu release.

---

## Step 4 — Download the `.deb` File

You will usually see downloadable mirrors.

Example filename:

```text id="r1m3mw"
htop_3.2.2-2_amd64.deb
```

---

# Installing the Package

Use:

```bash id="77z1nr"
sudo dpkg -i package.deb
```

Example:

```bash id="jlwm5k"
sudo dpkg -i htop_3.2.2-2_amd64.deb
```

---

# Important: `dpkg` Does NOT Resolve Dependencies Automatically

This is extremely important.

If required dependencies are missing:

❌ installation may fail.

Example:

```text id="82v1mb"
dependency problems prevent configuration
```

Unlike `apt`, `dpkg` only installs the package itself.

It does NOT automatically download required dependencies.

---

# Common Recovery Command

After a failed `dpkg` install:

```bash id="kh4s5w"
sudo apt -f install
```

The `-f` means:

```text id="l56r2r"
fix broken dependencies
```

APT then downloads and installs missing packages.

---

# Removing a Package

To uninstall:

```bash id="11w5s7"
sudo dpkg -r package_name
```

Example:

```bash id="9fys0q"
sudo dpkg -r htop
```

---

# Important Difference

Notice:

```bash id="ofimdr"
dpkg -r htop
```

uses:

```text id="hfjlwm"
package name
```

NOT:

```text id="8tp8cw"
the .deb filename
```

---

# Does `dpkg -r` Remove Configuration Files?

Usually:

❌ no

It removes the package but often keeps configuration files.

This is similar to:

```bash id="23vr0p"
apt remove
```

Later we will learn:

```bash id="jlwm69"
apt purge
```

and full cleanup behavior.

---

# What is Inside a `.deb` File?

We can inspect it.

---

# Method 1 — Using `dpkg-deb`

List contents:

```bash id="0h9jlwm"
dpkg-deb -c package.deb
```

Example:

```bash id="qqmq0l"
dpkg-deb -c htop_3.2.2-2_amd64.deb
```

---

# Extract Package Information

```bash id="0c1fcb"
dpkg-deb -I package.deb
```

Shows metadata such as:

* package name
* version
* architecture
* dependencies
* maintainer

---

# Internal Structure of a `.deb`

A `.deb` package usually contains:

```text id="6w0z2m"
debian-binary
control.tar.xz
data.tar.xz
```

---

# `control.tar.xz`

Contains metadata:

```text id="wsg3ym"
dependencies
package info
installation scripts
```

---

# `data.tar.xz`

Contains actual files that will be installed onto the system.

Example:

```text id="2hjlwm"
/usr/bin/
/etc/
/usr/share/
```

---

# Installation Scripts

Some packages include scripts like:

```text id="h5s2hk"
preinst
postinst
prerm
postrm
```

These scripts run automatically during installation/removal.

Example tasks:

* creating users
* enabling services
* updating caches
* configuring software

This is why package installation can do much more than just copying files.

---

# Why Learning `dpkg` Matters

Even though most people use:

```bash id="7ngk7t"
apt install
```

understanding `dpkg` is important because:

* package failures often happen at the `dpkg` layer
* broken package databases involve `dpkg`
* manual package installation uses `dpkg`
* advanced troubleshooting requires `dpkg`

This is foundational Linux administration knowledge.
