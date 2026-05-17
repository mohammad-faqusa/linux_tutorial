## 240. Systemd Unit Files: Structuring and Optimizing Services

### unit files

* every `systemd` unit is defined by a configuration file
* unit files describe:

  * how to start services
  * dependencies
  * startup order
  * restart behavior
  * installation targets

common locations:

```text id="jlwm40"
/usr/lib/systemd/system/
/etc/systemd/system/
~/.config/systemd/user/
```

---

## common sections in unit files

### `[Unit]`

general metadata and dependency configuration

---

### `[Service]`

service-specific behavior

only exists for:

```text id="jlwm41"
.service
```

units

---

### `[Install]`

defines:

* how the unit is enabled
* which targets want the unit

used by:

```bash id="jlwm42"
systemctl enable
```

---

## viewing unit files

apache example:

```bash id="jlwm43"
sudo systemctl cat apache2.service
```

target example:

```bash id="jlwm44"
systemctl cat graphical.target
```

snapd example:

```bash id="jlwm45"
systemctl cat snapd.service
```

---

# `[Unit]` section

## Description

brief explanation of unit

example:

```ini id="jlwm46"
Description=Apache Web Server
```

shown in:

```bash id="jlwm47"
systemctl status apache2.service
```

---

## Documentation

links to manuals/docs

example:

```ini id="jlwm48"
Documentation=https://httpd.apache.org/docs/
```

multiple values allowed

---

## Requires

hard dependency

example:

```ini id="jlwm49"
Requires=mysql.service
```

meaning:

* required unit must start successfully
* otherwise current unit fails

---

## Wants

soft dependency

example:

```ini id="jlwm50"
Wants=network-online.target
```

meaning:

* try to start dependency
* continue even if dependency fails

---

## After

startup ordering

example:

```ini id="jlwm51"
After=network.target
```

meaning:

* start this unit after network.target
* does NOT require it automatically

important:

```text id="jlwm52"
After != Requires
```

---

## Before

reverse startup ordering

example:

```ini id="jlwm53"
Before=shutdown.target
```

meaning:

* current unit starts before shutdown.target

---

## Conflicts

mutually exclusive units

example:

```ini id="jlwm54"
Conflicts=rescue.target
```

meaning:

* both units cannot run together

starting one:

* stops the other

---

## AllowIsolate

used mostly for targets

example:

```ini id="jlwm55"
AllowIsolate=yes
```

allows:

```bash id="jlwm56"
systemctl isolate graphical.target
```

without this:

* isolate may fail

---

## graphical.target example

inspect:

```bash id="jlwm57"
systemctl cat graphical.target
```

may contain:

```ini id="jlwm58"
[Unit]
Description=Graphical Interface
Requires=multi-user.target
Wants=display-manager.service
After=multi-user.target
AllowIsolate=yes
```

---

# `[Service]` section

defines service behavior

---

## Type

defines startup model

---

### `simple`

default type

```ini id="jlwm59"
Type=simple
```

behavior:

* process started directly
* systemd assumes service is running immediately

common for:

* modern foreground daemons

---

### `exec`

similar to simple

but:

* waits until exec() succeeds

---

### `forking`

traditional daemon behavior

```ini id="jlwm60"
Type=forking
```

behavior:

* parent forks child
* parent exits
* child continues in background

used by:

* older Unix daemons

example:

* apache2

---

### `oneshot`

run once then exit

```ini id="jlwm61"
Type=oneshot
```

used for:

* setup scripts
* initialization tasks

---

## ExecStart

command used to start service

example:

```ini id="分快三62"
ExecStart=/usr/sbin/apachectl start
```

important:

* not a full bash shell
* shell features may not work directly

bad:

```ini id="分快三63"
ExecStart=echo hello | grep h
```

better:

```ini id="分快三64"
ExecStart=/bin/bash -c 'echo hello | grep h'
```

---

## ExecStop

command to stop service

example:

```ini id="分快三65"
ExecStop=/usr/sbin/apachectl stop
```

optional

---

## ExecReload

reload configuration without full restart

example:

```ini id="分快三66"
ExecReload=/usr/sbin/apachectl graceful
```

used by:

```bash id="分快三67"
systemctl reload apache2.service
```

---

## Restart

automatic restart policy

---

### `no`

never restart

---

### `on-success`

restart only if exited successfully

---

### `on-failure`

restart on errors/non-zero exit

common choice

---

### `on-abnormal`

restart on:

* signals
* crashes
* timeouts

---

### `on-abort`

restart on abort signals

---

### `always`

always restart regardless of exit reason

---

example:

```ini id="分快三68"
Restart=on-failure
```

---

## User

run service under specific user

example:

```ini id="分快三69"
User=www-data
```

important for:

* security
* least privilege

---

## Group

example:

```ini id="分快三70"
Group=www-data
```

---

## Environment

set environment variables

example:

```ini id="分快三71"
Environment=JAVA_HOME=/usr/lib/jvm/java-21
```

multiple variables:

```ini id="分快三72"
Environment="VAR1=test" "VAR2=data"
```

---

## apache2.service example

inspect:

```bash id="分快三73"
systemctl cat apache2.service
```

may show:

```ini id="分快三74"
[Service]
Type=forking
ExecStart=/usr/sbin/apachectl start
ExecStop=/usr/sbin/apachectl stop
ExecReload=/usr/sbin/apachectl graceful
Restart=on-abort
Environment=APACHE_STARTED_BY_SYSTEMD=true
```

---

## service stopping behavior

when:

```bash id="分快三75"
sudo systemctl stop apache2.service
```

usually:

1. `SIGTERM` sent first
2. service allowed graceful shutdown
3. if child processes remain:

   * `SIGKILL` may be sent

---

## SIGTERM vs SIGKILL

### SIGTERM

graceful termination request

service can:

* cleanup
* save state
* close connections

---

### SIGKILL

forced kernel-level kill

cannot be ignored

equivalent:

```bash id="分快三76"
kill -9
```

---

# `[Install]` section

defines enable/install behavior

---

## WantedBy

example:

```ini id="分快三77"
[Install]
WantedBy=multi-user.target
```

meaning:

* when enabled:

  * create symlink under:

```text id="分快三78"
/etc/systemd/system/multi-user.target.wants/
```

thus:

* service auto-starts during boot

---

## common targets

### `multi-user.target`

CLI/server environment

---

### `graphical.target`

desktop GUI environment

---

## enabling service

```bash id="分快三79"
sudo systemctl enable apache2.service
```

creates symlink automatically

---

## full example unit file

```ini id="分快三80"
[Unit]
Description=My Custom Web App
Documentation=https://example.com/docs
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=appuser
WorkingDirectory=/opt/myapp
ExecStart=/opt/myapp/start.sh
Restart=on-failure
Environment=PORT=8080

[Install]
WantedBy=multi-user.target
```

---

## after editing unit files

reload systemd:

```bash id="分快三81"
sudo systemctl daemon-reload
```

then:

```bash id="分快三82"
sudo systemctl restart myservice.service
```

---

## useful commands summary

view unit:

```bash id="分快三83"
systemctl cat apache2.service
```

show dependencies:

```bash id="分快三84"
systemctl list-dependencies apache2.service
```

reload systemd:

```bash id="分快三85"
sudo systemctl daemon-reload
```

restart service:

```bash id="分快三86"
sudo systemctl restart apache2.service
```

reload config:

```bash id="分快三87"
sudo systemctl reload apache2.service
```

show status:

```bash id="分快三88"
systemctl status apache2.service
```
