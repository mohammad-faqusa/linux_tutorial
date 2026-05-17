## 246. Journald and journalctl: Effective System Logging and Analysis

### systemd-journald

* `systemd-journald` is the logging component of `systemd`
* responsible for collecting and managing logs from:

  * kernel
  * services
  * applications
  * boot process
  * stdout/stderr of services

---

## traditional logging vs journald

older Linux systems commonly used:

```text id="jr001"
syslog
rsyslog
syslog-ng
```

`journald` modernizes logging by:

* centralizing logs
* indexing entries
* supporting metadata
* integrating tightly with `systemd`

---

## key features of journald

### binary log format

logs stored in binary format:

* faster indexing
* efficient storage
* structured metadata

logs usually stored under:

```text id="jr002"
/var/log/journal/
```

or temporarily:

```text id="jr003"
/run/log/journal/
```

---

## centralized logging

collects logs from:

* kernel (`dmesg`)
* system services
* applications
* user services
* containers

all accessible via:

```bash id="jr004"
journalctl
```

---

## automatic rotation and retention

journald automatically:

* rotates logs
* limits disk usage
* removes old logs

configuration:

```text id="jr005"
/etc/systemd/journald.conf
```

---

## indexed querying

supports filtering by:

* service
* PID
* user
* time range
* boot session
* identifier

much more powerful than plain text grep

---

## boot logging

journald stores:

* early boot logs
* kernel startup messages
* failed service startup logs

very useful for troubleshooting boot issues

---

# journalctl basic usage

## show all logs

```bash id="jr006"
journalctl
```

shows:

* complete journal history

---

## show current boot logs

```bash id="jr007"
journalctl -b
```

very common troubleshooting command

---

## list all boots

```bash id="jr008"
journalctl --list-boots
```

example:

```text id="jr009"
-2  abcdef...
-1  123456...
 0  987654...
```

---

## inspect older boot

example:

```bash id="jr010"
journalctl -b -1
```

previous boot

or:

```bash id="jr011"
journalctl -b -34
```

specific historical boot index

---

# filtering by unit

## apache logs

```bash id="jr012"
journalctl -u apache2.service
```

---

## custom service logs

```bash id="jr013"
journalctl -u my-network-log.service
```

---

## live service monitoring

```bash id="jr014"
journalctl -u my-network-log.service -f
```

similar to:

```bash id="jr015"
tail -f
```

---

# filtering by time

## since specific time

```bash id="jr016"
journalctl --since "1 hour ago"
```

---

## time range

```bash id="jr017"
journalctl --since "2026-05-17 18:00:00" \
           --until "2026-05-17 19:00:00"
```

---

## today logs

```bash id="jr018"
journalctl --since today
```

---

## recent 10 minutes

```bash id="jr019"
journalctl --since "10 minutes ago"
```

---

# reverse output

newest entries first:

```bash id="jr020"
journalctl -r
```

useful for:

* quickly finding recent errors

---

# follow logs live

```bash id="jr021"
journalctl -f
```

live streaming logs

---

## follow specific service live

```bash id="jr022"
journalctl -u apache2.service -f
```

---

# writing custom messages into journal

## using systemd-cat

```bash id="jr023"
echo 'message' | systemd-cat
```

adds custom message into journal

---

## monitor live

terminal 1:

```bash id="jr024"
journalctl -f
```

terminal 2:

```bash id="jr025"
echo 'hello world' | systemd-cat
```

---

# custom identifier/tag

```bash id="jr026"
echo 'message' | systemd-cat -t 'me'
```

identifier:

```text id="jr027"
me
```

---

## filter by tag

```bash id="jr028"
journalctl -t 'me'
```

follow live:

```bash id="jr029"
journalctl -t 'me' -f
```

---

# useful filtering examples

## kernel logs only

```bash id="jr030"
journalctl -k
```

---

## errors only

```bash id="jr031"
journalctl -p err
```

priorities:

```text id="jr032"
emerg
alert
crit
err
warning
notice
info
debug
```

---

## warnings and above

```bash id="jr033"
journalctl -p warning
```

---

## logs from current user

```bash id="jr034"
journalctl _UID=$(id -u)
```

---

## logs for current boot errors

```bash id="jr035"
journalctl -b -p err
```

---

# persistent logging

sometimes logs disappear after reboot because:

```text id="jr036"
/var/log/journal/
```

does not exist

enable persistence:

```bash id="jr037"
sudo mkdir -p /var/log/journal
sudo systemctl restart systemd-journald
```

---

# disk usage

show journal size:

```bash id="jr038"
journalctl --disk-usage
```

---

# cleanup old logs

remove logs older than 7 days:

```bash id="jr039"
sudo journalctl --vacuum-time=7d
```

limit size:

```bash id="jr040"
sudo journalctl --vacuum-size=500M
```

---

# output formatting

## no pager

```bash id="jr041"
journalctl --no-pager
```

---

## export format

```bash id="jr042"
journalctl -o json
```

other formats:

```text id="jr043"
short
verbose
json
cat
export
```

---

# useful troubleshooting workflow

recent errors:

```bash id="jr044"
journalctl -p err -b
```

service issue:

```bash id="jr045"
journalctl -u nginx.service -f
```

previous boot crash:

```bash id="jr046"
journalctl -b -1
```

kernel issues:

```bash id="jr047"
journalctl -k
```

---

# useful commands summary

show all logs:

```bash id="jr048"
journalctl
```

current boot:

```bash id="jr049"
journalctl -b
```

previous boot:

```bash id="jr050"
journalctl -b -1
```

list boots:

```bash id="jr051"
journalctl --list-boots
```

service logs:

```bash id="jr052"
journalctl -u apache2.service
```

live logs:

```bash id="jr053"
journalctl -f
```

filter by time:

```bash id="jr054"
journalctl --since "1 hour ago"
```

kernel logs:

```bash id="jr055"
journalctl -k
```

send custom log:

```bash id="jr056"
echo 'message' | systemd-cat
```

custom tag:

```bash id="jr057"
echo 'message' | systemd-cat -t 'me'
```

filter by tag:

```bash id="jr058"
journalctl -t 'me'
```
