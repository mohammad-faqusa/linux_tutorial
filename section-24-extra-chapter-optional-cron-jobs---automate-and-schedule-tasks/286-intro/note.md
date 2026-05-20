# 286. Introduction — Cronjobs

# what is a cronjob?

A cronjob is:

```text id="cron001"
a scheduled task that runs automatically
```

at:

* specific times
* repeated intervals

on Unix/Linux systems.

---

# common real-world examples

## daily backup

Example:

```text id="cron002"
run backup script every day at 3 AM
```

---

# repeated updates

Example:

```text id="cron003"
run update/check script every minute
```

---

# other common cronjob tasks

| Task                | Example             |
| ------------------- | ------------------- |
| backups             | database dumps      |
| cleanup             | remove temp files   |
| monitoring          | check server health |
| email sending       | newsletters/reports |
| log rotation        | archive old logs    |
| certificate renewal | Let's Encrypt       |
| cache clearing      | backend maintenance |

---

# important concept

Cronjobs are:

```text id="cron004"
time-based automation
```

for Linux/Unix systems.

---

# important question

## don't we already have systemd timers?

Yes.

You already learned:

```text id="cron005"
systemd timers + OnCalendar
```

which are modern alternatives.

---

# then why cron still matters?

Because cron is:

```text id="cron006"
VERY old, portable, and universal
```

---

# major advantages of cron

## 1. portability

Cron works on:

* Linux
* BSD
* Unix
* macOS
* many servers

Unlike:

```text id="cron007"
systemd
```

which is Linux-specific.

---

# 2. extremely common

Many existing systems/products:

```text id="cron008"
already depend on cron
```

Especially:

* web hosting panels
* shared hosting
* old enterprise systems
* legacy backend systems

---

# 3. built into many products

Many applications:

* automatically create cronjobs
* expect cron daemon running

Examples:

* WordPress maintenance
* backups
* Laravel scheduler
* package cleanup
* log rotation

---

# 4. email integration

Cron can:

```text id="cron009"
email command output automatically
```

Very useful for:

* alerts
* failed scripts
* reports

---

# important historical context

Cron is:

```text id="cron010"
one of the oldest Unix automation systems
```

Still heavily used decades later.

That tells you:

```text id="cron011"
it solved an important problem very well
```

---

# how cron works conceptually

A background service:

```text id="cron012"
cron daemon
```

continuously checks:

* current time
* configured schedules

Then:

* launches commands automatically

---

# conceptual flow

```text id="cron013"
Time matches schedule
↓
cron daemon detects match
↓
command/script executed
```

---

# important terminology

| Term    | Meaning                     |
| ------- | --------------------------- |
| cron    | scheduling system           |
| crond   | daemon/service              |
| crontab | schedule configuration file |
| cronjob | scheduled task              |

---

# cron vs systemd timers

| Feature         | cron      | systemd timer                  |
| --------------- | --------- | ------------------------------ |
| portability     | excellent | Linux only                     |
| simplicity      | simple    | more advanced                  |
| logging         | limited   | journalctl integration         |
| dependencies    | minimal   | advanced dependency management |
| calendar syntax | classic   | modern/flexible                |

---

# important practical reality

In professional environments:

```text id="cron014"
you will encounter BOTH
```

systemd timers AND cronjobs.

You should understand both.

---

# typical cronjob examples

## every day at 3 AM

```text id="cron015"
0 3 * * * backup.sh
```

---

# every minute

```text id="cron016"
* * * * * script.sh
```

---

# every Sunday at midnight

```text id="cron017"
0 0 * * 0 cleanup.sh
```

You will learn this syntax later.

---

# important backend relevance

Cronjobs are VERY common in backend systems.

Examples:

* cleanup expired sessions
* send queued emails
* generate reports
* sync databases
* process scheduled payments
* retry failed jobs

---

# example backend workflow

```text id="cron018"
Every 5 minutes:
→ check unpaid invoices
→ send reminders
→ generate notifications
```

Often implemented using:

* cron
* worker scripts

---

# why hosting systems still use cron heavily

Shared hosting environments:

* may not use systemd directly
* need standardized Unix-compatible scheduling

Thus:

```text id="cron019"
cron remains universal
```

---

# important enterprise insight

Cron survived because:

* simple
* stable
* lightweight
* predictable

Many technologies disappear.
Cron did not.

---

# common cron limitations

Compared to systemd:

* weaker dependency management
* weaker logging
* weaker service isolation
* weaker monitoring

But:

```text id="cron020"
simplicity is also a strength
```

---

# likely next topics

Probably:

* crontab syntax
* editing cronjobs
* user cronjobs
* system cronjobs
* special time shortcuts
* cron logging
* cron environment variables
* debugging cron failures

---

# important troubleshooting reality

Cronjobs often fail because:

* PATH differs
* environment variables missing
* permissions wrong
* scripts not executable
* absolute paths missing

Very common real-world issue.

---

# useful commands preview

Edit current user's cronjobs:

```bash id="cron021"
crontab -e
```

List cronjobs:

```bash id="cron022"
crontab -l
```

Remove cronjobs:

```bash id="cron023"
crontab -r
```

Check cron service:

```bash id="cron024"
systemctl status cron
```

Ubuntu/Debian:

```text id="cron025"
cron.service
```

CentOS/RHEL:

```text id="cron026"
crond.service
```
