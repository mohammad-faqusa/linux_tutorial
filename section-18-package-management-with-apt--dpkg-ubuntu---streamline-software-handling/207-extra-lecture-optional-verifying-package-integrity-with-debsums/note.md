## 207. Extra lecture (optional): Verifying Package Integrity with Debsums

# 207. Extra Lecture (Optional): Verifying Package Integrity with `debsums`

---

# What is `debsums`?

debsums is a utility used to verify:

```text id="debsum01"
whether installed package files were modified or corrupted
```

It checks installed files against checksums stored by Debian packages.

---

# Why Is This Useful?

Over time files may become:

* corrupted
* accidentally modified
* overwritten manually
* tampered with
* damaged by disk issues

`debsums` helps detect this.

---

# Important Concept: Checksums

A checksum is:

```text id="debsum02"
a mathematical fingerprint of file contents
```

If file contents change:

✅ checksum changes too.

---

# Example Idea

Original package file:

```text id="debsum03"
/usr/bin/ls
```

Package metadata stores expected checksum.

`debsums` recalculates checksum of actual file and compares it.

---

# If Checksums Match

✅ file is unchanged.

---

# If Checksums Differ

❌ file was modified or corrupted.

---

# Installing `debsums`

```bash id="debsum04"
sudo apt install debsums
```

---

# Basic Usage

Verify all installed packages:

```bash id="debsum05"
sudo debsums
```

---

# Typical Output

Usually no output means:

```text id="debsum06"
everything verified successfully
```

---

# Showing Only Changed Files

```bash id="debsum07"
sudo debsums -c
```

`-c` means:

```text id="debsum08"
show changed files only
```

Very useful.

---

# Example Output

```text id="debsum09"
/usr/bin/example FAILED
```

Meaning checksum mismatch detected.

---

# Verify One Specific Package

Example:

```bash id="debsum10"
sudo debsums bash
```

or:

```bash id="debsum11"
sudo debsums openssl
```

---

# Silent Mode

```bash id="debsum12"
sudo debsums -s
```

Shows only errors/problems.

---

# Important Limitation

Not all packages include checksum information.

Some packages may show:

```text id="debsum13"
no md5sums for package
```

This is normal sometimes.

---

# What Files Usually Get Verified?

Common package files:

* binaries
* libraries
* documentation
* configs shipped by package

---

# Important Caveat About Config Files

Some configuration files are EXPECTED to change.

Examples:

```text id="debsum14"
/etc/nginx/nginx.conf
```

or:

```text id="debsum15"
/etc/ssh/sshd_config
```

Administrators modify them intentionally.

So checksum mismatch there may be normal.

---

# Why Is This Useful for Security?

`debsums` can help detect:

* unexpected modifications
* compromised binaries
* malware tampering
* accidental overwrites

Very useful for:

* servers
* security audits
* troubleshooting

---

# Real Example Scenario

Suppose malware replaced:

```text id="debsum16"
/usr/bin/ssh
```

with a malicious binary.

`debsums` may detect mismatch.

---

# Important Distinction

`debsums` only checks:

```text id="debsum17"
files managed by Debian packages
```

It does NOT verify:

* manually installed software
* random scripts
* user files
* custom binaries

---

# Relationship with APT and dpkg

APT and `dpkg` install packages.

`debsums` verifies package-installed files afterward.

---

# Useful Combination

Find corrupted package → reinstall package.

Example:

```bash id="debsum18"
sudo apt install --reinstall bash
```

---

# Reinstalling Packages

APT can reinstall package files:

```bash id="debsum19"
sudo apt install --reinstall package_name
```

Very useful repair technique.

---

# Important Linux Administration Concept

Linux package management systems maintain:

```text id="debsum20"
expected package file states
```

Tools like `debsums` help validate:

```text id="debsum21"
whether the real filesystem still matches package expectations
```

This is useful for:

* integrity checking
* troubleshooting
* security auditing
* system recovery.
