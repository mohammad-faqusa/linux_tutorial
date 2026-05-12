# 208. Dependency Management with APT: Resolving Conflicts and Debugging Techniques

---

# What is Dependency Management?

Most Linux software depends on other software.

Example:

```text id="depapt01"
nginx
   ↓
OpenSSL
   ↓
libc
```

APT’s job is not only installing packages.

Its real responsibility is:

```text id="depapt02"
maintaining a valid dependency graph for the entire system
```

---

# What is a Dependency?

A dependency is:

```text id="depapt03"
a package required by another package
```

Example:

```text id="depapt04"
Package A needs library B
```

Without library B:

❌ package A may not function.

---

# Dependency Relationships

APT packages can declare relationships like:

| Relationship | Meaning                  |
| ------------ | ------------------------ |
| Depends      | required                 |
| Recommends   | strongly suggested       |
| Suggests     | optional                 |
| Conflicts    | cannot coexist           |
| Breaks       | incompatible             |
| Provides     | virtual package provider |

---

# Example: Depends

Example:

```text id="depapt05"
Depends: libc6
```

Means package requires `libc6`.

---

# Example: Conflicts

```text id="depapt06"
Conflicts: package-x
```

Means both packages cannot coexist safely.

APT may remove one package automatically.

---

# Example: Provides

A package may provide a virtual capability.

Example:

```text id="depapt07"
Provides: mail-transport-agent
```

Different packages can satisfy this:

* postfix
* exim
* sendmail

---

# Why Dependency Conflicts Happen

Common causes:

* third-party repositories
* incompatible package versions
* interrupted installations
* manual package manipulation
* mixing repositories
* partial upgrades

---

# Typical Dependency Error

Example:

```text id="depapt08"
Depends: libfoo >= 2.0
but 1.8 is installed
```

Meaning:

```text id="depapt09"
required dependency version mismatch
```

---

# Another Common Error

```text id="depapt10"
unmet dependencies
```

Means APT cannot satisfy dependency requirements consistently.

---

# Important Concept: Dependency Solver

APT contains a dependency resolver.

Its job:

```text id="depapt11"
find a valid package combination
```

Sometimes this becomes difficult or impossible.

---

# Very Important Diagnostic Commands

---

# 1. `apt policy`

Shows:

* installed version
* candidate version
* repository source
* repository priorities

Example:

```bash id="depapt12"
apt policy nginx
```

Extremely useful.

---

# 2. Simulate Operations

Very important debugging tool:

```bash id="depapt13"
sudo apt -s install package_name
```

or:

```bash id="depapt14"
sudo apt -s full-upgrade
```

Shows what APT WOULD do without modifying system.

---

# 3. Fix Broken Dependencies

Common repair command:

```bash id="depapt15"
sudo apt -f install
```

`-f` means:

```text id="depapt16"
fix broken dependencies
```

APT attempts to repair inconsistent package states.

---

# 4. Reconfigure Interrupted Packages

Very important recovery command:

```bash id="depapt17"
sudo dpkg --configure -a
```

Useful after interrupted installations.

---

# 5. Check Held Packages

Sometimes packages are intentionally blocked from upgrading.

Show held packages:

```bash id="depapt18"
apt-mark showhold
```

Held packages often cause dependency conflicts.

---

# 6. Inspect Package Dependencies

Example:

```bash id="depapt19"
apt show package_name
```

Look for:

```text id="depapt20"
Depends:
Recommends:
Conflicts:
Breaks:
```

---

# 7. Dependency Tree Visualization

Install:

apt-rdepends

```bash id="depapt21"
sudo apt install apt-rdepends
```

Then:

```bash id="depapt22"
apt-rdepends nginx
```

Shows recursive dependency tree.

Very educational.

---

# Common Conflict Scenario: Third-Party Repositories

Suppose:

* Ubuntu provides library version 1.0
* third-party repo provides 2.0
* another package requires 1.x

Now APT may struggle to satisfy all constraints.

---

# Example Error

```text id="depapt23"
held broken packages
```

Usually means:

```text id="depapt24"
APT cannot find a consistent dependency solution
```

---

# Dangerous Manual `dpkg` Installs

Manual:

```bash id="depapt25"
sudo dpkg -i package.deb
```

does NOT resolve dependencies automatically.

This often creates broken states.

Repair afterward:

```bash id="depapt26"
sudo apt -f install
```

---

# Important Concept: Package States

Packages can exist in states like:

| State           | Meaning                            |
| --------------- | ---------------------------------- |
| installed       | properly installed                 |
| unpacked        | files extracted but not configured |
| half-configured | interrupted setup                  |
| broken          | inconsistent state                 |

---

# Viewing Package States

```bash id="depapt27"
dpkg -l
```

Status codes appear at beginning of lines.

---

# Repository Mixing Problems

Mixing repositories from:

* different Ubuntu releases
* unstable/testing repos
* incompatible PPAs

can severely break dependency resolution.

Very common beginner mistake.

---

# Example Dangerous Mixing

❌ installing:

```text id="depapt28"
jammy packages on noble
```

may cause:

* library conflicts
* broken upgrades
* impossible dependency chains

---

# Best Practices

✅ use official repositories when possible
✅ minimize third-party repos
✅ simulate risky operations
✅ inspect package sources with `apt policy`
✅ avoid random `.deb` files
✅ repair interrupted installs immediately

---

# Extremely Important Recovery Commands

Memorize these:

```bash id="depapt29"
sudo apt -f install
sudo dpkg --configure -a
sudo apt autoremove
sudo apt clean
```

These solve MANY package-management issues.

---

# Important Linux Administration Philosophy

Dependency management is fundamentally about:

```text id="depapt30"
maintaining system-wide consistency
```

APT’s real challenge is not downloading packages.

It is ensuring:

```text id="depapt31"
all installed software versions can coexist correctly
```

This is one of the most important concepts in Linux system administration.
