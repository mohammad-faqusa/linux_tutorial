# 295. Managing Tasks with anacron: Flexible Scheduling [CentOS]

# important concept

CentOS differs slightly from Ubuntu:

```text id="anacroncentos001"
anacron functionality is integrated into cronie
```

instead of being fully separate.

---

# package responsible

Required package:

```text id="anacroncentos002"
cronie-anacron
```

---

# installing support

Search packages:

```bash id="anacroncentos003"
sudo dnf search anacron
```

```bash id="anacroncentos004"
sudo dnf search cronie
```

Install:

```bash id="anacroncentos005"
sudo dnf install cronie-anacron
```

---

# problem solved by anacron

Traditional cron limitations:

| Problem       | Description                   |
| ------------- | ----------------------------- |
| missed jobs   | laptop/server was powered off |
| battery drain | jobs run even on battery      |

---

# anacron behavior

If:

* machine off during scheduled execution

then:

```text id="anacroncentos006"
anacron executes missed jobs later
```

Usually:

* after next boot

---

# easiest way to use anacron

Place executable scripts inside:

```text id="anacroncentos007"
/etc/cron.daily
/etc/cron.weekly
/etc/cron.monthly
```

---

# viewing directories

```bash id="anacroncentos008"
ls /etc/cron*
```

---

# filename restrictions

Allowed characters only:

```text id="anacroncentos009"
a-z A-Z 0-9 _ -
```

Regex:

```text id="anacroncentos010"
^[a-zA-Z0-9_-]+$
```

---

# important practical note

Avoid:

* spaces
* dots
* special characters

in cron filenames.

---

# main anacron configuration

File:

```text id="anacroncentos011"
/etc/anacrontab
```

---

# anacrontab format

```text id="anacroncentos012"
[period] [delay-after-boot] [identifier] [command]
```

---

# example configuration

```bash id="anacroncentos013"
1 5 cron.daily nice run-parts /etc/cron.daily
```

Meaning:

| Field      | Meaning                   |
| ---------- | ------------------------- |
| 1          | every day                 |
| 5          | wait 5 minutes after boot |
| cron.daily | identifier                |
| command    | execute daily scripts     |

---

# weekly example

```bash id="anacroncentos014"
7 25 cron.weekly nice run-parts /etc/cron.weekly
```

Meaning:

* every 7 days
* wait 25 minutes after boot

---

# monthly example

```bash id="anacroncentos015"
@monthly 45 cron.monthly nice run-parts /etc/cron.monthly
```

Meaning:

* monthly execution
* wait 45 minutes after boot

---

# understanding important variables

## SHELL

```bash id="anacroncentos016"
SHELL=/bin/sh
```

Commands executed using:

```text id="anacroncentos017"
/bin/sh
```

---

# PATH

```bash id="anacroncentos018"
PATH=/sbin:/bin:/usr/sbin:/usr/bin
```

Defines executable search paths.

---

# MAILTO

```bash id="anacroncentos019"
MAILTO=root
```

Cron/anacron output mailed to:

```text id="anacroncentos020"
root
```

---

# RANDOM_DELAY

```bash id="anacroncentos021"
RANDOM_DELAY=45
```

Very important for servers.

Meaning:

```text id="anacroncentos022"
random additional delay up to 45 minutes
```

---

# why random delay matters

Suppose:

* 10,000 servers boot simultaneously

Without randomization:

```text id="anacroncentos023"
all execute heavy jobs simultaneously
```

Bad for:

* mirrors
* package servers
* networks
* storage systems

Random delay spreads load.

Very important production concept.

---

# START_HOURS_RANGE

```bash id="anacroncentos024"
START_HOURS_RANGE=3-22
```

Meaning:

```text id="anacroncentos025"
jobs only start between 3 AM and 10 PM
```

Outside this range:

* delayed until allowed time window

Useful for:

* avoiding noisy nighttime jobs
* battery optimization
* business-hour scheduling

---

# understanding `nice`

Example:

```bash id="anacroncentos026"
nice run-parts /etc/cron.daily
```

`nice`:

```text id="anacroncentos027"
reduces CPU scheduling priority
```

Meaning:

* background maintenance less aggressive
* interactive users less affected

---

# understanding `run-parts`

```text id="anacroncentos028"
run-parts
```

executes:

```text id="anacroncentos029"
all executable scripts inside directory
```

---

# important architecture

On CentOS:

```text id="anacroncentos030"
cron → launches anacron → launches run-parts
```

Multiple layers working together.

---

# important file

```bash id="anacroncentos031"
sudo nano /etc/cron.hourly/0anacron
```

This script:

```text id="anacroncentos032"
responsible for starting anacron periodically
```

Very important integration point.

---

# another important file

```bash id="anacroncentos033"
cat /etc/cron.d/0hourly
```

Usually contains cron entry triggering:

```text id="anacroncentos034"
/etc/cron.hourly
```

---

# architecture flow

## Step 1

Cron daemon wakes up every minute.

---

# Step 2

Cron executes:

```text id="anacroncentos035"
/etc/cron.d/0hourly
```

---

# Step 3

That triggers:

```text id="anacroncentos036"
run-parts /etc/cron.hourly
```

---

# Step 4

Inside `/etc/cron.hourly`:

```text id="anacroncentos037"
0anacron script runs
```

---

# Step 5

`0anacron` launches:

```text id="anacroncentos038"
anacron
```

---

# Step 6

Anacron checks:

* missed daily jobs
* weekly jobs
* monthly jobs

and executes them if necessary.

---

# important practical insight

This layered design shows classic Linux philosophy:

```text id="anacroncentos039"
small tools cooperating together
```

Instead of:

* one giant scheduler

---

# very important operational insight

Anacron tracks:

```text id="anacroncentos040"
last execution timestamps
```

so it knows:

* whether job missed
* whether it should rerun

Usually stored in:

```text id="anacroncentos041"
/var/spool/anacron
```

---

# checking timestamps

```bash id="anacroncentos042"
ls /var/spool/anacron
```

May show:

* cron.daily
* cron.weekly
* cron.monthly

---

# excellent systems understanding point

By this stage you are now seeing:

* cron
* anacron
* systemd
* shell scripts
* run-parts
* service orchestration

working together as:

```text id="anacroncentos043"
layers of Linux automation infrastructure
```

This is real Linux systems administration knowledge.
