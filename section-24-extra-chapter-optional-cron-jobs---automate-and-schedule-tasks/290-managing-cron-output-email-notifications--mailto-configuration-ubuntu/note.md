# 290. Managing Cron Output: Email Notifications & `MAILTO`

# important cron behavior

If a cronjob produces:

* stdout output
* stderr errors

then:

```text id="cronmail001"
cron tries to email that output
```

to the owner of the cronjob.

This is VERY important historical Unix behavior.

---

# example

Suppose cronjob:

```bash id="cronmail002"
* * * * * ping -c 4 google.com
```

This command generates output.

Cron:

```text id="cronmail003"
captures the output automatically
```

then:

* attempts email delivery.

---

# why this is useful

Very useful for:

* backup reports
* failure alerts
* script debugging
* automation monitoring

Example:

```text id="cronmail004"
cronjob fails overnight
```

You receive:

* automatic email
* error details

---

# default recipient

By default:

```text id="cronmail005"
cron emails the current user
```

who owns the cronjob.

---

# redirecting output manually

Many admins instead prefer:

```bash id="cronmail006"
command > logfile.txt 2>&1
```

because:

* easier monitoring
* avoids email configuration

---

# MAILTO variable

We can change recipient:

```bash id="cronmail007"
MAILTO="address@domain.com"
```

inside crontab.

---

# example

```bash id="cronmail008"
MAILTO="admin@example.com"

0 3 * * * /home/mohammad/backup.sh
```

Now:

```text id="cronmail009"
cron emails output to admin@example.com
```

---

# practical steps

Edit crontab:

```bash id="cronmail010"
crontab -e
```

Add test job:

```bash id="cronmail011"
* * * * * ping -c 4 google.com
```

---

# important correction

Your notes contain typo:

```text id="cronmail012"
ll * * * * *
```

Correct syntax:

```bash id="cronmail013"
* * * * * ping -c 4 google.com
```

---

# verifying cron execution

Monitor cron logs:

Ubuntu:

```bash id="cronmail014"
journalctl -f -u cron.service
```

---

# common error

Example log:

```text id="cronmail015"
No MTA installed, discarding output
```

Meaning:

```text id="cronmail016"
cron tried to send email
BUT no mail server exists
```

---

# what is MTA?

MTA:

```text id="cronmail017"
Mail Transfer Agent
```

Software responsible for:

* sending email
* routing mail
* local delivery

---

# common MTAs

| MTA      | Description                  |
| -------- | ---------------------------- |
| postfix  | most common modern Linux MTA |
| sendmail | classic old Unix MTA         |
| exim     | common Debian MTA            |
| qmail    | alternative MTA              |

---

# checking local mail

Local system mail often stored in:

```text id="cronmail018"
/var/mail
```

---

# example

```bash id="cronmail019"
cd /var/mail
```

```bash id="cronmail020"
cat mohammad
```

You may see:

* cron output
* system mail
* local notifications

---

# installing mail support

Common packages:

```bash id="cronmail021"
sudo apt install mailutils
```

or:

```bash id="cronmail022"
sudo apt install postfix
```

---

# after installation

Logs may show:

```text id="cronmail023"
session opened
session closed
```

Meaning:

```text id="cronmail024"
mail delivery attempted successfully
```

---

# configuring postfix

Command:

```bash id="cronmail025"
sudo dpkg-reconfigure postfix
```

---

# common simple setup

Choose:

```text id="cronmail026"
Internet Site
```

This configures:

* basic outbound mail delivery

---

# important practical reality

Local cron email:

```text id="cronmail027"
often works only locally by default
```

Sending to external email addresses:

* Gmail
* Outlook
* company email

usually requires:

* DNS configuration
* SMTP relay
* authentication
* proper server configuration

---

# why external delivery may fail

Common causes:

* ISP blocks port 25
* missing reverse DNS
* spam protections
* incorrect hostname
* missing SPF/DKIM

Very common.

---

# real-world admin approach

Many admins:

```text id="cronmail028"
avoid cron email entirely
```

and instead:

* redirect output to logs
* monitor logs centrally

Example:

```bash id="cronmail029"
0 3 * * * backup.sh >> /var/log/backup.log 2>&1
```

---

# important shell syntax

## stdout only

```bash id="cronmail030"
> file.txt
```

---

# stdout + stderr

```bash id="cronmail031"
>> file.txt 2>&1
```

VERY common production pattern.

---

# important cron debugging technique

If cronjob not working:

* temporarily remove output redirection
* let cron email errors
* inspect logs

Useful for debugging.

---

# useful mail command

Read local mail interactively:

```bash id="cronmail032"
mail
```

May open:

* mailbox interface
* message list

---

# important professional insight

Cron email system is:

```text id="cronmail033"
very old Unix philosophy
```

where:

* programs communicate through text output
* admins receive system notifications automatically

---

# common production alternatives today

Modern systems often use:

* centralized logging
* Prometheus alerts
* Grafana
* Slack notifications
* email APIs
* monitoring systems

instead of classic cron mail.

---

# useful commands summary

Edit cron:

```bash id="cronmail034"
crontab -e
```

Monitor cron logs:

```bash id="cronmail035"
journalctl -f -u cron.service
```

Check local mail:

```bash id="cronmail036"
cd /var/mail
```

Read mailbox:

```bash id="cronmail037"
mail
```

Configure postfix:

```bash id="cronmail038"
sudo dpkg-reconfigure postfix
```

Install mail tools:

```bash id="cronmail039"
sudo apt install mailutils
```

MAILTO example:

```bash id="cronmail040"
MAILTO="admin@example.com"
```

Redirect output to file:

```bash id="cronmail041"
command >> logfile.txt 2>&1
```
