

# 217. How Weak Dependencies Enhance Software Efficiency

## What are Weak Dependencies?

Packages can depend on other packages at different levels.

There are two main categories:

---

## 1. Required (Strong) Dependencies

These are essential dependencies.

The software **cannot properly work without them**.

Examples:

* required libraries
* runtime environments
* core system tools

If a required dependency is missing:

* installation may fail
* or the application may not run

Example:

```bash
dnf repoquery --requires package_name
```

---

## 2. Weak Dependencies

These are **optional dependencies**.

The software can still work without them, but they:

* improve functionality
* add convenience features
* improve integration with the desktop/system

---

# Types of Weak Dependencies

## Recommends

The package strongly recommends another package.

Usually useful and commonly needed.

DNF installs these **by default**.

Example:

* a media player recommending extra codecs
* a CLI tool recommending bash completion support

Query them:

```bash
dnf repoquery --recommends package_name
```

---

## Suggests

These are even weaker.

The package *can use* another package if available,
but most users probably do not need it.

DNF usually does NOT automatically install suggested packages.

Example:

* optional plugins
* alternative tools
* integrations

Query them:

```bash
dnf repoquery --suggests package_name
```

---

# Why Weak Dependencies are Useful

They help:

* keep software modular
* reduce required package size
* allow optional features
* avoid bloated installations
* improve flexibility

This is especially important on:

* servers
* containers
* minimal Linux installations

---

# DNF Default Behavior

By default, DNF installs:

* required dependencies
* recommended weak dependencies

But not usually:

* suggested dependencies

---

# Disable Weak Dependencies

## Temporarily During Installation

```bash
sudo dnf install package_name --setopt=install_weak_deps=False
```

This installs only the required dependencies.

---

## Permanently

Edit:

```bash
/etc/dnf/dnf.conf
```

Add:

```ini
install_weak_deps=False
```

Then future installations will skip weak dependencies.

---

# Example Scenario

Suppose you install a text editor.

Required dependencies:

* GUI libraries
* core runtime libraries

Weak dependencies:

* spell checker
* syntax highlighting packages
* language packs

The editor works without them,
but the experience becomes better with them.

---

# Important Design Philosophy

Weak dependencies are part of Linux’s modular philosophy:

> Install only what you truly need.

This improves:

* efficiency
* performance
* maintainability
* storage usage

especially in enterprise Linux and server environments.
