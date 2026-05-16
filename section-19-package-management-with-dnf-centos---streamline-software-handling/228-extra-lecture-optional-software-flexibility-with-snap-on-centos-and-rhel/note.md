## 228. Extra lecture (optional): Software Flexibility with Snap on CentOS and RHEL

### package management with Snap

## traditional package management problem

with traditional package managers like:

* `dnf`
* `apt`

dependencies are usually:

* installed globally on the system

example:

```text id="7m2x4v"
Application A → needs library version 1
Application B → needs library version 2
```

this may cause:

* dependency conflicts
* compatibility issues
* broken applications after updates

---

# how Snap solves this

Snap packages:

* bundle:

  * the application
  * most dependencies
  * runtime environment

inside the package itself.

---

## advantages

* applications become:

  * more isolated
  * more portable
  * easier to install

* different applications can use:

  * different dependency versions

without conflicts.

---

## disadvantages

### larger downloads

because:

* dependencies are included

---

### more disk usage

multiple applications may contain:

* duplicate libraries

---

### slower startup sometimes

due to:

* sandboxing
* compression
* mount mechanisms

---

# automatic updates

Snap uses:

* `snapd`

which:

* updates packages automatically
* usually in the background

---

# how Snap works

## centralized repository

Snap packages are mainly distributed through:

* [Snapcraft Store](https://snapcraft.io?utm_source=chatgpt.com)

---

## trust model

* users usually trust:

  * package maintainers/authors
  * Canonical infrastructure

because:

* applications are centrally distributed

---

# examples of Snap applications

* vscode
* spotify
* discord
* postman
* slack

---

# enabling Snap on CentOS/RHEL

## important

EPEL repository is usually required first.

---

## install EPEL

```bash id="6x2p9r"
sudo dnf install epel-release
```

---

## install snapd

```bash id="4n7q1k"
sudo dnf install snapd
```

---

## enable snapd service

```bash id="8v5m3t"
sudo systemctl enable --now snapd.service
```

---

# create Snap symbolic link

many systems also require:

```bash id="1k9w6p"
sudo ln -s /var/lib/snapd/snap /snap
```

---

# reboot or relogin

sometimes needed so:

* snap paths
* environment variables
* mounts

work correctly.

---

# install a Snap package

example:

```bash id="3r8v2m"
sudo snap install code --classic
```

installs:

* Visual Studio Code

---

# search Snap packages

```bash id="5q1t7x"
snap find [package]
```

example:

```bash id="9p4m2v"
snap find spotify
```

---

# list installed snaps

```bash id="7w3n8k"
snap list
```

---

# update snaps manually

```bash id="2v6q1m"
sudo snap refresh
```

---

# important difference : DNF vs Snap

| DNF                     | Snap                        |
| ----------------------- | --------------------------- |
| native system packages  | bundled applications        |
| shared system libraries | isolated dependencies       |
| smaller size            | larger size                 |
| enterprise-focused      | desktop/application-focused |
| highly integrated       | sandboxed                   |
| manual updates common   | automatic updates common    |

---

# enterprise consideration

many enterprise admins prefer:

* DNF/RPM packages

because:

* tighter system integration
* more control
* predictable updates

Snap is more popular for:

* desktop applications
* user convenience
* cross-distribution software delivery
