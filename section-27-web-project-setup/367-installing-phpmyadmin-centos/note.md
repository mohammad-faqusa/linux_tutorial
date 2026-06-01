# 367. Installing phpMyAdmin [CentOS]

## What Is phpMyAdmin?

### Overview

phpMyAdmin is a web-based MySQL administration tool written in PHP.

Instead of managing databases from the command line:

```bash
mysql -u admin -p
```

you can manage them through a browser.

---

## What Can phpMyAdmin Do?

Common tasks include:

* Create databases
* Delete databases
* Create tables
* Execute SQL queries
* Manage users
* Import databases
* Export backups

Architecture:

```text
Browser
    │
    ▼
phpMyAdmin
    │
    ▼
MySQL Server
```

---

# Installing phpMyAdmin

Install the package:

```bash
sudo dnf install phpmyadmin
```

This installs:

* phpMyAdmin
* PHP dependencies
* Apache configuration files

---

# Apache Configuration

After installation, phpMyAdmin adds a configuration file to:

```bash
/etc/httpd/conf.d
```

Navigate to the directory:

```bash
cd /etc/httpd/conf.d
```

You should see:

```text
phpMyAdmin.conf
```

---

## Open the Configuration

```bash
sudo nano phpMyAdmin.conf
```

Example configuration:

```apache
Alias /phpMyAdmin /usr/share/phpMyAdmin

Alias /phpmyadmin /usr/share/phpMyAdmin
```

---

# What Does Alias Mean?

Without an alias:

```text
http://server/phpmyadmin
```

would make Apache search for:

```text
/var/www/html/phpmyadmin
```

---

With:

```apache
Alias /phpmyadmin /usr/share/phpMyAdmin
```

Apache maps:

```text
http://server/phpmyadmin
```

to:

```text
/usr/share/phpMyAdmin
```

where the phpMyAdmin application is installed.

---

# Security Restriction

By default, CentOS often restricts phpMyAdmin access.

Example:

```apache
<Directory /usr/share/phpMyAdmin>
    Require local
</Directory>
```

---

## What Does Require local Mean?

```text
Only localhost may access phpMyAdmin
```

Allowed:

```text
127.0.0.1
localhost
```

Blocked:

```text
192.168.1.100
10.0.0.50
Internet users
```

---

# Accessing phpMyAdmin

From the server itself:

```text
http://localhost/phpmyadmin
```

or

```text
http://localhost/phpMyAdmin
```

depending on the configured alias.

---

## Login

Use the MySQL credentials created previously:

```text
Username: admin
Password: admin
```

(or your own password)

After login, phpMyAdmin displays:

* Databases
* Tables
* SQL editor
* User management

---

# Accessing Remotely

Suppose your server IP is:

```text
192.168.1.15
```

You may try:

```text
http://192.168.1.15/phpmyadmin
```

However, access will usually be denied because of:

```apache
Require local
```

---

## Allow a Specific Network

Example:

```apache
<Directory /usr/share/phpMyAdmin>
    Require ip 192.168.1.0/24
</Directory>
```

This allows:

```text
192.168.1.1 - 192.168.1.254
```

to access phpMyAdmin.

---

## Allow Everyone (Not Recommended)

```apache
<Directory /usr/share/phpMyAdmin>
    Require all granted
</Directory>
```

This exposes phpMyAdmin to anyone who can reach the server.

⚠️ This is generally not recommended on production systems.

---

# Firewall Considerations

Even if Apache allows access, the firewall may still block incoming connections.

Verify HTTP access:

```bash
sudo firewall-cmd --list-services
```

Expected:

```text
http https
```

---

Allow HTTP if needed:

```bash
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
```

---

# Restart Apache

After modifying the configuration:

```bash
sudo httpd -t
```

Expected:

```text
Syntax OK
```

Restart Apache:

```bash
sudo systemctl restart httpd.service
```

---

# Common Problems

## 403 Forbidden

Cause:

```apache
Require local
```

or restrictive access rules.

---

## 404 Not Found

Cause:

* phpMyAdmin package not installed.
* Alias missing.
* Configuration file not loaded.

Check:

```bash
ls /etc/httpd/conf.d
```

---

## PHP Source Code Appears

Instead of a login page, you see:

```php
<?php
...
?>
```

Cause:

* PHP is not configured correctly.
* PHP-FPM is not running.

Check:

```bash
systemctl status php-fpm.service
```

---

# Useful Commands

### Install phpMyAdmin

```bash
sudo dnf install phpmyadmin
```

### View Configuration

```bash
sudo nano /etc/httpd/conf.d/phpMyAdmin.conf
```

### Test Apache Configuration

```bash
sudo httpd -t
```

### Restart Apache

```bash
sudo systemctl restart httpd.service
```

### Check PHP-FPM

```bash
systemctl status php-fpm.service
```

---

# Request Flow

```text
Browser
    │
    ▼
http://server/phpmyadmin
    │
    ▼
Apache Alias
    │
    ▼
/usr/share/phpMyAdmin
    │
    ▼
PHP-FPM Executes PHP
    │
    ▼
MySQL Server
    │
    ▼
Browser
```

---

## Security Recommendation

For production systems:

* Restrict access by IP.
* Use strong MySQL passwords.
* Enable HTTPS.
* Avoid exposing phpMyAdmin directly to the Internet.
* Consider VPN-only access.

A compromised phpMyAdmin installation often means complete database compromise.

---

## Important Takeaway

Install:

```bash
sudo dnf install phpmyadmin
```

Configuration is usually stored in:

```bash
/etc/httpd/conf.d/phpMyAdmin.conf
```

The key directive is:

```apache
Alias /phpmyadmin /usr/share/phpMyAdmin
```

which maps:

```text
http://server/phpmyadmin
```

to the installed phpMyAdmin application.

By default, access is often restricted to:

```apache
Require local
```

meaning only users on the local machine can access phpMyAdmin unless additional Apache and firewall rules are configured.
