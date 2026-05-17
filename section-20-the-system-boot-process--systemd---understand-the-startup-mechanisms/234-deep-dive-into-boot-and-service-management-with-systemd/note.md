## 234. Deep Dive into Boot and Service Management with systemd

### systemd: general structure

* `systemd` is the init system and service manager in most modern Linux distributions
* it is the first process started by the kernel

  * PID = 1
* responsible for:

  * boot process
  * starting services
  * managing dependencies
  * parallel startup
  * logging integration
  * service supervision

---

### system mode

* system-wide instance of `systemd`

* started directly by the kernel during boot

* manages:

  * system services
  * devices
  * mounts
  * sockets
  * targets
  * timers

* reads configuration from unit files

* builds a dependency graph

* starts units in parallel whenever possible

* goal:

  * reduce boot time
  * ensure correct startup order

---

### user mode

* separate `systemd` instance per logged-in user

* started after user login

* manages:

  * user services
  * graphical sessions
  * personal timers
  * background applications

* commands:

```bash
systemctl --user
```

* examples:

  * pipewire
  * graphical session services
  * user timers

---

### systemd basic building blocks

#### unit

* fundamental object managed by `systemd`

* represented by a unit file

* identified by suffix/type

* common unit types:

  * `.service`
  * `.target`
  * `.socket`
  * `.mount`
  * `.timer`
  * `.path`
  * `.device`

---

#### service

* represents a background process/service

* managed through `.service` files

* can be:

  * started
  * stopped
  * restarted
  * reloaded
  * enabled
  * disabled
  * masked

---

### service management commands

```bash
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
```

---

### enable vs start

* `start`

  * starts service immediately
  * does NOT survive reboot automatically

```bash
sudo systemctl start nginx
```

* `enable`

  * creates boot-time symlinks
  * starts automatically at boot

```bash
sudo systemctl enable nginx
```

* both together:

```bash
sudo systemctl enable --now nginx
```

---

### checking service status

```bash
systemctl status nginx
```

shows:

* loaded state
* active state
* PID
* logs
* startup errors

---

### systemd managed units

#### unit file locations

---

#### `/usr/lib/systemd/system`

or sometimes:

#### `/lib/systemd/system`

* default unit files from packages/distribution maintainers
* should generally NOT be edited directly
* package updates may overwrite changes

---

#### `/run/systemd/system`

* runtime-generated units
* temporary
* non-persistent
* removed after reboot

used for:

* dynamically created services
* temporary overrides

---

#### `/etc/systemd/system`

* administrator customizations
* highest priority
* overrides default unit files

this is the correct place for:

* custom services
* overrides
* modified configurations

---

### priority order

higher priority overrides lower priority:

1. `/etc/systemd/system`
2. `/run/systemd/system`
3. `/usr/lib/systemd/system`

---

### viewing systemd unit paths

```bash
systemd-analyze --system unit-paths
```

shows all directories searched by `systemd`

---

### viewing unit file contents

```bash
cat /usr/lib/systemd/system/wpa_supplicant.service
```

better method:

```bash
systemctl cat wpa_supplicant.service
```

advantages of `systemctl cat`:

* shows merged configuration
* includes overrides
* safer and clearer

---

### common unit file structure

example:

```ini
[Unit]
Description=NGINX Web Server
After=network.target

[Service]
ExecStart=/usr/sbin/nginx
Restart=always

[Install]
WantedBy=multi-user.target
```

---

### important sections

#### `[Unit]`

general metadata and dependencies

examples:

```ini
Description=
After=
Requires=
Wants=
```

---

#### `[Service]`

service behavior

examples:

```ini
ExecStart=
ExecStop=
Restart=
Type=
User=
```

---

#### `[Install]`

controls enabling/boot behavior

example:

```ini
WantedBy=multi-user.target
```

---

### dependency relationships

#### `After=`

startup order only

```ini
After=network.target
```

means:

* start this service after network target
* does NOT require network target to exist

---

#### `Requires=`

hard dependency

```ini
Requires=mysql.service
```

means:

* if mysql fails, this service fails too

---

#### `Wants=`

soft dependency

```ini
Wants=mysql.service
```

means:

* try to start mysql
* continue even if mysql fails

---

### reloading systemd after changes

after editing unit files:

```bash
sudo systemctl daemon-reload
```

required because:

* `systemd` caches unit definitions

---

### listing units

all active units:

```bash
systemctl
```

all services:

```bash
systemctl list-units --type=service
```

all installed unit files:

```bash
systemctl list-unit-files
```

---

### checking boot performance

```bash
systemd-analyze
```

detailed blame list:

```bash
systemd-analyze blame
```

dependency graph:

```bash
systemd-analyze critical-chain
```

---

### masking a service

prevents service from starting entirely

```bash
sudo systemctl mask nginx
```

unmask:

```bash
sudo systemctl unmask nginx
```

---

### journal integration

`systemd` integrates with journald logging

view logs:

```bash
journalctl
```

logs for specific service:

```bash
journalctl -u nginx
```

follow live logs:

```bash
journalctl -fu nginx
```
