# 292. The `flock` Command: Ensuring Data Consistency through File Locking

## problem

Sometimes a scheduled task may start again before the previous run has finished.

Example:

```text
cron runs script every 2 minutes
but script needs 5 minutes to finish
```

Result:

* multiple copies run at the same time
* database overload
* duplicate processing
* corrupted output files
* inconsistent backups

---

# solution: `flock`

`flock` is used to:

```text
lock a file while a command is running
```

Only one process can hold the lock at a time.

---

# basic syntax

```bash
flock lockfile command
```

Example:

```bash
flock file.txt ping google.com
```

Meaning:

* `file.txt` is used as the lock file
* while `ping` is running, the lock is held
* another command using the same lock file must wait

---

# example with two terminals

## terminal 1

```bash
flock wait.txt ping google.com
```

This starts ping and locks:

```text
wait.txt
```

---

## terminal 2

Run the same:

```bash
flock wait.txt ping google.com
```

This command waits until terminal 1 releases the lock.

---

# non-blocking mode

If you do NOT want the second command to wait:

```bash
flock -n wait.txt ping google.com
```

Meaning:

* try to acquire lock
* if lock is already taken, exit immediately

---

# exit code with `-E`

```bash
flock -n -E 0 wait.txt ping google.com
```

Meaning:

* `-n` = do not wait
* `-E 0` = if lock cannot be acquired, exit with code `0`

This is useful in cron because:

* skipped run is not treated as an error

---

# why this matters in cron

Cron does not know if the previous job is still running.

Example:

```bash
*/2 * * * * /home/mohammad/backup.sh
```

If backup takes 10 minutes:

* after 2 minutes another backup starts
* then another
* then another

Bad.

---

# cron with flock

Better:

```bash
*/2 * * * * flock -n /tmp/backup.lock /home/mohammad/backup.sh
```

Now:

* only one backup runs at a time
* overlapping jobs are skipped

---

# real example from your note

```bash
00 */2 * * * /usr/bin/flock -n -E 0 /usr/home/codingij/.tmp/234534345fa84.lck /usr/bin/php80 /usr/www/users/codingij/my-project/artisan schedule:run
```

---

# explanation

```text
00 */2 * * *
```

run every 2 hours.

---

```text
/usr/bin/flock
```

use the full path to `flock`.

Good practice in cron.

---

```text
-n
```

do not wait if another instance is running.

---

```text
-E 0
```

return exit code `0` when lock fails.

This prevents cron from treating the skipped execution as failure.

---

```text
/usr/home/codingij/.tmp/234534345fa84.lck
```

lock file.

Only one process can hold this lock.

---

```text
/usr/bin/php80
```

PHP executable.

---

```text
/usr/www/users/codingij/my-project/artisan schedule:run
```

Laravel scheduler command.

---

# why the command is complicated

Because in production we need:

* absolute paths
* no overlapping execution
* safe exit code
* reliable cron behavior
* controlled database/background tasks

---

# real-world use case

Laravel often uses:

```bash
php artisan schedule:run
```

If two scheduler processes run at same time:

* duplicate jobs may start
* emails may be sent twice
* database cleanup may overlap
* queue tasks may conflict

`flock` prevents this.

---

# why file locking protects data

Suppose one script is cleaning database rows.

If another script starts at the same time:

* both may read same data
* both may delete/update same rows
* database load increases
* results may become inconsistent

Locking ensures:

```text
one critical task at a time
```

---

# important note

The lock file does not need to contain important data.

It is usually just a marker file.

Common locations:

```text
/tmp/myjob.lock
/var/lock/myjob.lock
/home/user/.tmp/myjob.lock
```

---

# useful commands summary

Blocking lock:

```bash
flock wait.txt ping google.com
```

Non-blocking lock:

```bash
flock -n wait.txt ping google.com
```

Non-blocking with success exit when skipped:

```bash
flock -n -E 0 wait.txt ping google.com
```

Cron example:

```bash
*/5 * * * * flock -n /tmp/myjob.lock /home/mohammad/script.sh
```

Laravel scheduler example:

```bash
* * * * * /usr/bin/flock -n -E 0 /tmp/laravel-schedule.lock /usr/bin/php /var/www/app/artisan schedule:run
```
