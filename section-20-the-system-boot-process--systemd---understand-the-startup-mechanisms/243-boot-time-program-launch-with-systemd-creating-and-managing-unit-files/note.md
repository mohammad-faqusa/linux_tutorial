## 243. Boot-time Program Launch with systemd: Creating and Managing Unit Files

### project goal

* create our own `systemd` service
* run it automatically on boot
* log:

  * current time
  * ping result to a server

---

## useful date commands

show hour in 24-hour format:

```bash id="boot001"
date +%H
```

show hour with AM/PM:

```bash id="boot002"
date +%I%p
```

show hour and minute with AM/PM:

```bash id="boot003"
date +%I:%M%p
```

show full time:

```bash id="boot004"
date +%T
```

show date:

```bash id="boot005"
date +%m/%d/%Y
```

---

## test ping command

```bash id="boot006"
ping -c 4 google.com
```

meaning:

* send 4 packets only
* then stop

---

## create the service file

create:

```bash id="boot007"
sudo nano /etc/systemd/system/my-network-log.service
```

content:

```ini id="boot008"
[Unit]
Description=Ping a server and log it
Requires=network-online.target
After=network-online.target

[Service]
Type=oneshot
StandardOutput=append:/var/log/network-log.txt
ExecStart=/usr/bin/date '+%%T'
ExecStart=/usr/bin/ping -c 4 google.com

[Install]
WantedBy=multi-user.target
```

---

## important corrections

### typo correction

wrong:

```ini id="boot009"
Requires=network-onlin.target
```

correct:

```ini id="boot010"
Requires=network-online.target
```

---

### use full command paths

better:

```ini id="boot011"
ExecStart=/usr/bin/date '+%%T'
ExecStart=/usr/bin/ping -c 4 google.com
```

find paths:

```bash id="boot012"
which date
which ping
```

---

### why `%%T` instead of `%T`

inside systemd unit files:

* `%` has special meaning
* to pass literal `%`, write `%%`

so:

```ini id="boot013"
ExecStart=/usr/bin/date '+%%T'
```

actually runs:

```bash id="boot014"
date '+%T'
```

---

## why `Type=oneshot`

```ini id="boot015"
Type=oneshot
```

used for commands that:

* run once
* finish
* exit

good for:

* scripts
* maintenance tasks
* boot-time checks
* logging commands

---

## multiple ExecStart lines

with:

```ini id="boot016"
Type=oneshot
```

you can have multiple:

```ini id="boot017"
ExecStart=
```

they run:

* sequentially
* one after another

---

## enable and start service

reload systemd:

```bash id="boot018"
sudo systemctl daemon-reload
```

enable on boot:

```bash id="boot019"
sudo systemctl enable my-network-log.service
```

run immediately for testing:

```bash id="boot020"
sudo systemctl start my-network-log.service
```

or both:

```bash id="boot021"
sudo systemctl enable --now my-network-log.service
```

---

## check status

```bash id="boot022"
systemctl status my-network-log.service
```

because it is `oneshot`, expected state may be:

```text id="boot023"
inactive (dead)
```

after successful execution.

that is normal.

---

## check log output

```bash id="boot024"
cat /var/log/network-log.txt
```

or:

```bash id="boot025"
sudo tail -n 50 /var/log/network-log.txt
```

---

## using a custom folder

if you want:

```text id="boot026"
/network-log/log.txt
```

create folder first:

```bash id="boot027"
sudo mkdir -p /network-log
```

then:

```bash id="boot028"
sudo touch /network-log/log.txt
```

but on CentOS/RHEL:

* SELinux may block writing there

therefore safer:

```text id="boot029"
/var/log/network-log.txt
```

---

## CentOS/RHEL SELinux note

on CentOS/RHEL, SELinux may prevent services from writing to unusual paths like:

```text id="boot030"
/network-log/log.txt
```

easier solution:

* write logs under:

```text id="boot031"
/var/log/
```

example:

```ini id="boot032"
StandardOutput=append:/var/log/network-log.txt
```

---

## check service logs with journalctl

```bash id="boot033"
journalctl -u my-network-log.service
```

latest logs:

```bash id="boot034"
journalctl -u my-network-log.service -n 50
```

follow live:

```bash id="boot035"
journalctl -u my-network-log.service -f
```

---

## safer version with both stdout and stderr

```ini id="boot036"
[Unit]
Description=Ping a server and log it
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
StandardOutput=append:/var/log/network-log.txt
StandardError=append:/var/log/network-log.txt
ExecStart=/usr/bin/date '+%%T'
ExecStart=/usr/bin/ping -c 4 google.com

[Install]
WantedBy=multi-user.target
```

---

## Requires vs Wants here

### `Requires=network-online.target`

hard dependency:

* if network-online.target fails
* service fails too

---

### `Wants=network-online.target`

soft dependency:

* tries to bring network online
* service can still continue if it fails

often better:

```ini id="boot037"
Wants=network-online.target
After=network-online.target
```

---

## useful commands summary

create service:

```bash id="boot038"
sudo nano /etc/systemd/system/my-network-log.service
```

reload:

```bash id="boot039"
sudo systemctl daemon-reload
```

enable:

```bash id="boot040"
sudo systemctl enable my-network-log.service
```

start:

```bash id="boot041"
sudo systemctl start my-network-log.service
```

check status:

```bash id="boot042"
systemctl status my-network-log.service
```

view file log:

```bash id="boot043"
sudo tail -n 50 /var/log/network-log.txt
```

view journal logs:

```bash id="boot044"
journalctl -u my-network-log.service
```

disable:

```bash id="boot045"
sudo systemctl disable my-network-log.service
```

stop:

```bash id="boot046"
sudo systemctl stop my-network-log.service
```
