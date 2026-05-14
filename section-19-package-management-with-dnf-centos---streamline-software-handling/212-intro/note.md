# 212. Introduction to Package Management in Red Hat-Based Distributions (`dnf`)

## Definition

Package management is the process of:

* installing software
* updating software
* removing software
* resolving dependencies
* managing repositories

using a package manager.

In Red Hat-based systems, the modern package manager is:

```bash id="shgbb9"
dnf
```

`dnf` stands for:

```text id="gxqks9"
Dandified YUM
```

It replaced the older `yum` package manager.

---

# Purpose of Package Management

Package managers help automate software management.

Instead of:

* downloading source code manually
* compiling programs
* searching for dependencies yourself

the package manager handles everything automatically.

Example:

```bash id="ff67rn"
sudo dnf install nginx
```

The package manager:

* downloads the package
* installs dependencies
* configures package metadata
* integrates the software into the system

---

# Why Do We Need Package Managers?

Without package managers:

* software installation becomes difficult
* dependency management becomes messy
* updates become dangerous
* system maintenance becomes harder

Package managers provide:

* consistency
* automation
* security
* dependency resolution
* centralized software distribution

---

# Important Note

Package management differs between Linux distributions.

Examples:

| Distribution Family | Package Manager |
| ------------------- | --------------- |
| Ubuntu / Debian     | `apt`           |
| Fedora              | `dnf`           |
| Arch Linux          | `pacman`        |
| openSUSE            | `zypper`        |

So commands are not universal across all Linux systems.

---

# Why Study `dnf`?

We will focus on package management in:

* CentOS Stream
* Red Hat Enterprise Linux

because these systems are heavily used in:

* enterprise environments
* servers
* cloud infrastructure
* DevOps and SRE roles

---

# Red Hat Ecosystem Flow

Simplified package flow:

```text id="5ntgmu"
Fedora → CentOS Stream → RHEL
```

---

# Fedora

Fedora is:

* fast-moving
* cutting-edge
* receives newer software first

Used for:

* testing newer technologies
* desktop and development environments

---

# CentOS Stream

CentOS Stream is:

* a rolling preview of RHEL
* sits between Fedora and RHEL

Meaning:

* features arrive after Fedora
* before becoming part of RHEL

This makes CentOS Stream:

* more stable than Fedora
* less conservative than RHEL

---

# RHEL

Red Hat Enterprise Linux is:

* enterprise-focused
* highly stable
* commercially supported

Commonly used in:

* banks
* enterprises
* production servers
* cloud systems

---

# Why CentOS Stream Matters

Because CentOS Stream closely follows RHEL:

* package management behavior is very similar
* repository structure is similar
* administrative workflows are similar

So learning `dnf` on CentOS Stream prepares you well for:

* RHEL administration
* enterprise Linux environments
* server management jobs

---

# Basic `dnf` Examples

## Install a package

```bash id="z4r65y"
sudo dnf install nginx
```

---

## Update packages

```bash id="jlwmv4"
sudo dnf update
```

---

## Remove a package

```bash id="u9m16c"
sudo dnf remove nginx
```

---

## Search for packages

```bash id="a8du91"
dnf search docker
```

---

## Show package information

```bash id="gw87ep"
dnf info nginx
```

---

# Important Difference from APT

APT uses:

```bash id="0xqv9o"
.deb
```

packages.

DNF uses:

```bash id="b8zt3q"
.rpm
```

packages.

RPM stands for:

```text id="pk4rpn"
Red Hat Package Manager
```

`rpm` is the low-level package system, while `dnf` is the higher-level dependency manager built on top of it.
