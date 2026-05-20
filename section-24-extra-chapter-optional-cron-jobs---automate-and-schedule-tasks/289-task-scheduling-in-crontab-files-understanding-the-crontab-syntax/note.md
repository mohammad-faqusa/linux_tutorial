# 289. Task Scheduling in Crontab Files: Understanding Crontab Syntax

# basic crontab structure

A crontab file usually contains:

```text id="cronsyntax001"
1. environment variables
2. scheduled cronjobs
```

---

# environment variables

Before writing cronjobs:

* we can configure environment variables

Very important because:

```text id="cronsyntax002"
cron environment is minimal
```

and differs from normal terminal sessions.

---

# SHELL variable

Example:

```bash id="cronsyntax003"
SHELL=/bin/bash
```

---

# why this matters

By default:

```text id="cronsyntax004"
cron may use /bin/sh
```

instead of bash.

This can break:

* bash-specific syntax
* arrays
* bash expansions
* advanced scripting

---

# PATH variable

Example:

```bash id="cronsyntax005"
PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/bin:/usr/bin
```

---

# why PATH matters

Cron often uses:

```text id="cronsyntax006"
very limited PATH
```

Without proper PATH:

* commands may not be found

Example:

```text id="cronsyntax007"
command not found
```

even though command works manually.

Very common cron problem.

---

# actual cronjob format

Core syntax:

```text id="cronsyntax008"
[minute] [hour] [day] [month] [day-of-week] [command]
```

---

# field meanings

| Field       | Meaning        |
| ----------- | -------------- |
| minute      | 0-59           |
| hour        | 0-23           |
| day         | 1-31           |
| month       | 1-12           |
| day-of-week | 0-7            |
| command     | command/script |

---

# important weekday note

Usually:

| Value  | Day     |
| ------ | ------- |
| 0 or 7 | Sunday  |
| 1      | Monday  |
| 2      | Tuesday |
| ...    | ...     |

---

# example

```bash id="cronsyntax009"
5 3 * * * ping -c 10 google.com
```

Meaning:

```text id="cronsyntax010"
run at 3:05 AM every day
```

---

# wildcard `*`

Asterisk means:

```text id="cronsyntax011"
every possible value
```

Example:

```bash id="cronsyntax012"
* * * * *
```

means:

```text id="cronsyntax013"
every minute
```

---

# practical example

Edit crontab:

```bash id="cronsyntax014"
crontab -e
```

Add:

```bash id="cronsyntax015"
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/bin:/usr/bin
5 3 * * * ping -c 10 google.com > ~/ping-cron.txt
```

---

# output redirection

```bash id="cronsyntax016"
> ~/ping-cron.txt
```

stores output into file.

Otherwise:

* cron may attempt email delivery
* output may disappear

---

# important cron best practice

Always:

```text id="cronsyntax017"
redirect output somewhere
```

Examples:

* log file
* `/dev/null`
* email

---

# direct values

Example:

```bash id="cronsyntax018"
5 3 * * * command
```

Meaning:

```text id="cronsyntax019"
3:05 AM daily
```

---

# multiple values

Example:

```bash id="cronsyntax020"
0,15,30,45 * * * * command
```

Meaning:

```text id="cronsyntax021"
every 15 minutes
```

at:

* :00
* :15
* :30
* :45

---

# ranges

Example:

```bash id="cronsyntax022"
0 8-20 * * * command
```

Meaning:

```text id="cronsyntax023"
every full hour from 8 AM to 8 PM
```

---

# step values

## every 5 minutes

```bash id="cronsyntax024"
*/5 * * * * command
```

Meaning:

```text id="cronsyntax025"
every 5th minute
```

---

# every 2 hours

```bash id="cronsyntax026"
0 */2 * * * command
```

Meaning:

```text id="cronsyntax027"
every even-numbered hour
```

---

# advanced stepping

Example:

```bash id="cronsyntax028"
0 1-23/2 * * * command
```

Meaning:

```text id="cronsyntax029"
every 2 hours starting from 1 AM
```

Hours:

* 1
* 3
* 5
* 7
* ...

---

# weekdays

Example:

```bash id="cronsyntax030"
0 0 * * 1 command
```

Meaning:

```text id="cronsyntax031"
every Monday at midnight
```

---

# common practical schedules

---

# every minute

```bash id="cronsyntax032"
* * * * * command
```

---

# every hour

```bash id="cronsyntax033"
0 * * * * command
```

---

# every midnight

```bash id="cronsyntax034"
0 0 * * * command
```

---

# every Sunday at 2 AM

```bash id="cronsyntax035"
0 2 * * 0 command
```

---

# every 10 minutes

```bash id="cronsyntax036"
*/10 * * * * command
```

---

# weekdays only

```bash id="cronsyntax037"
0 9 * * 1-5 command
```

Meaning:

```text id="cronsyntax038"
9 AM Monday-Friday
```

---

# important cron debugging advice

Cronjobs frequently fail because:

* relative paths
* missing PATH
* wrong shell
* missing permissions

Thus:

```text id="cronsyntax039"
use absolute paths whenever possible
```

---

# BAD example

```text id="cronsyntax040"
backup.sh
```

---

# GOOD example

```text id="cronsyntax041"
/home/mohammad/scripts/backup.sh
```

---

# another important best practice

Scripts should usually be:

```text id="cronsyntax042"
executable
```

Example:

```bash id="cronsyntax043"
chmod +x backup.sh
```

---

# important professional insight

This syntax is heavily used in:

* backend systems
* DevOps
* hosting providers
* CI/CD
* automation scripts

You will encounter it frequently.

---

# useful commands summary

Edit crontab:

```bash id="cronsyntax044"
crontab -e
```

List cronjobs:

```bash id="cronsyntax045"
crontab -l
```

Every minute:

```bash id="cronsyntax046"
* * * * * command
```

Every 5 minutes:

```bash id="cronsyntax047"
*/5 * * * * command
```

Every Monday:

```bash id="cronsyntax048"
0 0 * * 1 command
```

Every hour:

```bash id="cronsyntax049"
0 * * * * command
```

Set shell:

```bash id="cronsyntax050"
SHELL=/bin/bash
```

Set PATH:

```bash id="cronsyntax051"
PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/bin:/usr/bin
```
