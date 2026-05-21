# 293. The `/etc/crontab` File: Defining System-Wide Tasks

# user cronjobs vs system-wide cronjobs

---

# user-specific cronjobs

Normal user:

```bash
crontab -e
```

Edits:

```text
current user's cronjobs
```

---

# root user's cronjobs

```bash
sudo crontab -e
```

Edits:

```text
root user's private crontab
```

Still:

```text
NOT the system-wide crontab
```

Important distinction.

---

# system-wide cronjobs

Configured in:

```text
/etc/crontab
```

This file:

* affects whole system
* managed directly by root
* supports running commands as different users

---

# important difference in syntax

## user crontab

Format:

```text
[minute] [hour] [day] [month] [dayofweek] [command]
```

---

# system crontab

Format:

```text
[minute] [hour] [day] [month] [dayofweek] [user] [command]
```

Notice:

```text
extra USER field
```

Very important.

---

# why the USER field exists

Because system-wide cron can:

```text
run tasks as ANY user
```

Examples:

* root
* mohammad
* www-data
* postgres
* nginx

---

# example

```bash
* * * * * mohammad echo "hello"
```

Meaning:

* every minute
* execute command as user:

```text
mohammad
```

---

# editing system-wide cron

```bash
sudo nano /etc/crontab
```

Allowed because:

```text
/etc/crontab intentionally edited directly
```

Unlike:

* spool cron files

---

# IMPORTANT correction in your note

This line:

```bash
* * * * * * mohammad cd /home/mohammad && echo '---' >> test.txt
```

contains:

```text
TOO MANY *
```

Cron has:

```text
5 time fields
```

NOT 6.

---

# correct version

```bash
* * * * * mohammad cd /home/mohammad && echo '---' >> test.txt
```

---

# what this command does

Every minute:

* switch to user:

```text
mohammad
```

then:

* go to `/home/mohammad`
* append `---` into `test.txt`

---

# important shell behavior

The command:

```bash
cd /home/mohammad && echo '---' >> test.txt
```

works because:

```text
&& executes second command only if cd succeeds
```

Good practice.

---

# important production use case

Very common:

```text
web server user executing scheduled tasks
```

Example users:

* www-data (Ubuntu)
* nginx
* apache

---

# example: Laravel scheduler

```bash
* * * * * www-data php /var/www/project/artisan schedule:run
```

Why run as:

```text
www-data
```

instead of root?

Because:

* web files belong to www-data
* correct permissions
* safer security model

---

# important security principle

Best practice:

```text
run cronjobs with LOWEST required privileges
```

Avoid:

```text
running everything as root
```

unless necessary.

---

# why this matters

If cronjob compromised:

* attacker gains permissions of cron user

Thus:

* `www-data` safer than `root`

Very important security concept.

---

# common system cron users

| User     | Purpose              |
| -------- | -------------------- |
| root     | system maintenance   |
| www-data | web applications     |
| postgres | database maintenance |
| backup   | backup scripts       |
| nobody   | restricted tasks     |

---

# environment differences

System-wide cron often has:

* slightly different environment
* different PATH
* different HOME

Thus:

```text
absolute paths are VERY important
```

---

# GOOD production example

```bash
0 3 * * * root /usr/bin/rsync -a /data /backup
```

---

# BAD example

```bash
0 3 * * * root rsync -a /data /backup
```

Why bad?

* PATH may differ
* cron may not find `rsync`

---

# another important difference

`/etc/crontab` often already contains:

```bash
SHELL=
PATH=
```

variables globally.

---

# viewing existing system cron

```bash
cat /etc/crontab
```

Usually contains:

* comments
* environment variables
* examples

---

# additional system cron directories

Often used:

```text
/etc/cron.daily/
/etc/cron.hourly/
/etc/cron.weekly/
/etc/cron.monthly/
```

These automatically run scripts periodically.

---

# example

Place executable script in:

```text
/etc/cron.daily/
```

Automatically runs daily.

Very common Linux administration mechanism.

---

# important professional insight

System-wide cronjobs are heavily used for:

* backups
* log rotation
* package cleanup
* database maintenance
* certificate renewal
* monitoring

---

# common debugging commands

Check cron service:

Ubuntu:

```bash
systemctl status cron
```

CentOS:

```bash
systemctl status crond
```

---

# inspect logs

```bash
journalctl -u cron.service
```

or:

```bash
journalctl -u crond.service
```

---

# useful commands summary

Edit user cron:

```bash
crontab -e
```

Edit root cron:

```bash
sudo crontab -e
```

Edit system-wide cron:

```bash
sudo nano /etc/crontab
```

Correct system-wide syntax:

```bash
* * * * * user command
```

Example:

```bash
* * * * * www-data php /var/www/project/artisan schedule:run
```

Check cron logs:

```bash
journalctl -u cron.service
```
