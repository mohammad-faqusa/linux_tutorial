## 226. EPEL-Release: Extra Packages for Enterprise Linux

### what is EPEL ?

* EPEL stands for:

  * Extra Packages for Enterprise Linux

* it is a repository maintained by:

  * Fedora Project

* provides:

  * additional software packages
  * not included in:

    * Red Hat Enterprise Linux
    * CentOS Project
    * Rocky Linux
    * AlmaLinux

---

# goal of EPEL

* packages should:

  * integrate cleanly with RHEL systems
  * avoid replacing core enterprise packages
  * maintain compatibility and stability

---

# why do we need EPEL ?

many useful applications are missing from default enterprise repositories.

examples:

* htop
* neofetch
* nginx extras
* fail2ban
* ansible
* many development tools

EPEL provides these additional packages.

---

# install EPEL on RHEL-compatible systems

```bash id="3r9n1k"
sudo dnf install epel-release
```

this installs:

* repository definition files

---

# repository files location

```bash id="8u4v2p"
cd /etc/yum.repos.d/
```

you may see files like:

```text id="5q7m0x"
epel.repo
epel-testing.repo
epel-cisco-openh264.repo
```

---

# important note about CentOS Stream

## issue

* CentOS Stream is:

  * slightly ahead of RHEL

therefore:

* some packages may differ from stable RHEL versions

---

# solution : `epel-next-release`

* on CentOS Stream:

  * we also install:

    * `epel-next-release`

* this repository provides:

  * packages rebuilt for newer CentOS Stream packages

---

# enable EPEL on CentOS Stream

## enable CRB repository first

```bash id="7m1d9w"
sudo dnf config-manager --set-enabled crb
```

---

## install EPEL repositories

```bash id="1k6v3q"
sudo dnf install epel-release epel-next-release
```

---

# what is CRB ?

## CRB

* CodeReady Builder

contains:

* development libraries
* build dependencies
* additional packages required by EPEL packages

---

# on RHEL systems

the repository name may differ.

instead of:

```bash id="9x4n2e"
crb
```

you may need:

```bash id="6t8q5f"
sudo subscription-manager repos \
--enable codeready-builder-for-rhel-9-$(arch)-rpms
```

because:

* official RHEL uses:

  * subscription-manager

---

# verify EPEL enabled

```bash id="2p7k1z"
dnf repolist
```

you should see:

```text id="8f3m4v"
epel
epel-next
```

---

# example package from EPEL

```bash id="5n2w7r"
sudo dnf install htop
```

without EPEL:

* package may not exist

with EPEL:

* package becomes available

---

# important enterprise philosophy

EPEL tries to:

* add software
* without breaking enterprise stability

therefore:

* EPEL packages usually avoid:

  * replacing core system packages
  * conflicting with RHEL base packages

This makes EPEL much safer than many random third-party repositories.
