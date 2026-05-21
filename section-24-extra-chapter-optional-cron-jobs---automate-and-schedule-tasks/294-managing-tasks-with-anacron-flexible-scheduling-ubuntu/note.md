# 294. Managing Tasks with anacron: Flexible Scheduling [Ubuntu]

# problem with normal cron

Traditional cron has important limitations:

---

# limitation 1: system must be running

Suppose cronjob scheduled:

```text
daily backup at 3 AM
```

BUT:

* laptop powered off overnight

Result:

```text
job is skipped completely
```

Normal cron does NOT recover missed executions.

---

# limitation 2: power-sensitive tasks

Cron executes:

```text
regardless of battery state
```

This is bad for laptops because:

* backups may drain battery
* indexing jobs consume CPU
* updates consume power

---

# solution: anacron

`anacron` designed mainly for:

* laptops
* desktops
* non-24/7 systems

---

# what anacron solves

## 1. executes missed jobs

If:

* system was powered off

then:

```text
anacron runs missed periodic jobs later
```

usually:

* during next boot

---

# 2. better laptop behavior

Ubuntu's default configuration often:

```text
runs anacron jobs only when plugged into AC power
```

Very useful for laptops.

---

# important conceptual difference

| cron                           | anacron |
| ------------------------------ | ------- |
| exact scheduling               | yes     |
| catch missed jobs              | no      |
| designed for always-on servers | yes     |
| good for laptops               | less    |

---

# easiest way to use anacron

Place executable scripts into:

```text
/etc/cron.daily
/etc/cron.weekly
/etc/cron.monthly
```

---

# how it works

Anacron eventually executes:

```text
run-parts
```

which:

```text
runs all executable files inside those directories
```

---

# filename restrictions

Scripts must match:

```text
^[a-zA-Z0-9_-]+$
```

Allowed:

* letters
* numbers
* `_`
* `-`

NOT allowed:

* spaces
* dots
* strange symbols

---

# example valid filenames

GOOD:

```text
backup
cleanup_logs
daily-update
```

BAD:

```text
backup.sh
cleanup logs
daily.backup
```

(Some implementations reject dotted names.)

---

# inspecting existing jobs

```bash
cd /etc/cron.daily
```

```bash
ls
```

You may see:

* apt updates
* logrotate
* package cleanup scripts

---

# inspecting script contents

Example:

```bash
cat apache2
```

Usually:

* shell scripts
* maintenance commands

---

# another anacron configuration method

Main config file:

```text
/etc/anacrontab
```

---

# anacrontab format

```text
[period] [delay-after-boot] [identifier] [command]
```

---

# example

```text
1 5 cron.daily run-parts --report /etc/cron.daily
```

Meaning:

| Field      | Meaning                   |
| ---------- | ------------------------- |
| 1          | every 1 day               |
| 5          | wait 5 minutes after boot |
| cron.daily | identifier                |
| command    | execute daily scripts     |

---

# another example

```text
7 10 cron.weekly run-parts --report /etc/cron.weekly
```

Meaning:

* every 7 days
* wait 10 minutes after boot
* execute weekly jobs

---

# monthly jobs

Special keyword:

```text
@monthly
```

Used because:

```text
months have variable number of days
```

---

# important command: `run-parts`

```text
run-parts
```

executes:

```text
all executable files in directory
```

Very important Linux administration utility.

---

# understanding `/etc/crontab`

Example:

```bash
17 * * * * root cd / && run-parts --report /etc/cron.hourly
```

Meaning:

* every hour at minute 17
* run hourly scripts

---

# important logic

This line:

```bash
25 6 * * * root test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; }
```

means:

```text
if anacron does NOT exist
→ run cron.daily directly
```

---

# understanding `test -x`

```bash
test -x /usr/sbin/anacron
```

checks:

```text
is executable file present?
```

---

# understanding `||`

```bash
command1 || command2
```

Meaning:

```text
run command2 only if command1 fails
```

---

# practical logic

If:

* anacron installed

then:

```text
anacron handles daily jobs
```

Otherwise:

```text
cron directly runs /etc/cron.daily
```

Very elegant Linux compatibility design.

---

# checking anacron service

```bash
systemctl cat anacron.service
```

Shows:

* systemd unit configuration
* timers
* power conditions
* dependencies

---

# customizing anacron service

```bash
sudo systemctl edit anacron.service
```

Used to:

* override default behavior
* change conditions
* adjust timing

---

# important Ubuntu integration

Modern Ubuntu:

```text
integrates cron/anacron with systemd
```

So:

* cron still exists
* but systemd manages services/timers underneath

---

# real-world example

Suppose laptop:

* off for 3 days

Daily backup job:

```text
should have run 3 times
```

When laptop boots:

```text
anacron executes missed daily tasks
```

instead of losing them.

---

# important production insight

Servers:

```text
usually prefer cron
```

because:

* always online
* exact scheduling important

Laptops/desktops:

```text
often benefit from anacron
```

because:

* intermittent uptime

---

# useful commands summary

Inspect daily jobs:

```bash
cd /etc/cron.daily
```

List scripts:

```bash
ls
```

Inspect script:

```bash
cat apache2
```

Inspect anacron config:

```bash
cat /etc/anacrontab
```

Inspect service:

```bash
systemctl cat anacron.service
```

Edit service override:

```bash
sudo systemctl edit anacron.service
```

Test executable:

```bash
test -x /usr/sbin/anacron
```

Run directory scripts:

```bash
run-parts --report /etc/cron.daily
```
