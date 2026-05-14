# 216. What are Software Dependencies?

## What are Software Dependencies?

Software dependencies are:

> resources required for a program to function properly.

Dependencies may include:

* libraries
* shared binaries
* runtime environments
* other software packages
* operating system features

---

# Example

Suppose you install:

```bash id="w8mq3w"
sudo dnf install firefox
```

Firefox itself depends on many other components such as:

* graphics libraries
* audio libraries
* networking libraries
* security libraries

Without these dependencies:

* the application may fail to start
* some features may not work

---

# Dependency Resolution

One of the biggest responsibilities of:

```bash id="9y5rmw"
dnf
```

is:

* automatic dependency resolution

Example:

```bash id="jlwmtn"
sudo dnf install nginx
```

DNF will:

1. detect required dependencies
2. download them automatically
3. install everything in the correct order

---

# Recursive Dependency Resolution

Dependencies themselves may also depend on other packages.

This happens recursively.

Example:

```text id="4d7mja"
Application A
  └── depends on Library B
          └── depends on Library C
                  └── depends on Library D
```

DNF automatically handles the entire dependency tree.

---

# Why Dependencies Matter

Dependencies provide several advantages.

---

# 1. Shared Libraries

Instead of every application including its own copy:

* libraries are installed once system-wide
* multiple applications can share them

This:

* saves disk space
* reduces duplication

---

# 2. Easier Updates

If a security issue exists in a shared library:

* updating the library fixes all dependent applications

---

# 3. Better Compatibility

Dependency systems help ensure:

* software uses compatible versions
* required features exist on the system

---

# Package Relationships

Packages can:

* provide features
* require features

---

# `--provides`

Shows what capabilities a package provides.

## Example

```bash id="8lg6yz"
dnf repoquery --provides nginx
```

Possible examples:

* binaries
* libraries
* virtual package features

---

# `--requires`

Shows what a package depends on.

## Example

```bash id="fgrlhz"
dnf repoquery --requires nginx
```

This lists:

* required libraries
* required binaries
* runtime requirements

---

# `--what-requires`

Shows which packages depend on a specific package or feature.

## Example

```bash id="mjlwmr"
dnf repoquery --what-requires openssl
```

Useful for:

* dependency analysis
* understanding package relationships

---

# `--what-provides`

Shows which package provides a specific file or capability.

## Example

```bash id="0m3n7g"
dnf repoquery --what-provides /usr/bin/python3
```

Very useful for:

* troubleshooting
* locating package owners

---

# `deplist`

Displays dependency information for a package.

## Example

```bash id="a6rjcz"
dnf deplist nginx
```

Shows:

* required dependencies
* providers for those dependencies

---

# Practical Example

## Install Git

```bash id="8yoj1u"
sudo dnf install git
```

DNF may install:

* git
* perl libraries
* SSL libraries
* compression libraries

automatically.

You only requested:

* `git`

but DNF resolved all required dependencies.

---

# Dependency Problems

Without proper dependency management:

* applications may crash
* software may not start
* version conflicts may appear

This problem is commonly called:

```text id="olw2h8"
dependency hell
```

Modern package managers like:

* `dnf`
* `apt`

exist largely to solve this problem.

---

# Summary

| Concept                | Meaning                               |
| ---------------------- | ------------------------------------- |
| Dependency             | Required software/resource            |
| Dependency Resolution  | Automatically installing requirements |
| Recursive Dependencies | Dependencies of dependencies          |
| `--requires`           | Show package requirements             |
| `--provides`           | Show package capabilities             |
| `--what-requires`      | Show dependent packages               |
| `--what-provides`      | Show package provider                 |
| `deplist`              | Show dependency tree information      |
