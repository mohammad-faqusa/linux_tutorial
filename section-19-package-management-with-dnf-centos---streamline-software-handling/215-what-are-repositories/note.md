# 215. What are Repositories?

## Definition

A repository (repo) is a location that stores software packages and metadata used by the package manager.

Repositories allow package managers such as:

```bash id="trd7r4"
dnf
```

to:

* search for software
* download packages
* resolve dependencies
* install updates

You can think of a repository as:

> a software warehouse or software server.

---

# What Does a Repository Contain?

A repository usually contains:

* RPM packages
* package metadata
* dependency information
* package signatures
* update information

Example package types:

* `.rpm`
* metadata databases
* repository indexes

---

# How Repositories Work

When you run:

```bash id="6g5qmv"
sudo dnf install nginx
```

DNF:

1. reads repository configuration
2. connects to enabled repositories
3. downloads metadata
4. resolves dependencies
5. downloads required RPM packages
6. installs them using RPM underneath

---

# Repository Configuration Files

In Red Hat-based systems, repositories are configured through files.

---

# Main DNF Configuration File

```bash id="b4fy8m"
/etc/dnf/dnf.conf
```

This contains:

* global DNF settings
* default behaviors
* package manager configuration

Example settings:

* GPG checking
* caching
* logging
* install options

---

# Repository Definition Files

Most repositories are defined inside:

```bash id="fux8s7"
/etc/yum.repos.d/*.repo
```

Each `.repo` file usually defines:

* repository name
* base URL
* whether the repository is enabled
* GPG verification settings

---

# Example `.repo` File

Example:

```ini id="jdfw4s"
[epel]
name=Extra Packages for Enterprise Linux
baseurl=https://download.fedoraproject.org/pub/epel/9/Everything/x86_64/
enabled=1
gpgcheck=1
```

---

# Explanation of Important Fields

| Field        | Meaning                   |
| ------------ | ------------------------- |
| `[epel]`     | Repository ID             |
| `name=`      | Human-readable name       |
| `baseurl=`   | Repository URL            |
| `enabled=1`  | Repository enabled        |
| `gpgcheck=1` | Verify package signatures |

---

# Listing Repositories

## Show enabled repositories

```bash id="mqn7yf"
dnf repolist
```

---

## Show all repositories

```bash id="2x5m8z"
dnf repolist all
```

This includes:

* enabled repos
* disabled repos

---

# Enabling and Disabling Repositories

## Enable a repository

```bash id="jlwmtn"
sudo dnf config-manager --set-enabled crb
```

---

## Disable a repository

```bash id="s4rklf"
sudo dnf config-manager --set-disabled crb
```

---

# Why Repositories Matter

Repositories are critical because they:

* provide trusted software sources
* manage updates centrally
* simplify dependency handling
* improve system security

Without repositories:

* software installation becomes manual and error-prone

---

# Official vs Third-Party Repositories

## Official Repositories

Provided by the Linux distribution itself.

Examples:

* BaseOS
* AppStream
* CRB

---

## Third-Party Repositories

Provided by:

* software vendors
* communities
* external maintainers

Examples:

* EPEL
* Docker repository
* PostgreSQL repository

---

# Security Importance

Repositories often use:

* GPG signatures
* package verification

This helps ensure:

* packages are authentic
* software was not modified maliciously

---

# Relationship Between DNF and Repositories

DNF heavily depends on repositories.

Without repositories:

* `dnf install`
* `dnf update`
* `dnf search`

would not work automatically.

Repositories are the backbone of package management in Red Hat-based systems.
