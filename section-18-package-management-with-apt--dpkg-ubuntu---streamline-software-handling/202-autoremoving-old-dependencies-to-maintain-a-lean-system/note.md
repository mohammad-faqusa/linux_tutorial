## 202. Autoremoving Old Dependencies to Maintain a Lean System

---

# Why Old Dependencies Accumulate

When installing packages with APT:

```bash id="ljlwm01"
sudo apt install package_name
```

APT often installs additional packages automatically.

These are called:

```text id="ljlwm02"
dependencies
```

---

# Example

Installing:

```bash id="ljlwm03"
sudo apt install nginx
```

may also install:

* libraries
* SSL components
* utilities
* supporting packages

---

# Problem Over Time

Later, if you remove the main package:

```bash id="ljlwm04"
sudo apt remove nginx
```

many dependencies may remain installed.

Why?

Because APT cannot always immediately know whether they are still needed.

Over time this creates:

* wasted disk space
* unnecessary software
* larger attack surface
* system clutter

---

# Automatic vs Manual Packages

APT tracks package installation reason.

---

# Manual Packages

Packages YOU explicitly installed:

```text id="ljlwm05"
manual packages
```

Example:

```bash id="ljlwm06"
sudo apt install nginx
```

---

# Automatic Packages

Packages installed as dependencies:

```text id="ljlwm07"
automatic packages
```

APT remembers this internally.

---

# What is `autoremove`?

Command:

```bash id="ljlwm08"
sudo apt autoremove
```

removes packages that:

```text id="ljlwm09"
were installed automatically AND are no longer required
```

---

# Example Scenario

---

# Install Package

```bash id="ljlwm10"
sudo apt install package-x
```

APT installs:

```text id="ljlwm11"
package-x
lib-a
lib-b
lib-c
```

where:

* `package-x` → manual
* libraries → automatic

---

# Remove Main Package

```bash id="ljlwm12"
sudo apt remove package-x
```

Now:

```text id="ljlwm13"
lib-a
lib-b
lib-c
```

may remain unused.

---

# Cleanup

```bash id="ljlwm14"
sudo apt autoremove
```

APT removes those orphaned dependencies.

---

# Preview Before Removal

Always useful:

```bash id="ljlwm15"
sudo apt -s autoremove
```

Simulation mode shows what would be removed.

---

# Example Output

```text id="ljlwm16"
The following packages will be REMOVED:
  libfoo1 libbar2
```

---

# Why This Matters

Unused packages can:

* consume disk space
* introduce vulnerabilities
* slow updates
* complicate dependency graphs

Especially important on:

* servers
* containers
* minimal systems

---

# Best Practice

Good maintenance workflow:

```bash id="ljlwm17"
sudo apt update
sudo apt upgrade
sudo apt autoremove
```

---

# Difference Between `remove` and `autoremove`

---

# `remove`

```bash id="ljlwm18"
sudo apt remove nginx
```

Removes ONLY the specified package.

---

# `autoremove`

```bash id="ljlwm19"
sudo apt autoremove
```

Removes unused automatic dependencies.

---

# Combined Cleanup

APT can combine both:

```bash id="ljlwm20"
sudo apt autoremove --purge
```

This also removes leftover configuration files.

---

# Important Safety Mechanism

APT will NOT remove:

```text id="ljlwm21"
packages marked as manually installed
```

unless explicitly requested.

This prevents accidental major removals.

---

# Viewing Automatically Installed Packages

```bash id="ljlwm22"
apt-mark showauto
```

---

# Viewing Manually Installed Packages

```bash id="ljlwm23"
apt-mark showmanual
```

Very useful commands for understanding package state.

---

# Changing Package State Manually

Mark package as manual:

```bash id="ljlwm24"
sudo apt-mark manual package_name
```

Mark package as automatic:

```bash id="ljlwm25"
sudo apt-mark auto package_name
```

---

# Why Would We Do This?

Sometimes:

* package relationships change
* APT misidentifies importance
* admins want to protect packages from autoremove

Very useful in advanced administration.

---

# Important Real-World Warning

Sometimes careless autoremove operations can remove important packages.

Especially after:

* repository changes
* broken dependencies
* manual package manipulation

Always review removal list carefully.

---

# Example Dangerous Scenario

Suppose a desktop meta-package was removed accidentally.

APT may think:

```text id="ljlwm26"
entire desktop environment is unused
```

Then `autoremove` could propose removing:

* GNOME
* KDE
* display manager
* graphics tools

This is why simulation/review matters.

---

# Safe Workflow

Recommended:

```bash id="ljlwm27"
sudo apt -s autoremove
```

inspect output,

then:

```bash id="ljlwm28"
sudo apt autoremove
```

---

# Important Linux Philosophy

Package management is not only about installing software.

It is also about:

```text id="ljlwm29"
maintaining a clean and internally consistent dependency graph
```

`autoremove` helps keep the system lean and maintainable over time.
