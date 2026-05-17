## 236. Process Grouping & Control: Efficient Resource Management with cgroups

### what are cgroups

* `cgroups` = control groups
* Linux kernel feature for organizing and managing processes
* allow the kernel to:

  * group processes hierarchically
  * monitor resource usage
  * limit available resources

---

### main idea

instead of controlling processes individually:

* we control groups of processes together

example:

* all processes of:

  * nginx
  * docker container
  * database service
  * VM
    can belong to one cgroup

---

### hierarchical structure

* cgroups are hierarchical
* parent cgroup can contain:

  * processes
  * child cgroups

example:

```text id="7ijc3x"
/sys/fs/cgroup/
├── system.slice
│   ├── nginx.service
│   └── sshd.service
└── user.slice
```

---

### inheritance behavior

* child processes automatically inherit the parent's cgroup

example:

* if a service starts subprocesses:

  * all subprocesses remain inside same cgroup automatically

this is very important because:

* resource limits automatically apply to all child processes

---

### why cgroups are useful

#### resource limiting

limit memory:

```text id="4dgl4s"
max 1GB RAM
```

limit CPU:

```text id="v3xuxr"
max 30% CPU
```

limit disk I/O:

```text id="v48u5x"
throttle read/write speed
```

limit process count:

```text id="n8q7kw"
maximum number of processes
```

---

### resource accounting

* monitor how much resources a service consumes

examples:

* CPU usage
* memory usage
* network usage
* I/O usage

very useful for:

* performance analysis
* debugging
* billing in cloud systems

---

### freezing processes

* suspend all processes inside a cgroup temporarily

use cases:

* checkpointing
* container pause
* maintenance operations

---

### common real-world use cases

#### containers

technologies like:

* Docker
* Kubernetes
* Podman

heavily depend on cgroups

cgroups isolate:

* CPU
* memory
* I/O
* process limits

between containers

---

#### system services

`systemd` automatically creates cgroups for services

example:

```bash id="cfvqk8"
systemctl status nginx
```

shows:

* service processes
* cgroup path

---

#### shared servers

multiple applications on same server:

* web server
* database
* cache
* containers

cgroups prevent one service from:

* consuming all RAM
* exhausting CPU
* crashing the system

---

### cgroups and systemd

modern Linux systems:

* `systemd` manages cgroups automatically

every service gets its own cgroup

example hierarchy:

```text id="13j56z"
/system.slice/nginx.service
/system.slice/sshd.service
/user.slice/
```

---

### inspecting cgroups

#### using systemctl

```bash id="njw0hf"
systemctl status nginx
```

shows:

* processes
* cgroup location

example:

```text id="83rlrm"
CGroup: /system.slice/nginx.service
```

---

### systemd-cgtop

similar to:

```bash id="25a8w5"
top
```

but for cgroups instead of processes

run:

```bash id="ebc6pb"
systemd-cgtop
```

shows:

* CPU usage
* memory usage
* tasks count
* I/O usage

per cgroup

---

### controlling display depth

default:

* displays up to 3 levels

change depth:

```bash id="px3ymt"
systemd-cgtop --depth=5
```

---

### viewing cgroup hierarchy

```bash id="ddtzyq"
systemd-cgls
```

displays:

* tree structure of cgroups
* processes inside them

example:

```text id="c7i0ix"
Control group /:
-.slice
├─system.slice
│ ├─nginx.service
│ └─sshd.service
└─user.slice
```

---

### cgroup filesystem

cgroups are exposed through virtual filesystem:

```bash id="9hmm2q"
/sys/fs/cgroup
```

inspect manually:

```bash id="ibj9oq"
ls /sys/fs/cgroup
```

---

### cgroup v1 vs cgroup v2

#### cgroup v1

older design:

* separate hierarchies for each resource type

problems:

* complexity
* inconsistency

---

#### cgroup v2

modern unified hierarchy:

* simpler
* more efficient
* better integration with systemd

most modern distros now use:

```text id="1mhjvh"
cgroup v2
```

---

### checking cgroup version

```bash id="avnlrb"
mount | grep cgroup
```

or:

```bash id="x3x6m4"
stat -fc %T /sys/fs/cgroup
```

possible output:

```text id="zllztq"
cgroup2fs
```

means:

* system uses cgroup v2

---

### example: limiting service memory with systemd

temporary limit:

```bash id="q7zjry"
sudo systemctl set-property nginx.service MemoryMax=500M
```

CPU limit:

```bash id="jmk0gt"
sudo systemctl set-property nginx.service CPUQuota=50%
```

---

### persistent configuration

create override:

```bash id="v8b4z2"
sudo systemctl edit nginx.service
```

example:

```ini id="1d8qmk"
[Service]
MemoryMax=500M
CPUQuota=50%
```

reload:

```bash id="ywx3qe"
sudo systemctl daemon-reload
sudo systemctl restart nginx
```

---

### useful monitoring commands

show service resource usage:

```bash id="g4d2v5"
systemctl status nginx
```

show cgroup tree:

```bash id="08n8mo"
systemd-cgls
```

show live cgroup resource usage:

```bash id="nqg4up"
systemd-cgtop
```

show memory usage:

```bash id="0czwhn"
cat /sys/fs/cgroup/memory.current
```

---

### important idea

`systemd` + `cgroups` together provide:

* process organization
* service isolation
* resource management
* monitoring
* reliability

this is one of the foundational technologies behind:

* containers
* Kubernetes
* modern cloud infrastructure
* service isolation in Linux systems
