# 362. How Do Apache Log Files Work?

## Why Do We Need Log Files?

Apache records information about incoming requests and server errors.

Log files are essential for:

* Troubleshooting problems
* Monitoring visitors
* Security analysis
* Performance monitoring
* Debugging web applications

---

## Types of Apache Logs

Apache primarily uses two types of logs:

### Access Log

Records:

* Who accessed the server
* Which file was requested
* When it was requested
* HTTP status code
* Browser information

Example:

```text id="8j6nqj"
192.168.1.5 - - [01/Jun/2026:10:30:15]
"GET /index.html HTTP/1.1" 200
```

---

### Error Log

Records:

* Configuration errors
* Missing files
* Permission issues
* Application errors

Example:

```text id="h0r7ng"
File does not exist:
/var/www/html/test.html
```

---

# VirtualHost Log Configuration

Open your VirtualHost:

```bash
cd /etc/httpd/conf.d

sudo nano centos.local.conf
```

Example:

```apache
<VirtualHost *:80>

    ServerName centos.local

    DocumentRoot /var/www/html/centos.local

    ErrorLog logs/centos.local-error.log
    CustomLog logs/centos.local-access.log combined

</VirtualHost>
```

---

## ErrorLog

```apache
ErrorLog logs/centos.local-error.log
```

Stores:

* Apache errors
* PHP errors
* Missing files
* Permission problems

---

## CustomLog

```apache
CustomLog logs/centos.local-access.log combined
```

Stores:

* Visitor requests
* Response codes
* Client IP addresses
* Requested URLs

---

# Viewing Log Files

Display the access log:

```bash
cat /var/log/httpd/centos.local-access.log
```

---

Display the error log:

```bash
cat /var/log/httpd/centos.local-error.log
```

---

## Monitor Logs in Real Time

A very common administration technique:

```bash
tail -f /var/log/httpd/centos.local-access.log
```

Open a browser and visit:

```text
http://centos.local
```

You will immediately see a new log entry.

---

Monitor the error log:

```bash
tail -f /var/log/httpd/centos.local-error.log
```

---

# Generating Log Entries

Visit:

```text
http://centos.local
```

Example access log:

```text
192.168.1.100 - - [01/Jun/2026:12:00:15]
"GET / HTTP/1.1" 200
```

---

Request a missing file:

```text
http://centos.local/missing.html
```

Example access log:

```text
192.168.1.100 - - [01/Jun/2026:12:01:20]
"GET /missing.html HTTP/1.1" 404
```

---

Example error log:

```text
File does not exist:
/var/www/html/centos.local/missing.html
```

---

# Log Formats

Apache allows customization of access log entries through:

```apache
LogFormat
```

definitions.

These are typically found in:

```bash
sudo nano /etc/httpd/conf/httpd.conf
```

---

## Example

```apache
LogFormat "%h %l %u %t \"%r\" %>s %b" common
```

The final word:

```text
common
```

is the format name.

---

# Common Log Variables

## %h

```apache
%h
```

Remote host (client IP address).

Example:

```text
192.168.1.100
```

---

## %t

```apache
%t
```

Time of the request.

Example:

```text
[01/Jun/2026:12:05:00]
```

---

## %r

```apache
%r
```

Full HTTP request line.

Example:

```text
GET /index.html HTTP/1.1
```

---

## %>s

```apache
%>s
```

HTTP response status code.

Examples:

```text
200
404
500
```

---

## %b

```apache
%b
```

Response size in bytes.

Example:

```text
2048
```

---

## %u

```apache
%u
```

Authenticated username (if authentication is enabled).

Example:

```text
mohammad
```

---

# Example Log Entry Analysis

Example:

```text
192.168.1.100 - - [01/Jun/2026:12:15:00]
"GET /index.html HTTP/1.1" 200 512
```

Meaning:

| Field           | Meaning        |
| --------------- | -------------- |
| 192.168.1.100   | Client IP      |
| 01/Jun/2026     | Time           |
| GET /index.html | Requested file |
| 200             | Success        |
| 512             | Bytes returned |

---

# Common HTTP Status Codes in Logs

| Code | Meaning               |
| ---- | --------------------- |
| 200  | Success               |
| 301  | Redirect              |
| 302  | Temporary Redirect    |
| 403  | Forbidden             |
| 404  | File Not Found        |
| 500  | Internal Server Error |

---

# Log File Locations

### CentOS

Access logs:

```bash
/var/log/httpd/
```

Examples:

```text
access_log
error_log
centos.local-access.log
centos.local-error.log
```

---

### Ubuntu

Access logs:

```bash
/var/log/apache2/
```

Examples:

```text
access.log
error.log
```

---

# Useful Commands

View entire log:

```bash
cat logfile
```

---

View last lines:

```bash
tail logfile
```

---

Monitor continuously:

```bash
tail -f logfile
```

---

Search for errors:

```bash
grep 404 logfile
```

---

Search for an IP:

```bash
grep 192.168.1.100 logfile
```

---

# Request Flow

```text
Browser Request
       ↓
Apache Receives Request
       ↓
Access Log Entry Created
       ↓
Process Request
       ↓
Success or Error
       ↓
Error Log Entry (if needed)
```

---

## Important Takeaway

Apache uses two primary log types:

### Access Log

```apache
CustomLog
```

Records:

* Visitors
* URLs
* Status codes
* Requests

---

### Error Log

```apache
ErrorLog
```

Records:

* Missing files
* Permission problems
* Configuration errors
* Application failures

Monitoring these logs is one of the most important skills when troubleshooting Apache web servers.
