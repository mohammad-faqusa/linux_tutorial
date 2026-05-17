## 244. Scheduling Delayed Tasks with systemd Timers: Precision and Efficiency

### what are systemd timers?

* `systemd timers` are the modern replacement for many cron jobs
* used to:

  * schedule tasks
  * delay execution
  * run periodic jobs
  * launch services automatically at specific times

timer unit type:

```text id="tim001"
.timer
```

usually activates:

```text id="tim002"
.service
```

units

---

## project goal

previous lecture:

* created:

```text id="tim003"
my-network-log.service
```

now:

* delay its execution after boot

example:

* run 1 minute after startup

---

## first step: disable direct boot startup

disable service itself:

```bash id="tim004"
sudo systemctl disable my-network-log.service
```

because:

* timer should control execution
* not the target directly

---

## creating timer unit

create timer:

```bash id="tim005"
sudo systemctl edit --force --full my-network-log.timer
```

---

## example timer configuration

```ini id="tim006"
[Unit]
Description=Run the network logging service on boot

[Timer]
OnActiveSec=1min
Unit=my-network-log.service

[Install]
WantedBy=timers.target
```

---

# `[Timer]` section

## OnActiveSec

```ini id="tim007"
OnActiveSec=1min
```

meaning:

* run service 1 minute after timer activation

example:

```bash id="tim008"
sudo systemctl start my-network-log.timer
```

after:

```text id="tim009"
1 minute
```

service executes

---

## Unit

```ini id="tim010"
Unit=my-network-log.service
```

specifies:

* which service timer should activate

optional when:

* timer name matches service name

example:

```text id="tim011"
my-network-log.timer
```

automatically maps to:

```text id="tim012"
my-network-log.service
```

---

## WantedBy=timers.target

```ini id="tim013"
WantedBy=timers.target
```

means:

* timer starts automatically when timers.target activates
* enabling timer creates symlink under:

```text id="tim014"
/etc/systemd/system/timers.target.wants/
```

---

## timer accuracy

timers are not always perfectly exact

reasons:

* CPU scheduling
* system load
* power optimization
* timer batching

---

## AccuracySec

improve precision:

```ini id="tim015"
AccuracySec=1sec
```

meaning:

* systemd tries to execute within 1 second accuracy

default:

* often around 1 minute

---

## improved timer example

```ini id="tim016"
[Unit]
Description=Run the network logging service on boot

[Timer]
OnActiveSec=1min
AccuracySec=1sec
Unit=my-network-log.service

[Install]
WantedBy=timers.target
```

---

## reload systemd

after creating/editing timer:

```bash id="tim017"
sudo systemctl daemon-reload
```

---

## start timer manually

```bash id="tim018"
sudo systemctl start my-network-log.timer
```

---

## monitor current time

```bash id="tim019"
date +%T
```

---

## monitor log output live

if using:

```text id="tim020"
/var/log/network-log.txt
```

then:

```bash id="tim021"
sudo tail -f /var/log/network-log.txt
```

or original custom path:

```bash id="tim022"
tail -f /network-log/log.txt
```

---

## enable timer on every boot

```bash id="tim023"
sudo systemctl enable my-network-log.timer
```

after reboot:

* timer activates automatically
* service runs according to schedule

---

## inspect active timers

show running timers:

```bash id="tim024"
sudo systemctl list-timers
```

shows:

* NEXT execution
* LEFT remaining time
* LAST run
* UNIT
* ACTIVATES

---

## show all timers

including inactive:

```bash id="tim025"
sudo systemctl list-timers --all
```

---

## timer states

check status:

```bash id="tim026"
systemctl status my-network-log.timer
```

---

## service logs

view logs:

```bash id="tim027"
journalctl -u my-network-log.service
```

timer logs:

```bash id="tim028"
journalctl -u my-network-log.timer
```

---

## important timer directives

### OnBootSec

```ini id="tim029"
OnBootSec=5min
```

run:

* 5 minutes after boot

---

### OnStartupSec

```ini id="tim030"
OnStartupSec=30sec
```

run:

* after systemd startup

---

### OnUnitActiveSec

```ini id="tim031"
OnUnitActiveSec=10min
```

run:

* 10 minutes after previous execution

useful for recurring timers

---

### OnCalendar

calendar-based scheduling

example:

```ini id="tim032"
OnCalendar=daily
```

or:

```ini id="tim033"
OnCalendar=*-*-* 12:00:00
```

equivalent:

```text id="tim034"
every day at noon
```

---

## recurring timer example

every 5 minutes:

```ini id="tim035"
[Timer]
OnBootSec=1min
OnUnitActiveSec=5min
Unit=my-network-log.service
```

---

## difference between cron and systemd timers

### cron

older scheduling system

---

### systemd timers

advantages:

* integrated with services
* better logging
* dependency handling
* cgroup integration
* easier monitoring
* boot awareness

---

## useful commands summary

create timer:

```bash id="tim036"
sudo systemctl edit --force --full my-network-log.timer
```

reload:

```bash id="tim037"
sudo systemctl daemon-reload
```

start timer:

```bash id="tim038"
sudo systemctl start my-network-log.timer
```

enable timer:

```bash id="tim039"
sudo systemctl enable my-network-log.timer
```

check timer status:

```bash id="tim040"
systemctl status my-network-log.timer
```

list timers:

```bash id="tim041"
systemctl list-timers
```

list all timers:

```bash id="tim042"
systemctl list-timers --all
```

watch log:

```bash id="tim043"
sudo tail -f /var/log/network-log.txt
```

view service logs:

```bash id="tim044"
journalctl -u my-network-log.service
```
