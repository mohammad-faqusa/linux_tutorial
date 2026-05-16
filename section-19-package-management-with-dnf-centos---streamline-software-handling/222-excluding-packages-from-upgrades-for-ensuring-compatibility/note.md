## 222. Excluding Packages from Upgrades for Ensuring Compatibility

### Why exclude packages from upgrades?

Sometimes upgrading a package may:

* break compatibility
* introduce bugs
* conflict with drivers
* break enterprise applications
* change configuration behavior

Examples:

* kernel packages
* NVIDIA drivers
* database servers
* Python versions
* Docker/container packages

---

## Temporarily exclude packages during upgrade

### Exclude one package

```bash id="rjmbj0"
sudo dnf upgrade --exclude=package_name
```

Example:

```bash id="hpk1ql"
sudo dnf upgrade --exclude=kernel
```

---

### Exclude multiple packages

```bash id="5n35n9"
sudo dnf upgrade --exclude=package1,package2
```

Example:

```bash id="a9h0q4"
sudo dnf upgrade --exclude=kernel,mysql,python3
```

This exclusion applies only to the current command.

---

## Permanently exclude packages

Edit:

```bash id="mvv6gt"
sudo nano /etc/dnf/dnf.conf
```

Add:

```ini id="l6m78f"
excludepkgs=package1,package2
```

Example:

```ini id="l74e0s"
excludepkgs=kernel*,python3,mysql*
```

Now DNF will permanently ignore those packages during:

* upgrade
* install
* dependency resolution

---

## Exclude packages only for a specific repository

Inside a repo file:

```bash id="wnn5wl"
sudo nano /etc/yum.repos.d/example.repo
```

Add:

```ini id="3zslku"
exclude=package_name
```

This exclusion affects only that repository.

---

## DNF Versionlock plugin

### Purpose

The versionlock plugin:

* locks packages to specific versions
* prevents upgrades beyond a chosen version

This is safer and more precise than simple exclusion.

---

## Install versionlock plugin

In Rocky Linux / RHEL:

```bash id="jlwm7f"
sudo dnf install 'dnf-command(versionlock)'
```

or:

```bash id="mdwcy0"
sudo dnf install python3-dnf-plugin-versionlock
```

---

## Lock a package version

Example:

```bash id="nd5ryg"
sudo dnf versionlock add python3
```

This locks the currently installed version.

---

## Lock a specific version

```bash id="w80h5u"
sudo dnf versionlock add python3-3.9.18-3.el9
```

---

## Show locked packages

```bash id="4s0qv3"
sudo dnf versionlock list
```

---

## Remove a version lock

```bash id="hdyjlwm"
sudo dnf versionlock delete python3
```

Remove all locks:

```bash id="4d7ggz"
sudo dnf versionlock clear
```

---

## Difference between exclude and versionlock

| Feature                       | exclude  | versionlock |
| ----------------------------- | -------- | ----------- |
| Prevent upgrades              | Yes      | Yes         |
| Prevent installation          | Yes      | No          |
| Locks specific version        | No       | Yes         |
| Temporary possible            | Yes      | No          |
| Better for production systems | Moderate | Better      |

---

## Best practices

### Use `exclude`

* for temporary troubleshooting
* when testing updates
* when skipping problematic packages briefly

### Use `versionlock`

* for production servers
* for databases
* for enterprise applications
* for driver compatibility
* when exact package versions matter

---

## Useful examples

### Prevent kernel upgrades temporarily

```bash id="lm95gr"
sudo dnf upgrade --exclude=kernel*
```

---

### Permanently prevent Docker upgrades

```ini id="oqw97r"
excludepkgs=docker*,containerd*
```

---

### Lock Python version

```bash id="55v61u"
sudo dnf versionlock add python3
```

---

### Simulate upgrades while excluding packages

```bash id="ujzrrl"
sudo dnf upgrade --exclude=kernel* --assumeno
```

Useful for reviewing pending changes safely.
