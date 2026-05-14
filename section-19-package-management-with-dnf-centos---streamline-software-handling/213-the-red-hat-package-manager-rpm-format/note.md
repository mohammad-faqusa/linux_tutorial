# 213. The Red Hat Package Manager (RPM) Format

## The `.rpm` Package Format

In Red Hat-based distributions such as:

* Fedora
* CentOS Stream
* Red Hat Enterprise Linux

software is distributed using the:

```text id="l4eb09"
.rpm
```

package format.

RPM stands for:

```text id="38hz7f"
Red Hat Package Manager
```

---

# What is an RPM Package?

An `.rpm` file is essentially:

* a software archive
* containing files required for installation
* plus metadata and configuration information

An RPM package may contain:

* binaries
* libraries
* configuration files
* documentation
* installation scripts

---

# RPM Without a Package Manager

The `rpm` command itself is a **low-level package management tool**.

It can:

* install packages
* remove packages
* inspect packages

BUT:

* it does not automatically resolve dependencies like `dnf`

This is a very important distinction.

---

# Manually Downloading RPM Packages

You can manually download `.rpm` files from repositories such as:

[CentOS Mirror Repository](https://mirror.stream.centos.org?utm_source=chatgpt.com)

Example RPM filename:

```text id="y4l01f"
nginx-1.26.0-1.el9.x86_64.rpm
```

---

# Inspecting an RPM Package

You can inspect package contents without installing it.

## List files inside an RPM

```bash id="04js1n"
rpm -qpl package.rpm
```

Example:

```bash id="xvcuvd"
rpm -qpl nginx.rpm
```

Meaning:

* `-q` → query
* `-p` → package file
* `-l` → list files

---

# Installing RPM Packages Manually

## Install a package

```bash id="jlwmtn"
sudo rpm -i filename.rpm
```

Example:

```bash id="q2cxwy"
sudo rpm -i nginx.rpm
```

Meaning:

* `-i` → install

---

# Removing a Package

```bash id="t2n9zd"
sudo rpm -e programname
```

Example:

```bash id="3f7wqt"
sudo rpm -e nginx
```

Meaning:

* `-e` → erase

---

# Important Problem with RPM

The `rpm` command alone:

* does NOT automatically download dependencies
* does NOT resolve dependency chains

Example:

```text id="od36zy"
package A requires library B
```

If library B is missing:

* installation may fail

This is why manually installing RPMs can become difficult.

---

# Why `dnf` is Recommended

In practice, we usually do NOT install packages directly with `rpm`.

Instead, we prefer:

```bash id="h2bz1z"
dnf
```

because `dnf`:

* resolves dependencies automatically
* downloads required packages
* manages repositories
* handles updates safely

Example:

```bash id="yz9h44"
sudo dnf install nginx
```

This is much safer and easier than:

```bash id="y7q6k0"
sudo rpm -i nginx.rpm
```

---

# Relationship Between RPM and DNF

Think of it like this:

| Tool  | Role                       |
| ----- | -------------------------- |
| `rpm` | Low-level package tool     |
| `dnf` | High-level package manager |

`dnf` internally uses RPM underneath.

---

# Useful RPM Commands

## Show installed RPM packages

```bash id="i2d7cd"
rpm -qa
```

Meaning:

* `-a` → all installed packages

---

## Query installed package info

```bash id="jlnw2w"
rpm -qi nginx
```

Meaning:

* `-i` → information

---

## Check which package owns a file

```bash id="n3j42h"
rpm -qf /usr/bin/ls
```

Meaning:

* `-f` → file owner query

---

## Verify installed package

```bash id="m98yvw"
rpm -V nginx
```

Used to detect:

* modified files
* missing files
* corrupted package contents

---

# Summary

## RPM

* low-level package format and tool
* works directly with `.rpm` files
* does not resolve dependencies automatically

## DNF

* higher-level package manager
* uses RPM underneath
* handles dependencies and repositories automatically

In real-world administration:

* use `dnf` most of the time
* use `rpm` mainly for inspection, querying, or advanced manual operations
