## 200. Installing Software manually with the Advanced Package Tool (APT)

# 200. Installing Software Manually with APT

---

# What is APT?

APT stands for:

```text id="7ivgbc"
Advanced Package Tool
```

APT is the high-level package management system used in Debian-based distributions such as:

* Ubuntu
* Debian

APT works on top of:

```text id="yq1mfm"
dpkg
```

You can think of it like this:

```text id="vjlwmk"
APT
 ↓
dpkg
 ↓
actual package installation
```

---

# Why APT Exists

`dpkg` alone is not enough for modern package management.

Problems with manual `dpkg` installation:

* dependency issues
* manual downloads
* repository management difficulty
* package updates
* package discovery

APT solves these problems.

---

# Package Sources / Repositories

APT downloads packages from repositories.

Repository definitions are stored in:

```text id="rujlwm"
/etc/apt/sources.list
```

---

# Additional Third-Party Repositories

Additional repositories are usually stored in:

```text id="1k33z4"
/etc/apt/sources.list.d/
```

Each file inside this directory usually ends with:

```text id="49gs18"
.list
```

Example:

```text id="o61xil"
/etc/apt/sources.list.d/docker.list
```

---

# What is a Repository?

A repository is basically:

```text id="2oqtzy"
a server containing packages and package metadata
```

APT connects to repositories to:

* search packages
* download packages
* download updates
* resolve dependencies

---

# Viewing Your Current Repositories

Main repository file:

```bash id="jlwm3r"
cat /etc/apt/sources.list
```

Additional repositories:

```bash id="81uksl"
ls /etc/apt/sources.list.d/
```

---

# Repository Entry Example

Example line:

```text id="24bsib"
deb http://archive.ubuntu.com/ubuntu noble main restricted
```

---

# Understanding This Line

| Part              | Meaning                   |
| ----------------- | ------------------------- |
| `deb`             | binary package repository |
| URL               | repository server         |
| `noble`           | Ubuntu release codename   |
| `main restricted` | repository sections       |

---

# Updating Package Definitions

After repositories are configured, APT must download package metadata.

Command:

```bash id="00e6a7"
sudo apt update
```

This does NOT install updates.

It only:

```text id="jlwm53"
downloads package indexes and definitions
```

Think of it as:

```text id="a79g8r"
refreshing the package database
```

---

# What Does `apt update` Fetch?

APT downloads:

* package names
* versions
* dependency information
* repository metadata

without downloading the actual packages yet.

---

# Installing Packages

Basic syntax:

```bash id="mbmjlwm"
sudo apt install <package_name>
```

Example:

```bash id="3pw9kr"
sudo apt install nginx
```

---

# What Happens Internally?

APT will:

1. resolve dependencies
2. download required packages
3. call `dpkg`
4. configure packages
5. update package database

All automatically.

---

# Automatic vs Manual Packages

APT tracks whether packages are:

| Type      | Meaning                      |
| --------- | ---------------------------- |
| Manual    | explicitly installed by user |
| Automatic | installed as dependencies    |

This matters later for cleanup.

Example:

```bash id="hjlwmq"
sudo apt autoremove
```

removes unused automatically-installed packages.

---

# Suggested and Recommended Packages

Not all related packages are mandatory dependencies.

APT may show:

```text id="hjlwmn"
Suggested packages
Recommended packages
```

---

# Difference

| Type        | Required?                 |
| ----------- | ------------------------- |
| Dependency  | YES                       |
| Recommended | NO but strongly suggested |
| Suggested   | optional enhancement      |

---

# Installing Without Recommendations

Sometimes servers or containers should stay minimal.

Use:

```bash id="jlwmx1"
sudo apt install --no-install-recommends <package>
```

Example:

```bash id="jlwmx2"
sudo apt install --no-install-recommends nginx
```

This reduces:

* disk usage
* unnecessary packages
* attack surface

Very common in:

* Docker containers
* cloud servers
* minimal systems

---

# How to Add Repositories

---

# Traditional Method

Edit:

```text id="jlwmx3"
/etc/apt/sources.list
```

or create a file in:

```text id="jlwmx4"
/etc/apt/sources.list.d/
```

Example:

```bash id="jlwmx5"
sudo nano /etc/apt/sources.list.d/customrepo.list
```

Add:

```text id="jlwmx6"
deb http://example.com/ubuntu noble main
```

Then refresh:

```bash id="jlwmx7"
sudo apt update
```

---

# Modern Recommended Method: `add-apt-repository`

Ubuntu commonly uses:

```bash id="jlwmx8"
sudo add-apt-repository ppa:name/ppa
```

Example:

```bash id="jlwmx9"
sudo add-apt-repository ppa:git-core/ppa
```

Then:

```bash id="jlwmxa"
sudo apt update
```

---

# What is a PPA?

PPA stands for:

```text id="jlwmxb"
Personal Package Archive
```

Used heavily in Ubuntu for third-party software distribution.

---

# Removing Repositories

---

# Remove a PPA

Example:

```bash id="jlwmxc"
sudo add-apt-repository --remove ppa:git-core/ppa
```

---

# Or Delete Repository File Manually

Example:

```bash id="jlwmxd"
sudo rm /etc/apt/sources.list.d/customrepo.list
```

Then refresh:

```bash id="jlwmxe"
sudo apt update
```

---

# Important Security Concept

Repositories are powerful.

When you add a repository, you trust it to install software as root on your system.

Bad repositories can:

* install malicious software
* break dependencies
* destabilize the system

Always use trusted sources.

---

# Common APT Workflow

Typical sequence:

```bash id="jlwmxf"
sudo apt update
sudo apt install package_name
```

---

# Common Maintenance Commands

Update installed packages:

```bash id="jlwmxg"
sudo apt upgrade
```

Remove unused dependencies:

```bash id="jlwmxh"
sudo apt autoremove
```

Remove cached package files:

```bash id="jlwmxi"
sudo apt clean
```

---

# Important Internal Concept

APT maintains a local package database.

Main directories include:

```text id="jlwmxj"
/var/lib/apt/
/var/lib/dpkg/
```

Later we will deeply study:

* package databases
* package states
* broken packages
* repair mechanisms
* locks
* cache systems

These are extremely important for Linux troubleshooting and administration.

