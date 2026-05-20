# 288. The Cron Daemon `crond` & Crontab Files

# what is the cron daemon?

The cron daemon:

```text id="crond001"
crond
```

is:

```text id="crond002"
background service responsible for scheduled jobs
```

Very similar conceptually to:

* systemd services
* background daemons

---

# what does `crond` do?

Its main responsibilities:

* read cron configuration files
* monitor current time
* execute scheduled commands automatically

---

# important internal behavior

Cron daemon:

```text id="crond003"
wakes up every minute
```

Then:

* checks schedules
* determines whether jobs should run

---

# historical origin

The name comes from Greek:

```text id="crond004"
Chronos = time
```

Very old Unix terminology.

---

# conceptual workflow

```text id="crond005"
crond running
↓
checks current minute
↓
reads cron schedules
↓
runs matching jobs
```

---

# where cronjobs are stored

Cron reads:

```text id="crond006"
crontab files
```

---

# user-specific cronjobs

Common locations:

Ubuntu/Debian:

```text id="crond007"
/var/spool/cron/crontabs
```

Other Unix systems may use:

```text id="crond008"
/var/cron/tabs
```

---

# important security note

These files are:

```text id="crond009"
VERY sensitive
```

because:

* they automatically execute commands

Thus:

* permissions strictly controlled.

---

# system-wide cron file

Main system cron file:

```text id="crond010"
/etc/crontab
```

---

# important permissions

This file:

* must belong to root
* must NOT be writable by others

Otherwise:

```text id="crond011"
security disaster possible
```

because malicious users could schedule commands.

---

# additional cron directories

Ubuntu/Debian often also use:

```text id="crond012"
/etc/cron.d
```

---

# important note from course

Generally:

```text id="crond013"
system administrators should avoid using /etc/cron.d directly
```

unless:

* packaging software
* advanced administration

---

# why `/etc/cron.d` exists

Many installed packages:

* create cron files automatically there

Examples:

* backups
* package cleanup
* certbot
* logrotate

---

# creating user cronjobs

Most important command:

```bash id="crond014"
crontab -e
```

---

# what does `crontab -e` do?

It:

* safely edits current user's crontab
* validates syntax
* installs cron configuration properly

VERY important best practice.

---

# important recommendation

Use:

```text id="crond015"
crontab -e
```

NOT:

```text id="crond016"
manual editing of spool files
```

because:

* permissions matter
* syntax validation matters
* daemon reload handling matters

---

# first-time launch behavior

You may be asked:

```text id="crond017"
which editor do you want?
```

Examples:

* nano
* vim
* vi

---

# setting editor manually

Example:

```bash id="crond018"
EDITOR=vi crontab -e
```

Temporarily uses:

```text id="crond019"
vi editor
```

---

# important environment concept

`EDITOR`:

```text id="crond020"
environment variable
```

used by many Linux tools.

---

# exploring cron internals

Become root shell:

```bash id="crond021"
sudo -s
```

---

# inspect cron spool

```bash id="crond022"
cd /var/spool/cron
```

or:

```bash id="crond023"
cd /var/spool/cron/crontabs
```

---

# inspect files

```bash id="crond024"
ls
```

```bash id="crond025"
cat username
```

You can see:

```text id="crond026"
actual stored cron definitions
```

---

# IMPORTANT WARNING

Do NOT manually modify these files normally.

Why?

Because:

* permissions may break
* ownership may break
* cron may reject file
* corruption possible

Use:

```bash id="crond027"
crontab -e
```

instead.

---

# listing cronjobs

Show current user's cronjobs:

```bash id="crond028"
crontab -l
```

Very common command.

---

# common crontab workflow

| Command      | Purpose         |
| ------------ | --------------- |
| `crontab -e` | edit cronjobs   |
| `crontab -l` | list cronjobs   |
| `crontab -r` | remove cronjobs |

---

# important distinction

## user cronjobs

Managed using:

```bash id="crond029"
crontab -e
```

Run as:

```text id="crond030"
current user
```

---

# system cronjobs

Stored in:

```text id="crond031"
/etc/crontab
```

Usually:

* root-managed
* may specify execution user

---

# important professional insight

Most backend/devops automation eventually touches:

* cron
* scheduled scripts
* maintenance tasks

Very common examples:

* backups
* cleanup jobs
* email processing
* report generation
* certificate renewal

---

# common cron troubleshooting issue

Cronjobs often fail because:

```text id="crond032"
cron environment differs from terminal environment
```

Examples:

* PATH missing
* HOME different
* shell different

Very common real-world issue.

---

# another common issue

Scripts work manually BUT:

```text id="crond033"
fail under cron
```

Usually because:

* relative paths
* missing permissions
* missing environment variables

---

# important best practice

Inside cronjobs:

* use absolute paths

Example:

BAD:

```text id="crond034"
backup.sh
```

GOOD:

```text id="crond035"
/home/mohammad/scripts/backup.sh
```

---

# likely next lecture

You will probably learn:

* cron time syntax
* minute/hour/day/month/week fields
* special shortcuts
* scheduling examples

This is the most important practical cron skill.

---

# useful commands summary

Edit user cronjobs:

```bash id="crond036"
crontab -e
```

List cronjobs:

```bash id="crond037"
crontab -l
```

Remove cronjobs:

```bash id="crond038"
crontab -r
```

Use vi editor:

```bash id="crond039"
EDITOR=vi crontab -e
```

Inspect spool:

```bash id="crond040"
cd /var/spool/cron/crontabs
```

Show cron service:

Ubuntu:

```bash id="crond041"
systemctl status cron
```

CentOS:

```bash id="crond042"
systemctl status crond
```
