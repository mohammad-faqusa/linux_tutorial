# 211. Package Management with Snap: Dealing with Self-Contained Applications

## What Problem Does Snap Solve?

Traditional Linux packages usually depend on:

* shared system libraries
* globally installed dependencies

This can cause:

* dependency conflicts
* broken applications after updates
* version incompatibilities

---

# Snap Solution

Snap packages:

* bundle the application together with its dependencies
* create self-contained applications

Advantages:

* applications are more portable
* fewer dependency conflicts
* different applications can use different library versions

Disadvantages:

* packages are usually larger
* applications may start more slowly

---

# How Snap Packages Work

Snap uses:

* a centralized repository/store
* managed by Canonical

Official store:

[Snapcraft Store](https://snapcraft.io?utm_source=chatgpt.com)

Developers can:

* publish applications
* update them independently from the Linux distribution

Snap is used mostly for:

* desktop applications
* GUI software
* developer tools

Examples:

* Firefox
* Visual Studio Code
* Slack
* Discord

---

# Installing a Snap Package

## Example: Install GIMP

GIMP

```bash
sudo snap install gimp
```

---

# Important Snap Directories

## `/var/lib/snapd/snaps`

Contains the actual `.snap` package files.

Example:

```bash
ls /var/lib/snapd/snaps
```

Possible output:

```bash
gimp_123.snap
firefox_456.snap
```

These are compressed filesystem images.

---

# `/snap`

This directory contains mounted Snap applications.

Example:

```bash
ls /snap
```

Possible output:

```bash
core20
gimp
firefox
snapd
```

Each Snap package is mounted separately.

---

# How Snap Internally Works

Snap packages are usually:

* squashfs filesystem images
* mounted using loop devices

You can inspect mounted snaps:

```bash
mount | grep snap
```

or:

```bash
df -h
```

You will often see:

```bash
/dev/loop0
/dev/loop1
```

because every Snap package is mounted as a separate filesystem.

---

# Useful Snap Commands

## List installed snaps

```bash
snap list
```

---

## Search for applications

```bash
snap find code
```

---

## Show package information

```bash
snap info firefox
```

---

## Update all snaps

```bash
sudo snap refresh
```

---

## Remove a snap package

```bash
sudo snap remove gimp
```

---

# Snap vs APT

| Feature            | APT                | Snap             |
| ------------------ | ------------------ | ---------------- |
| Dependencies       | Shared             | Bundled          |
| Package Size       | Smaller            | Larger           |
| Startup Speed      | Faster             | Sometimes slower |
| Isolation          | Minimal            | Sandboxed        |
| Updates            | Distribution-based | Independent      |
| Cross-distribution | Limited            | Better           |

---

# Important Note

In Ubuntu, some applications installed through APT are actually Snap packages internally.

Example:

```bash
sudo apt install firefox
```

may install the Snap version of Firefox behind the scenes.
