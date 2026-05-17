## 237. Example: Controlling Resources with systemd and cgroups

### goal

* create a custom `systemd` slice
* place Firefox inside that slice
* apply memory limits using cgroups

this demonstrates:

* `systemd`
* slices
* cgroups
* resource limiting

working together

---

## what is a slice?

* special type of `systemd` unit:

```text id="jlwmvn"
.slice
```

* used to organize and manage resources for groups of processes

examples:

* `system.slice`
* `user.slice`

custom example:

```text id="u3mu1o"
browser.slice
```

---

## creating a custom slice

create:

```bash id="oq7yqa"
mkdir -p ~/.config/systemd/user
```

create file:

```bash id="1q5q6v"
nano ~/.config/systemd/user/browser.slice
```

contents:

```ini id="p8a3v0"
[Slice]
MemoryHigh=100M
```

---

## what does `MemoryHigh` mean?

```ini id="kkwb0v"
MemoryHigh=100M
```

soft memory limit:

* kernel tries to keep memory below this value
* processes may still exceed temporarily
* causes memory pressure/throttling

---

## important memory-related settings

### `MemoryHigh`

soft limit:

```ini id="yzmvsx"
MemoryHigh=100M
```

---

### `MemoryMax`

hard limit:

```ini id="0z1k6r"
MemoryMax=100M
```

if exceeded:

* OOM killer may terminate processes

---

## reload user systemd configuration

after creating/editing units:

```bash id="0f5rk5"
systemctl --user daemon-reload
```

required because:

* `systemd` caches unit definitions

---

## launching firefox inside the slice

basic command:

```bash id="q7m4sx"
systemd-run --user --slice=browser.slice /usr/bin/firefox
```

---

## explanation of command

### `systemd-run`

* starts transient units dynamically

---

### `--user`

* use user-level `systemd`
* not system-wide

---

### `--slice=browser.slice`

place process into:

```text id="mjw83m"
browser.slice
```

---

## important issue with scripts/symlinks

many applications:

* are shell scripts
* wrapper launchers
* snap launchers
* symlinks

example:

```bash id="t4v7qo"
which firefox
```

may output:

```text id="1m8v11"
/usr/bin/firefox
```

but:

```text id="t4q5sn"
/usr/bin/firefox
```

may only be a symlink

---

## why is this a problem?

wrapper scripts may:

* create new cgroups
* re-exec processes
* escape the original slice
* modify process hierarchy

result:

* resource limits may not apply correctly

---

## checking symlinks

inspect:

```bash id="7rnrxm"
ls -l $(which firefox)
```

example:

```text id="d0v65v"
/usr/bin/firefox -> ../lib/firefox/firefox.sh
```

---

## finding the real executable

best method:

```bash id="r4vh9f"
ps -ef | grep firefox
```

look for actual binary path

example:

```text id="q9hzrv"
/snap/firefox/current/usr/lib/firefox/firefox
```

---

## launching using the real executable

example:

```bash id="72j6zr"
systemd-run --user --slice=browser.slice \
/snap/firefox/current/usr/lib/firefox/firefox
```

this ensures:

* Firefox remains inside target cgroup
* limits apply properly

---

## checking if firefox is inside the slice

use:

```bash id="km76nq"
systemd-cgls
```

or:

```bash id="d7fudr"
systemctl --user status
```

look for:

```text id="kfyhts"
browser.slice
```

with Firefox processes underneath

---

## monitoring resource usage

live monitoring:

```bash id="a3r4pl"
systemd-cgtop
```

shows:

* memory usage
* CPU usage
* tasks count

for:

```text id="7d8v0m"
browser.slice
```

---

## viewing slice configuration

```bash id="3j9fx5"
systemctl --user cat browser.slice
```

---

## additional useful resource controls

### CPU quota

```ini id="drztu8"
CPUQuota=50%
```

limits CPU usage

---

### process limit

```ini id="0jvldh"
TasksMax=100
```

maximum processes/threads

---

### I/O weight

```ini id="ux0o8k"
IOWeight=200
```

controls disk I/O priority

---

## example advanced slice

```ini id="f7u8tr"
[Slice]
MemoryHigh=100M
MemoryMax=200M
CPUQuota=50%
TasksMax=100
```

---

## important concept

`systemd` slices are simply:

* organized cgroups managed through systemd

this gives:

* easier configuration
* persistent resource control
* service isolation
* integration with Linux kernel cgroups

---

## useful commands summary

reload user units:

```bash id="nyz6l0"
systemctl --user daemon-reload
```

run application inside slice:

```bash id="d9q1j2"
systemd-run --user --slice=browser.slice <binary>
```

view cgroup tree:

```bash id="r9o4hh"
systemd-cgls
```

monitor cgroups:

```bash id="rjrt90"
systemd-cgtop
```

find real executable:

```bash id="3ymljs"
ps -ef | grep firefox
```

check symlink:

```bash id="plq8pv"
ls -l $(which firefox)
```
