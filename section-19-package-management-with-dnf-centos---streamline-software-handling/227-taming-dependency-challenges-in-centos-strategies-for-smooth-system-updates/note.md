## 227. Taming Dependency Challenges in CentOS: Strategies for Smooth System Updates

### installing RPM packages not intended for CentOS

* sometimes we install:

  * third-party RPM packages
  * packages built for another distribution/version

example:

* package built for:

  * Fedora
  * openSUSE
  * newer RHEL version

---

## installing from URL

```bash id="8n4z1v"
sudo dnf install [package-link]
```

example:

```bash id="5x2m7q"
sudo dnf install https://example.com/package.rpm
```

---

# common dependency problems

example errors:

```text id="2u7w9k"
conflicting requests
nothing provides libm.so.6
nothing provides libncursesw.so.6
```

meaning:

* package requires:

  * libraries
  * dependencies
* but CentOS repositories do not contain compatible versions

---

# why does this happen ?

because RPM packages are often built against:

* different library versions
* different system architectures
* newer system releases

example:

```text id="1f8r3y"
package built for Fedora 41
system is CentOS Stream 9
```

libraries may differ.

---

# checking dependency providers

## find which package provides a library

```bash id="4m9q2t"
sudo dnf repoquery --whatprovides libncursesw.so.6
```

---

## possible outputs

### provider found

```text id="9x5v1w"
ncurses-libs-6.2-8.el9.x86_64
```

meaning:

* package `ncurses-libs`

  * contains this library

---

### nothing found

```text id="6q3z8p"
No matches found
```

meaning:

* repositories do not provide this dependency

possible reasons:

* wrong repository
* incompatible distro version
* package built for newer OS
* missing EPEL/CRB repositories

---

# superficial workaround : `--skip-broken`

```bash id="7t1v4m"
sudo dnf install package.rpm --skip-broken
```

---

## what does `--skip-broken` do ?

* skips packages with unresolved dependencies

---

## important warning

this does NOT truly fix dependency problems.

it may:

* install incomplete software
* produce runtime failures
* break application functionality

therefore:

* should be used carefully

---

# better solutions

## 1. enable required repositories

example:

```bash id="3r7m1x"
sudo dnf config-manager --set-enabled crb
sudo dnf install epel-release
```

---

## 2. install missing libraries manually

example:

```bash id="8w2n6k"
sudo dnf install ncurses-libs
```

---

## 3. use packages built specifically for your distro version

best approach:

* use:

  * CentOS Stream RPMs
  * RHEL-compatible RPMs
  * EPEL packages

instead of random RPMs from the internet.

---

# important concept

## shared libraries

example:

```text id="4p8x1z"
libm.so.6
```

means:

* shared math library

usually provided by:

```text id="1v5n3q"
glibc
```

---

## `.so`

* means:

  * shared object

Linux equivalent of:

* dynamic libraries (`.dll` in Windows)

---

# enterprise Linux philosophy

Enterprise systems prioritize:

* stability
* compatibility
* predictable dependencies

therefore:

* random third-party RPMs may conflict with:

  * system libraries
  * package versions
  * dependency chains

---

# safest practice

prefer this order:

1. official repositories
2. EPEL
3. vendor-provided RHEL/CentOS RPMs
4. Flatpak/AppImage/container
5. random RPM downloads (least preferred)
