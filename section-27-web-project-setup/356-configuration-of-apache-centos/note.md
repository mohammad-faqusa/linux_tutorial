# 356. Apache Configuration on CentOS

## Apache Configuration Directory

The main Apache configuration files are located in:

```bash
/etc/httpd
```

Navigate to the directory:

```bash
cd /etc/httpd
```

Directory structure:

```text
/etc/httpd
├── conf/
├── conf.d/
├── conf.modules.d/
├── logs/
└── modules/
```

---

# Main Configuration File

Navigate to:

```bash
cd /etc/httpd/conf
```

Open the main configuration file:

```bash
sudo nano httpd.conf
```

This is the primary Apache configuration file.

Most Apache settings originate from this file.

---

# Important Directives in httpd.conf

## ServerRoot

Defines Apache's root directory.

Example:

```apache
ServerRoot "/etc/httpd"
```

Apache uses this directory as a reference point for many relative paths.

---

## Listen

Defines which network ports Apache listens on.

Example:

```apache
Listen 80
```

Meaning:

```text
Apache accepts HTTP requests on port 80
```

---

### HTTPS Support

To enable HTTPS:

```apache
Listen 443
```

Meaning:

```text
Apache accepts HTTPS requests on port 443
```

Typically, additional SSL configuration is also required.

---

## Load Modules

Apache uses a modular architecture.

In `httpd.conf` you will find:

```apache
Include conf.modules.d/*.conf
```

Meaning:

```text
Load all configuration files
from conf.modules.d
```

This is how Apache loads its modules.

---

# Apache Modules

Navigate to:

```bash
cd /etc/httpd/conf.modules.d
```

Example files:

```text
00-base.conf
00-mpm.conf
00-systemd.conf
10-php.conf
brotli.conf
ssl.conf
```

---

## 00-base.conf

Loads fundamental Apache modules.

Examples:

* Authentication modules
* Logging modules
* MIME modules

Without these modules, Apache cannot function properly.

---

## Brotli Module

Example file:

```text
brotli.conf
```

Purpose:

```text
Compress HTTP responses
```

Benefits:

* Smaller responses
* Faster page loading
* Reduced bandwidth usage

Example:

```text
100 KB HTML
       ↓
Brotli Compression
       ↓
25 KB HTML
```

Visitors receive pages faster.

---

## Shared Object Files (.so)

Modules are typically implemented as:

```text
.so
```

files.

Example:

```text
mod_ssl.so
mod_php.so
mod_brotli.so
```

These are dynamically loaded by Apache during startup.

---

# ServerName

Inside `httpd.conf`:

```apache
ServerName mohammad.local:80
```

Purpose:

* Defines the server's hostname.
* Eliminates startup warnings.
* Helps Apache identify itself.

Example:

```apache
ServerName localhost
```

or

```apache
ServerName mohammad.local:80
```

---

# Directory Configuration

Apache controls access through:

```apache
<Directory>
```

blocks.

Example:

```apache
<Directory "/var/www/html">
    Require all granted
</Directory>
```

---

## Why Use Directory Blocks?

Directory blocks control:

* Access permissions
* Authentication
* Security settings
* Allowed features

---

## Example: Deny Access

```apache
<Directory "/secret">
    Require all denied
</Directory>
```

Result:

```text
403 Forbidden
```

Visitors cannot access the directory.

---

# DocumentRoot

One of the most important settings.

Example:

```apache
DocumentRoot "/var/www/html"
```

Meaning:

```text
URL
 ↓
Maps To
 ↓
/var/www/html
```

---

## Example

Request:

```text
http://localhost/index.html
```

Apache searches for:

```text
/var/www/html/index.html
```

---

### Another Example

Request:

```text
http://localhost/folder/test.txt
```

Apache searches for:

```text
/var/www/html/folder/test.txt
```

---

# Logging

Apache records information about requests and errors.

Common log files:

```text
Access Log
Error Log
```

---

## Access Log

Contains:

* Client IP addresses
* Requested URLs
* HTTP methods
* Response codes

Example:

```text
192.168.1.5 GET /index.html 200
```

---

## Error Log

Contains:

* Configuration errors
* Module errors
* Application errors

Example:

```text
File not found
Permission denied
```

---

# IncludeOptional

Near the end of `httpd.conf`:

```apache
IncludeOptional conf.d/*.conf
```

Purpose:

```text
Load additional configuration files
```

from:

```bash
/etc/httpd/conf.d
```

---

## Why Is This Useful?

Additional packages can add configuration without modifying the main file.

Example:

```text
PHP Package
      ↓
Creates php.conf
      ↓
Stored in conf.d/
      ↓
Loaded Automatically
```

---

# Apache Configuration Architecture

```text
httpd.conf
     │
     ├── conf.modules.d/*.conf
     │         │
     │         └── Load Modules
     │
     └── conf.d/*.conf
               │
               └── Additional Configuration
```

---

# Viewing the Configuration Layout

```bash
cd /etc/httpd

tree
```

Example:

```text
conf/
conf.d/
conf.modules.d/
logs/
modules/
```

This helps visualize how Apache organizes its configuration.

---

# Common Commands

### Open Main Configuration

```bash
sudo nano /etc/httpd/conf/httpd.conf
```

### Test Configuration

```bash
sudo httpd -t
```

Expected:

```text
Syntax OK
```

### Restart Apache

```bash
sudo systemctl restart httpd
```

### View Service Status

```bash
sudo systemctl status httpd
```

---

# Important Takeaway

The CentOS Apache configuration is centered around:

```bash
/etc/httpd/conf/httpd.conf
```

Important directives include:

| Directive       | Purpose                        |
| --------------- | ------------------------------ |
| ServerRoot      | Apache root directory          |
| Listen          | Ports Apache listens on        |
| ServerName      | Hostname of the server         |
| DocumentRoot    | Website root directory         |
| Directory       | Access control                 |
| Include         | Load module configurations     |
| IncludeOptional | Load additional configurations |
| Logs            | Request and error logging      |

Apache's modular configuration structure makes it easy to extend functionality while keeping the main configuration file clean and maintainable.
