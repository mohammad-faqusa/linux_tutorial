# 209. Best Practices for Resolving Dependency Conflicts with APT

---

# What is a Dependency Conflict?

A dependency conflict happens when:

```text id="bestdep01"
APT cannot find a consistent set of package versions
```

that satisfy all package requirements.

---

# Example

Suppose:

```text id="bestdep02"
Package A needs libfoo >= 2.0
Package B needs libfoo < 2.0
```

Both cannot be satisfied simultaneously.

APT must choose:

* remove something
* downgrade something
* fail

---

# Common Causes of Dependency Conflicts

---

# 1. Third-Party Repositories

Most common cause.

Examples:

* PPAs
* vendor repositories
* manually added repos

These may override Ubuntu packages with incompatible versions.

---

# 2. Mixing Ubuntu Releases

Dangerous example:

```text id="bestdep03"
using jammy repositories on noble
```

This can break core libraries and package chains.

---

# 3. Interrupted Installations

Examples:

* power failure
* Ctrl+C during install
* disk full
* crashes

Can leave packages half-configured.

---

# 4. Manual `dpkg -i`

Remember:

```bash id="bestdep04"
sudo dpkg -i package.deb
```

does NOT automatically resolve dependencies.

Often creates broken states.

---

# 5. Held Packages

Packages marked as held may block upgrades.

Check:

```bash id="bestdep05"
apt-mark showhold
```

---

# Most Important Best Practice

---

# 1. Read Error Messages Carefully

APT error messages are usually informative.

Example:

```text id="bestdep06"
Depends: libfoo >= 2.0 but 1.8 is installed
```

This tells you EXACTLY what the problem is.

---

# 2. Never Panic and Randomly Remove Packages

Bad practice:

❌ deleting random packages
❌ deleting dpkg files manually
❌ forcing removals blindly

This often worsens dependency graphs.

---

# 3. First Try Safe Recovery Commands

---

# Finish Interrupted Configurations

```bash id="bestdep07"
sudo dpkg --configure -a
```

---

# Fix Broken Dependencies

```bash id="bestdep08"
sudo apt -f install
```

Very common recovery sequence.

---

# 4. Use Simulation Mode

Before risky operations:

```bash id="bestdep09"
sudo apt -s full-upgrade
```

or:

```bash id="bestdep10"
sudo apt -s install package_name
```

Simulation reveals:

* removals
* replacements
* dependency chains
* conflicts

without modifying system.

---

# 5. Inspect Package Sources

Very important command:

```bash id="bestdep11"
apt policy package_name
```

Shows:

* installed version
* candidate version
* repository sources
* priorities

---

# Why This Matters

You may discover:

```text id="bestdep12"
problematic package comes from third-party repository
```

instead of Ubuntu official repos.

---

# 6. Avoid Mixing Repositories

Best practice:

✅ use repositories matching your Ubuntu release

Avoid:

❌ mixing:

* noble
* jammy
* focal

repositories together.

---

# 7. Minimize PPAs and Third-Party Repositories

Every repository changes:

```text id="bestdep13"
the global dependency graph
```

More repositories = more conflict risk.

---

# 8. Use Official Repositories When Possible

Ubuntu repositories are tested together.

Third-party repos may introduce:

* incompatible libraries
* newer unsupported versions
* unstable dependencies

---

# 9. Understand Package Holds

Held packages may block dependency resolution.

Show holds:

```bash id="bestdep14"
apt-mark showhold
```

Remove hold:

```bash id="bestdep15"
sudo apt-mark unhold package_name
```

---

# 10. Check Broken Package States

Inspect package states:

```bash id="bestdep16"
dpkg -l
```

Status codes at beginning matter.

Examples:

| Code | Meaning                     |
| ---- | --------------------------- |
| `ii` | properly installed          |
| `iU` | unpacked but not configured |
| `rc` | removed but config remains  |

---

# 11. Use `autoremove` Carefully

Always inspect first:

```bash id="bestdep17"
sudo apt -s autoremove
```

Sometimes large removals are proposed unexpectedly.

---

# 12. Reinstall Damaged Packages

Useful repair technique:

```bash id="bestdep18"
sudo apt install --reinstall package_name
```

---

# 13. Use `ppa-purge` for Bad PPAs

If a PPA caused problems:

```bash id="bestdep19"
sudo ppa-purge ppa:name/repository
```

This:

* removes PPA
* downgrades packages back to Ubuntu versions

Very useful.

---

# 14. Keep System Updated Regularly

Large delayed upgrades increase dependency complexity.

Regular smaller updates are safer.

---

# 15. Avoid Forcing Dangerous Operations

Be cautious with:

```bash id="bestdep20"
--force
```

or low-level `dpkg` hacks.

These can break package database consistency.

---

# Extremely Important Diagnostic Commands

Memorize these:

---

# Repository Sources

```bash id="bestdep21"
grep -rhE ^deb /etc/apt/sources.list*
```

---

# Package Policy

```bash id="bestdep22"
apt policy package_name
```

---

# Fix Dependencies

```bash id="bestdep23"
sudo apt -f install
```

---

# Finish Configuration

```bash id="bestdep24"
sudo dpkg --configure -a
```

---

# Simulate Upgrade

```bash id="bestdep25"
sudo apt -s full-upgrade
```

---

# Show Held Packages

```bash id="bestdep26"
apt-mark showhold
```

---

# Important Linux Administration Philosophy

Dependency management is fundamentally about:

```text id="bestdep27"
maintaining system-wide consistency
```

APT’s job is not merely installing packages.

Its real challenge is ensuring:

```text id="bestdep28"
all installed software versions can coexist correctly
```

That is why Linux package management is one of the most important system administration topics.
