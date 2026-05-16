## 221. How to Safely Upgrade and Cautiously Downgrade with DNF

### Upgrading packages with DNF

* `dnf upgrade` updates installed packages to newer versions available in enabled repositories.
* During upgrade:

  * metadata is refreshed
  * dependency resolution occurs
  * obsolete packages may be replaced

### Upgrade the whole system

```bash
sudo dnf upgrade
```

Equivalent:

```bash
sudo dnf update
```

---

### Upgrade a specific package

```bash
sudo dnf upgrade package_name
```

Example:

```bash
sudo dnf upgrade python3
```

---

### Refresh repository metadata manually

```bash
sudo dnf makecache
```

or:

```bash
sudo dnf upgrade --refresh
```

`--refresh`

* forces metadata refresh before upgrading

---

## Downgrading packages

* `dnf downgrade` installs an older version of a package if available in repositories or cache.
* Downgrading can break dependencies or compatibility.
* Should be done cautiously.

### Downgrade a package

```bash
sudo dnf downgrade package_name
```

Example:

```bash
sudo dnf downgrade python3
```

---

### Downgrade to a specific version

```bash
sudo dnf downgrade package-version
```

Example:

```bash
sudo dnf downgrade python3-3.9.18-3.el9
```

---

## Show available package versions

```bash
dnf list package_name --showduplicates
```

Example:

```bash
dnf list python3 --showduplicates
```

Shows:

* installed version
* all available versions from repositories

---

## Important warnings about downgrading

### Never downgrade critical core packages casually

Avoid downgrading packages like:

* `glibc`
* `dbus`
* `selinux-policy`
* `systemd`
* `rpm`
* `dnf`
* kernel-related low-level libraries

These are tightly integrated with the operating system.

Downgrading them may cause:

* boot failures
* broken services
* SELinux issues
* dependency conflicts
* unstable system state

---

## Never downgrade the whole system to an older minor release

Example:

* Rocky Linux 9.5 → Rocky Linux 9.3

This is unsupported and dangerous.

Reason:

* repositories are designed mainly for forward upgrades
* package dependency trees change over time
* old packages may no longer exist in repos

---

## Safer alternatives to downgrading

### Install multiple versions side-by-side

Example:

* Python virtual environments
* containers
* Flatpak/AppImage
* alternate package names

---

### Use DNF history rollback

View transaction history:

```bash
dnf history
```

Undo a transaction:

```bash
sudo dnf history undo transaction_id
```

Redo a transaction:

```bash
sudo dnf history redo transaction_id
```

This is often safer than manual downgrades.

---

## Simulate upgrade/downgrade before applying

Very useful:

```bash
sudo dnf upgrade --assumeno
```

or:

```bash
sudo dnf downgrade python3 --assumeno
```

Shows:

* packages affected
* dependencies
* removals
* conflicts

without actually changing the system.

---

## Best practices

### Before upgrading

```bash
sudo dnf upgrade --refresh
```

### Before downgrading

1. Check available versions

```bash
dnf list package_name --showduplicates
```

2. Simulate operation

```bash
sudo dnf downgrade package_name --assumeno
```

3. Avoid core system packages

4. Prefer containers/virtual environments when possible

5. Keep backups or snapshots before risky operations
