## 239. Enabling and Disabling Units: Managing Services with systemctl

### automatic service startup in systemd

question:

* how does a service start automatically during boot?

answer:

* by enabling the unit

---

## enabling a service

example:

```bash id="jlwmx1"
sudo systemctl enable --now apache2.service
```

---

## what does this command do?

### `enable`

```bash id="jlwmx2"
sudo systemctl enable apache2.service
```

* configures service to start automatically at boot
* creates symlinks inside target directories

does NOT start immediately

---

### `--now`

```bash id="jlwmx3"
--now
```

additional behavior:

* start service immediately

equivalent to:

```bash id="jlwmx4"
sudo systemctl enable apache2.service
sudo systemctl start apache2.service
```

---

## checking service status

```bash id="jlwmx5"
systemctl status apache2.service
```

shows:

* loaded state
* enabled/disabled
* active/inactive
* PID
* logs

example:

```text id="jlwmx6"
Loaded: loaded (...; enabled; preset: enabled)
Active: active (running)
```

---

## inspecting the unit file

```bash id="jlwmx7"
systemctl cat apache2.service
```

shows full configuration:

* `[Unit]`
* `[Service]`
* `[Install]`

---

## important `[Install]` section

example:

```ini id="jlwmx8"
[Install]
WantedBy=multi-user.target
```

meaning:

* when service is enabled:

  * systemd creates symlink into:

```text id="jlwmx9"
multi-user.target.wants/
```

therefore:

* whenever `multi-user.target` starts
* this service should also start

---

## understanding `WantedBy`

### `WantedBy=multi-user.target`

means:

* target "wants" this service
* soft dependency

during boot:

```text id="jlwm10"
multi-user.target
```

will pull in:

```text id="jlwm11"
apache2.service
```

---

## disabling a service

disable automatic startup:

```bash id="jlwm12"
sudo systemctl disable apache2.service
```

effects:

* removes boot-time symlink
* service will NOT auto-start after reboot

does NOT stop currently running service

---

## stopping the running service

```bash id="jlwm13"
sudo systemctl stop apache2.service
```

stops service immediately

---

## complete disable workflow

check status:

```bash id="jlwm14"
systemctl status apache2.service
```

disable auto-start:

```bash id="jlwm15"
sudo systemctl disable apache2.service
```

stop service:

```bash id="jlwm16"
sudo systemctl stop apache2.service
```

verify:

```bash id="jlwm17"
systemctl status apache2.service
```

---

## how enabling actually works internally

when enabled:

* `systemd` creates symlink

example:

```text id="jlwm18"
/etc/systemd/system/multi-user.target.wants/apache2.service
```

---

## important concept

inside:

```text id="jlwm19"
multi-user.target.wants/
```

there are:

* symlinks
* NOT real unit files

verify:

```bash id="jlwm20"
ls -l /etc/systemd/system/multi-user.target.wants/
```

example:

```text id="jlwm21"
apache2.service -> /usr/lib/systemd/system/apache2.service
```

---

## why symlinks?

advantages:

* avoids duplicating files
* easy enable/disable
* keeps original unit file unchanged

---

## checking whether a service is enabled

```bash id="jlwm22"
systemctl is-enabled apache2.service
```

possible outputs:

```text id="jlwm23"
enabled
disabled
static
masked
```

---

## important states

### enabled

starts automatically at boot

---

### disabled

will not auto-start

---

### static

cannot be enabled directly

usually helper/dependency units

---

### masked

completely blocked from starting

even manually

---

## masking a service

stronger than disabling

```bash id="jlwm24"
sudo systemctl mask apache2.service
```

creates symlink to:

```text id="jlwm25"
/dev/null
```

prevents:

* manual start
* automatic start
* dependency start

---

## unmasking

```bash id="jlwm26"
sudo systemctl unmask apache2.service
```

---

## viewing dependencies

show what target pulls the service:

```bash id="jlwm27"
systemctl list-dependencies multi-user.target
```

---

## listing enabled services

```bash id="jlwm28"
systemctl list-unit-files --state=enabled
```

---

## difference between commands

| Command   | Effect                   |
| --------- | ------------------------ |
| `start`   | run now                  |
| `stop`    | stop now                 |
| `restart` | restart now              |
| `enable`  | auto-start on boot       |
| `disable` | disable boot auto-start  |
| `mask`    | completely block service |

---

## useful commands summary

enable and start:

```bash id="jlwm29"
sudo systemctl enable --now apache2.service
```

enable only:

```bash id="jlwm30"
sudo systemctl enable apache2.service
```

disable:

```bash id="jlwm31"
sudo systemctl disable apache2.service
```

stop:

```bash id="jlwm32"
sudo systemctl stop apache2.service
```

show status:

```bash id="jlwm33"
systemctl status apache2.service
```

show unit file:

```bash id="jlwm34"
systemctl cat apache2.service
```

check enabled state:

```bash id="jlwm35"
systemctl is-enabled apache2.service
```

show symlinks:

```bash id="jlwm36"
ls -l /etc/systemd/system/multi-user.target.wants/
```
