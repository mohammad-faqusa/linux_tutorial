## how does `dnf-automatic.timer` work ?

* `dnf-automatic.timer` is a `systemd timer`
* it works similarly to a cron job
* its job is to activate:

  * `dnf-automatic.service`

---

## relationship

```text
dnf-automatic.timer
        ↓
triggers
        ↓
dnf-automatic.service
        ↓
runs automatic updates
```

---

## check the timer details

```bash id="7b52h4"
systemctl cat dnf-automatic.timer
```

you may see something similar to:

```ini id="g9m13u"
[Timer]
OnBootSec=1h
OnUnitInactiveSec=1d
RandomizedDelaySec=60m
```

---

## meaning of these directives

### `OnBootSec=1h`

* after the system boots:

  * wait 1 hour
  * then start the service

---

### `OnUnitInactiveSec=1d`

* after the last execution finishes:

  * wait 1 day
  * then run again

so effectively:

* it runs approximately every 24 hours

---

### `RandomizedDelaySec=60m`

* adds a random delay up to 60 minutes

example:

* instead of all servers updating exactly at:

  * 12:00 AM
* one server may update at:

  * 12:15
* another:

  * 12:42

this prevents:

* repository overload
* network spikes

especially in enterprise environments

---

## visualize it

```text
system boots
     ↓
wait 1 hour
     ↓
run updates
     ↓
wait 24 hours
     ↓
run again
     ↓
repeat
```

---

## check next activation time

```bash id="n2v1sf"
systemctl list-timers dnf-automatic.timer
```

example output:

```text
NEXT                        LEFT   LAST
Sun 2026-05-17 06:35:12    8h     Sat 2026-05-16 06:02:11
```

---

## manually edit the timer schedule

```bash id="2q4f5x"
sudo systemctl edit --full dnf-automatic.timer
```

example:

```ini id="h2nqwd"
[Timer]
OnCalendar=*-*-* 03:00:00
```

meaning:

* run every day at 3:00 AM

---

## reload systemd after modification

```bash id="1zjcrh"
sudo systemctl daemon-reload
sudo systemctl restart dnf-automatic.timer
```

---

## common timer expressions

### every day at 2 AM

```ini id="f6gxk5"
OnCalendar=*-*-* 02:00:00
```

### every monday at 1 AM

```ini id="8t77e6"
OnCalendar=Mon *-*-* 01:00:00
```

### every hour

```ini id="3dr7j3"
OnCalendar=hourly
```

### every 30 minutes

```ini id="zfw34x"
OnUnitActiveSec=30min
```
