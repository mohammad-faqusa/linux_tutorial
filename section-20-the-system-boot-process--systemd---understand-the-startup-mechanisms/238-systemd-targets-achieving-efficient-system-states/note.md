## 238. Systemd Targets: Achieving Efficient System States

### what is a target?

* a `target` is a special `systemd` unit type:

```text id="nxdq9n"
.target
```

* used to group units logically
* represents a desired system state or goal

similar to:

* runlevels in older SysV init systems

but:

* more flexible
* dependency-based
* parallelized

---

## examples of system states

examples of targets:

* graphical desktop mode
* multi-user server mode
* rescue mode
* emergency mode
* shutdown state

---

## targets group units together

example:

```text id="fkmj0u"
graphical.target
```

may include:

* display manager
* networking
* sound
* desktop environment
* login manager

---

## important target types

### `graphical.target`

full graphical desktop environment

includes:

* GUI
* networking
* multi-user support

similar to old:

```text id="rqmjlwm"
runlevel 5
```

---

### `multi-user.target`

non-graphical multi-user environment

includes:

* networking
* login shells
* system services

but:

* no graphical desktop

similar to:

```text id="v3d44u"
runlevel 3
```

---

### `rescue.target`

single-user rescue mode

minimal services:

* maintenance
* repairs
* troubleshooting

similar to:

```text id="jlwm5n"
runlevel 1
```

---

### `emergency.target`

very minimal environment

only:

* root shell
* minimal mounts

used for:

* severe recovery situations

---

### `poweroff.target`

shutdown system

---

### `reboot.target`

restart system

---

## checking current default target

```bash id="yd1rdd"
systemctl get-default
```

example output:

```text id="9qgj26"
graphical.target
```

means:

* system boots into graphical desktop

---

## viewing target configuration

```bash id="lfh7x6"
systemctl cat graphical.target
```

shows:

* dependencies
* required units
* linked targets

---

## listing all available targets

```bash id="zwrjlwm"
systemctl list-units --type=target --all
```

shows:

* active targets
* inactive targets
* loaded targets

---

## switching targets temporarily

### switch to multi-user mode

```bash id="xyv03d"
sudo systemctl isolate multi-user.target
```

effects:

* stops graphical interface
* switches to terminal-only mode

important:

* unsaved graphical work may be lost

---

### switch back to graphical mode

```bash id="jlwmgx"
sudo systemctl isolate graphical.target
```

starts:

* display manager
* graphical desktop

without rebooting

---

## what does `isolate` mean?

```bash id="qwejlwm"
systemctl isolate
```

means:

* stop units not required by target
* start units required by target
* transition system into target state immediately

similar concept:

```text id="98kzmu"
changing runlevels dynamically
```

---

## changing default boot target

### boot into terminal mode permanently

```bash id="zh1pq0"
sudo systemctl set-default multi-user.target
```

after reboot:

* system boots into CLI only

---

### restore graphical boot

```bash id="j7g48h"
sudo systemctl set-default graphical.target
```

after reboot:

* GUI loads automatically

---

## how `set-default` works

creates symlink:

```text id="jlwmq5"
/etc/systemd/system/default.target
```

pointing to target file

example:

```text id="h7x66k"
default.target -> /usr/lib/systemd/system/graphical.target
```

---

## checking active targets

```bash id="jlwm5u"
systemctl list-units --type=target
```

shows currently active targets only

---

## target dependencies

targets themselves:

* usually do not run commands
* instead:

  * group dependencies
  * organize startup ordering

example:

```ini id="f4mj2r"
[Unit]
Requires=multi-user.target
After=multi-user.target
```

---

## viewing target dependency tree

```bash id="jlwm30"
systemctl list-dependencies graphical.target
```

shows:

* all dependent units
* services
* sub-targets

tree view:

```bash id="4bl0k0"
systemctl list-dependencies --all graphical.target
```

---

## relationship with old runlevels

mapping:

| SysV Runlevel | systemd Target    |
| ------------- | ----------------- |
| 0             | poweroff.target   |
| 1             | rescue.target     |
| 3             | multi-user.target |
| 5             | graphical.target  |
| 6             | reboot.target     |

---

## important notes

### changing to `multi-user.target`

when isolated:

* GUI services stop
* desktop session ends
* graphical applications terminate

---

### remote servers

many Linux servers use:

```text id="b4jlwm"
multi-user.target
```

because:

* no GUI needed
* saves resources

---

### desktop systems

usually use:

```text id="djlwm7"
graphical.target
```

---

## useful commands summary

show default target:

```bash id="txq7dd"
systemctl get-default
```

show target file:

```bash id="jlwm02"
systemctl cat graphical.target
```

list all targets:

```bash id="jlwm91"
systemctl list-units --type=target --all
```

switch target immediately:

```bash id="jlwm62"
sudo systemctl isolate multi-user.target
```

restore GUI:

```bash id="jjlwm3"
sudo systemctl isolate graphical.target
```

change default boot target:

```bash id="djlwm8"
sudo systemctl set-default multi-user.target
```

show dependency tree:

```bash id="jlwm21"
systemctl list-dependencies graphical.target
```
