# 214. Installing Software Manually with the DNF Package Manager

## Package Managers: `yum` and `dnf`

Historically, Red Hat-based distributions used:

```bash id="b8s7up"
yum
```

Modern systems now use:

```bash id="3h4g07"
dnf
```

---

# Relationship Between `yum` and `dnf`

On many modern systems:

```bash id="pmq4l0"
yum
```

is simply a symbolic link to:

```bash id="mjlwmr"
dnf-3
```

Similarly:

```bash id="1t57pp"
dnf
```

also points to:

```bash id="8ov4nk"
dnf-3
```

You can verify this:

```bash id="03j8j0"
ls -l $(which yum)
```

and:

```bash id="mjlwmr"
ls -l $(which dnf)
```

Possible output:

```bash id="qgxqpc"
/usr/bin/yum -> dnf-3
/usr/bin/dnf -> dnf-3
```

So:

* `dnf` is the modern replacement
* `yum` is mostly kept for compatibility

---

# Managing Software with DNF

---

# Search for Packages

## Search by package name or keyword

```bash id="on0ss5"
sudo dnf search nginx
```

Example output may include:

* package names
* descriptions
* available repositories

---

# Install Software

## Install a package

```bash id="v9ef2r"
sudo dnf install nginx
```

DNF will:

* resolve dependencies
* download required packages
* install everything automatically

---

# Remove Software

## Remove a package

```bash id="8h56j7"
sudo dnf remove nginx
```

This removes:

* the package
* possibly unused dependencies

---

# Updating Packages

## Update the entire system

```bash id="zxdqbs"
sudo dnf update
```

This:

* refreshes repositories
* installs newer package versions
* applies security updates

---

# What If a Package Cannot Be Found?

Sometimes a package is unavailable because:

* the repository is disabled
* extra repositories are required

---

# Enable the CRB Repository

In CentOS Stream or Red Hat Enterprise Linux, some developer-related packages are stored in the:

```text id="xj6x12"
CRB
```

repository.

CRB means:

```text id="7zw0ye"
CodeReady Builder
```

Enable it with:

```bash id="y5y1oe"
sudo dnf config-manager --set-enabled crb
```

This makes additional packages available.

---

# EPEL Repository

Another very important repository is:

```text id="u9d7qw"
EPEL
```

which stands for:

```text id="2t2srt"
Extra Packages for Enterprise Linux
```

Provided by Fedora Project.

It contains many additional packages not included in default enterprise repositories.

---

# Install EPEL

```bash id="hynxjn"
sudo dnf install epel-release
```

After installing EPEL:

* more software becomes available through DNF

---

# Common DNF Workflow

## 1. Search

```bash id="n8s1fa"
dnf search docker
```

---

## 2. Install

```bash id="1g6i70"
sudo dnf install docker
```

---

## 3. Update

```bash id="hjh3ci"
sudo dnf update
```

---

## 4. Remove

```bash id="k7cqpi"
sudo dnf remove docker
```

---

# Useful Additional Commands

## Show package information

```bash id="xb80vn"
dnf info nginx
```

---

## List installed packages

```bash id="hcn9oc"
dnf list installed
```

---

## List available updates

```bash id="6h74e2"
dnf check-update
```

---

# Why DNF is Powerful

DNF automatically handles:

* dependency resolution
* package conflicts
* repository management
* updates
* package verification

This makes it much safer and easier than manually using `rpm`.

---

# Important Real-World Note

In enterprise Linux environments:

* enabling repositories correctly is extremely important
* many packages exist only in:

  * CRB
  * EPEL
  * third-party repositories

Understanding repositories is a core Linux administration skill.

Yes — the concept is similar, but the implementation is different between Debian-based systems and Red Hat-based systems.

---

# Main Difference

| System Family                                     | Package Manager | Repository Format |
| ------------------------------------------------- | --------------- | ----------------- |
| Ubuntu / Debian                                   | `apt`           | `.list` files     |
| CentOS Stream / Red Hat Enterprise Linux / Fedora | `dnf`           | `.repo` files     |

---

# Ubuntu / Debian Repository System

Repositories are usually stored in:

```bash id="2p52i8"
/etc/apt/sources.list
```

or:

```bash id="m9l6o0"
/etc/apt/sources.list.d/
```

Example repository:

```text id="h5rbr8"
deb http://archive.ubuntu.com/ubuntu noble main restricted
```

After adding repositories, you usually run:

```bash id="xg1o92"
sudo apt update
```

to refresh package metadata.

---

# Adding Repositories in Ubuntu

## Method 1 — add-apt-repository

Example:

```bash id="3uy1ps"
sudo add-apt-repository ppa:obsproject/obs-studio
```

This:

* adds repository configuration
* imports signing keys
* updates repository sources

PPA means:

* Personal Package Archive

Mostly used in Ubuntu.

---

## Method 2 — manually adding `.list` files

Example:

```bash id="pswyb1"
sudo nano /etc/apt/sources.list.d/custom.list
```

Then add:

```text id="wz3c4x"
deb https://example.com/repo stable main
```

---

# RPM / DNF Repository System

In Red Hat-based systems, repositories are stored in:

```bash id="n5b4e4"
/etc/yum.repos.d/
```

using `.repo` files.

Example:

```text id="l3gt9h"
[epel]
name=Extra Packages for Enterprise Linux
baseurl=https://download.fedoraproject.org/pub/epel/9/Everything/x86_64/
enabled=1
gpgcheck=1
```

---

# Adding Repositories in DNF Systems

Usually by:

* installing a repository package
* or adding a `.repo` file manually

---

## Example: Install EPEL Repository

```bash id="x16g04"
sudo dnf install epel-release
```

This installs repository configuration automatically.

---

## Manual `.repo` File Example

```bash id="0kfe0m"
sudo nano /etc/yum.repos.d/custom.repo
```

Example content:

```ini id="qqow3v"
[customrepo]
name=Custom Repo
baseurl=https://example.com/repo/
enabled=1
gpgcheck=1
```

---

# Key Structural Difference

## Ubuntu / APT

Repositories are usually:

* line-based entries
* stored in `.list` files

Example:

```text id="mg0ycc"
deb http://repo.url distro component
```

---

## DNF / RPM

Repositories use:

* INI-style configuration blocks
* stored in `.repo` files

Example:

```ini id="mjlwmr"
[repo-name]
name=Repository Name
baseurl=https://repo.url/
enabled=1
```

---

# Another Important Difference

## Ubuntu Uses PPAs

PPAs are a major ecosystem feature in Ubuntu.

Example:

```bash id="rjxgmh"
sudo add-apt-repository ppa:deadsnakes/ppa
```

Red Hat systems generally do NOT use PPAs.

Instead they rely more on:

* official repos
* EPEL
* vendor repositories
* manually added `.repo` files

---

# Metadata Refresh Difference

## Ubuntu

```bash id="86n2i8"
sudo apt update
```

---

## DNF

DNF often refreshes metadata automatically, but you can use:

```bash id="64t2rk"
sudo dnf makecache
```

or:

```bash id="1lq5an"
sudo dnf check-update
```

---

# Summary

| Feature            | Ubuntu/APT                 | RHEL/DNF                |
| ------------------ | -------------------------- | ----------------------- |
| Repository Files   | `.list`                    | `.repo`                 |
| Repo Directory     | `/etc/apt/sources.list.d/` | `/etc/yum.repos.d/`     |
| Common Add Method  | `add-apt-repository`       | install `.repo` package |
| Repository Style   | line-based                 | INI-style               |
| Popular Extra Repo | PPA                        | EPEL                    |
