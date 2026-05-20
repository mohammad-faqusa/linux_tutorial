# 291. Managing Cron Output: Email Notification & `sendmail` Integration [CentOS]

# important cron behavior

Just like Ubuntu:

```text id="centosmail001"
if cronjob generates output
```

then:

* cron attempts to send email

to:

```text id="centosmail002"
owner of the cronjob
```

---

# changing recipient

Inside crontab:

```bash id="centosmail003"
MAILTO="address@domain.com"
```

Example:

```bash id="centosmail004"
MAILTO="mohammad@gmail.com"
```

---

# important difference on CentOS

CentOS often uses:

```text id="centosmail005"
sendmail
```

or compatible mail tools for delivery.

---

# system-wide cron file

CentOS system cronjobs commonly configured in:

```text id="centosmail006"
/etc/crontab
```

---

# important difference from user crontab

## user crontab format

```text id="centosmail007"
minute hour day month weekday command
```

---

# system crontab format

Includes additional field:

```text id="centosmail008"
minute hour day month weekday USER command
```

Example:

```bash id="centosmail009"
* * * * * root ping -c 4 google.com
```

Notice:

```text id="centosmail010"
extra USER field
```

Very important distinction.

---

# editing system cron

```bash id="centosmail011"
sudo nano /etc/crontab
```

---

# checking cron logs

Example:

```bash id="centosmail012"
sudo journalctl -u crond.service -r
```

Important correction:
CentOS usually uses:

```text id="centosmail013"
crond.service
```

NOT:

```text id="centosmail014"
cron.service
```

---

# installing sendmail

```bash id="centosmail015"
sudo dnf install sendmail
```

Purpose:

* local mail delivery
* outgoing mail support

---

# enabling service

```bash id="centosmail016"
sudo systemctl enable --now sendmail.service
```

Meaning:

* start immediately
* auto-start on boot

---

# rebooting

```bash id="centosmail017"
sudo reboot
```

sometimes used after:

* mail configuration
* service installation

though not always required.

---

# local mail delivery

Even without internet delivery:

```text id="centosmail018"
sendmail can deliver mail locally
```

Examples:

* root user
* local Linux accounts

Useful for:

* cron output
* system alerts
* local notifications

---

# important real-world limitation

Sending mail to:

```text id="centosmail019"
mohammad@gmail.com
```

may STILL fail unless:

* DNS configured
* public server
* SMTP relay configured
* anti-spam requirements satisfied

Same issue discussed previously.

---

# important distinction

## local delivery

Usually works:

```text id="centosmail020"
Linux user → Linux mailbox
```

---

# internet delivery

Much harder:

```text id="centosmail021"
Linux server → Gmail
```

Requires:

* trusted infrastructure
* mail reputation
* DNS records
* SMTP correctness

---

# useful testing strategy

For learning:

```text id="centosmail022"
test local mail first
```

Much simpler and more reliable.

---

# local mailbox locations

Often:

```text id="centosmail023"
/var/mail
```

or:

```text id="centosmail024"
/var/spool/mail
```

---

# example

```bash id="centosmail025"
cd /var/mail
```

```bash id="centosmail026"
cat root
```

---

# common cron test

Example cronjob:

```bash id="centosmail027"
* * * * * root echo "hello from cron"
```

Every minute:

* cron runs
* output mailed locally

---

# important professional insight

Historically:

```text id="centosmail028"
cron + sendmail
```

was one of the most important Unix admin workflows.

Admins:

* received nightly reports
* backup failures
* security warnings
* filesystem alerts

through local mail.

---

# why modern systems use alternatives

Today many systems prefer:

* centralized logging
* monitoring dashboards
* Slack alerts
* email APIs

because:

```text id="centosmail029"
internet mail infrastructure became more complex
```

---

# sendmail historical importance

`sendmail` was:

```text id="centosmail030"
one of the most famous Unix mail servers
```

Very powerful:

* but historically difficult to configure.

---

# modern alternatives

More common today:

* postfix
* exim
* cloud mail providers

But:

```text id="centosmail031"
sendmail knowledge still appears in older systems
```

---

# important cron debugging workflow

If cronjob seems broken:

## Step 1

Check cron service:

```bash id="centosmail032"
systemctl status crond
```

---

# Step 2

Inspect logs:

```bash id="centosmail033"
journalctl -u crond.service
```

---

# Step 3

Check mailboxes:

```bash id="centosmail034"
cd /var/mail
```

---

# Step 4

Test command manually.

Very important:

```text id="centosmail035"
if command fails manually, cron will also fail
```

---

# common cron mail problem

Cronjob produces:

```text id="centosmail036"
huge endless output
```

Can:

* fill mailbox
* consume disk space

Thus many admins redirect output:

```bash id="centosmail037"
command >> logfile.txt 2>&1
```

---

# useful commands summary

Edit system cron:

```bash id="centosmail038"
sudo nano /etc/crontab
```

Install sendmail:

```bash id="centosmail039"
sudo dnf install sendmail
```

Enable service:

```bash id="centosmail040"
sudo systemctl enable --now sendmail.service
```

Check cron logs:

```bash id="centosmail041"
journalctl -u crond.service
```

Check local mail:

```bash id="centosmail042"
cd /var/mail
```

Set recipient:

```bash id="centosmail043"
MAILTO="mohammad@gmail.com"
```

Redirect output:

```bash id="centosmail044"
command >> logfile.txt 2>&1
```
