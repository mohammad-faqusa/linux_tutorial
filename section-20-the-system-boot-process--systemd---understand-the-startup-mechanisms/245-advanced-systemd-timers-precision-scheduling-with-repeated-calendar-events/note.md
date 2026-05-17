## 245. Advanced systemd Timers: Precision Scheduling with Repeated Calendar Events

### calendar events in systemd timers

* `systemd` timers can use calendar-based scheduling
* this allows services to run at specific times
* similar idea to `cron`, but integrated with `systemd`

---

## OnCalendar

used inside the `[Timer]` section:

```ini id="cal001"
OnCalendar=...
```

example:

```ini id="cal002"
OnCalendar=*-*-* *:0,15,30,45
```

meaning:

* every day
* every hour
* at minutes:

  * `00`
  * `15`
  * `30`
  * `45`

so the service runs every 15 minutes.

---

## calendar format

general form:

```text id="cal003"
DayOfWeek Year-Month-Day Hour:Minute:Second
```

example:

```text id="cal004"
*-*-* *:0,15,30,45
```

breakdown:

```text id="cal005"
*-*-*        any year, any month, any day
*            any hour
0,15,30,45   selected minutes
```

---

## check current timestamp format

```bash id="cal006"
systemd-analyze timestamp now
```

shows how `systemd` understands current time.

---

## analyze calendar expression

```bash id="cal007"
systemd-analyze calendar '*-*-* *:0,15,30,45'
```

this shows:

* normalized expression
* next elapse time
* time left until next run

---

## edit the timer

```bash id="cal008"
sudo systemctl edit --full my-network-log.timer
```

replace:

```ini id="cal009"
OnActiveSec=1min
```

with:

```ini id="cal010"
OnCalendar=*-*-* *:0,15,30,45
```

---

## full timer example

```ini id="cal011"
[Unit]
Description=Run the network logging service every 15 minutes

[Timer]
OnCalendar=*-*-* *:0,15,30,45
AccuracySec=1sec
Unit=my-network-log.service

[Install]
WantedBy=timers.target
```

---

## reload systemd

```bash id="cal012"
sudo systemctl daemon-reload
```

---

## important: restart the timer

after changing the timer configuration:

```bash id="cal013"
sudo systemctl stop my-network-log.timer
sudo systemctl start my-network-log.timer
```

or:

```bash id="cal014"
sudo systemctl restart my-network-log.timer
```

---

## why list-timers may show N/A

after editing an already active timer, you may see:

```text id="cal015"
NEXT  n/a
LEFT  n/a
```

because:

* timer was already loaded with old configuration
* new schedule has not been activated yet

solution:

```bash id="cal016"
sudo systemctl restart my-network-log.timer
```

---

## inspect timers

```bash id="cal017"
systemctl list-timers
```

show all timers:

```bash id="cal018"
systemctl list-timers --all
```

---

## check timer status

```bash id="cal019"
systemctl status my-network-log.timer
```

---

## view logs

service logs:

```bash id="cal020"
journalctl -u my-network-log.service
```

timer logs:

```bash id="cal021"
journalctl -u my-network-log.timer
```

---

## common OnCalendar examples

every minute:

```ini id="cal022"
OnCalendar=*-*-* *:*:00
```

---

every 15 minutes:

```ini id="cal023"
OnCalendar=*-*-* *:0,15,30,45
```

---

every hour:

```ini id="cal024"
OnCalendar=hourly
```

---

daily:

```ini id="cal025"
OnCalendar=daily
```

---

every day at 02:30:

```ini id="cal026"
OnCalendar=*-*-* 02:30:00
```

---

every Monday at 09:00:

```ini id="cal027"
OnCalendar=Mon *-*-* 09:00:00
```

---

first day of every month:

```ini id="cal028"
OnCalendar=*-*-01 00:00:00
```

---

## systemd-analyze calendar examples

```bash id="cal029"
systemd-analyze calendar 'daily'
```

```bash id="cal030"
systemd-analyze calendar 'Mon *-*-* 09:00:00'
```

```bash id="cal031"
systemd-analyze calendar '*-*-* *:0,15,30,45'
```

---

## useful commands summary

edit timer:

```bash id="cal032"
sudo systemctl edit --full my-network-log.timer
```

reload:

```bash id="cal033"
sudo systemctl daemon-reload
```

restart timer:

```bash id="cal034"
sudo systemctl restart my-network-log.timer
```

list timers:

```bash id="cal035"
systemctl list-timers
```

analyze calendar:

```bash id="cal036"
systemd-analyze calendar '*-*-* *:0,15,30,45'
```

check status:

```bash id="cal037"
systemctl status my-network-log.timer
```
