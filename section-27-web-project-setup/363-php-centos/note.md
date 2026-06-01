# 363. PHP on CentOS

## Why Do We Need PHP?

Apache can serve static files such as:

* HTML
* CSS
* JavaScript
* Images

However, for dynamic web applications, we need a server-side programming language.

One of the most popular choices is:

```text
PHP
```

PHP allows us to:

* Generate dynamic HTML
* Process forms
* Connect to databases
* Build web applications
* Create APIs

---

## Apache and PHP

### The Problem

Apache is a web server.

PHP is a scripting language.

Apache cannot execute PHP code by itself.

Example:

```php
<?php
echo "Hello World";
?>
```

Apache needs a mechanism to execute this code and return the result to the client.

---

## PHP on CentOS

On CentOS, PHP is usually integrated using:

```text
PHP-FPM
```

---

## What Is PHP-FPM?

PHP-FPM stands for:

```text
PHP FastCGI Process Manager
```

It is a separate service responsible for executing PHP scripts.

Architecture:

```text
Browser
    │
    ▼
Apache
    │
    ▼
PHP-FPM
    │
    ▼
PHP Script
```

---

## Why Use PHP-FPM?

Instead of embedding PHP directly into Apache, PHP runs in a separate service.

Benefits:

### Better SELinux Integration

PHP-FPM works very well with SELinux security policies.

---

### Process Isolation

Apache and PHP run as separate processes.

Example:

```text
Apache Process
        │
        ▼
PHP-FPM Process
```

This improves security and flexibility.

---

### Different Users and Groups

PHP-FPM can run scripts as different users.

This is useful for:

* Shared hosting
* Multiple websites
* Security isolation

---

## Disadvantage

Communication is required between:

```text
Apache
   ↔
PHP-FPM
```

This introduces a small amount of overhead.

However, on modern systems this overhead is usually negligible.

---

# Verify PHP-FPM

Check whether the service is running:

```bash
systemctl status php-fpm.service
```

Expected result:

```text
active (running)
```

---

## Start PHP-FPM

If necessary:

```bash
sudo systemctl enable --now php-fpm.service
```

---

# Testing PHP

Suppose our VirtualHost uses:

```text
/var/www/html/centos.local
```

as its DocumentRoot.

---

## Create a PHP File

Navigate to the website directory:

```bash
cd /var/www/html/centos.local
```

Create:

```bash
sudo nano phpinfo.php
```

---

## Add the Following Code

```php
<?php
phpinfo();
?>
```

---

## What Does phpinfo() Do?

The function:

```php
phpinfo();
```

displays information about:

* PHP version
* Loaded modules
* Configuration settings
* Extensions
* Environment variables

It is commonly used to verify that PHP is working correctly.

---

# Open the File in a Browser

Visit:

```text
http://centos.local/phpinfo.php
```

or

```text
http://server-ip/phpinfo.php
```

---

## Expected Result

You should see a large PHP information page containing:

```text
PHP Version
System Information
Loaded Extensions
Configuration Values
```

Example:

```text
PHP Version 8.x.x
```

---

# Request Flow

When the browser requests:

```text
http://centos.local/phpinfo.php
```

the following occurs:

```text
Browser
    │
    ▼
Apache
    │
    ▼
PHP-FPM
    │
    ▼
Execute phpinfo()
    │
    ▼
Generate HTML
    │
    ▼
Browser
```

---

# Verify PHP-FPM Is Being Used

Check running processes:

```bash
ps aux | grep php-fpm
```

Example output:

```text
php-fpm: master process
php-fpm: pool www
php-fpm: pool www
```

This confirms that PHP-FPM is handling PHP requests.

---

# Common Troubleshooting

## PHP File Downloads Instead of Executing

If visiting:

```text
http://centos.local/phpinfo.php
```

downloads the file instead of displaying PHP output:

```text
phpinfo.php downloaded
```

Apache is not properly configured to pass PHP files to PHP-FPM.

---

## PHP-FPM Not Running

Check:

```bash
systemctl status php-fpm.service
```

Start it:

```bash
sudo systemctl start php-fpm.service
```

---

## Check Apache Logs

```bash
tail -f /var/log/httpd/error_log
```

or

```bash
journalctl -u httpd.service -f
```

---

# Security Note

The `phpinfo()` page exposes a large amount of information about the server.

After testing PHP successfully:

```bash
sudo rm phpinfo.php
```

or restrict access to it.

Leaving it publicly accessible is not recommended on production servers.

---

## Important Takeaway

On CentOS, PHP is typically executed through:

```text
PHP-FPM
(PHP FastCGI Process Manager)
```

Architecture:

```text
Browser
    │
    ▼
Apache
    │
    ▼
PHP-FPM
    │
    ▼
PHP Script
```

Useful commands:

```bash
systemctl status php-fpm.service
```

```bash
systemctl enable --now php-fpm.service
```

Test PHP with:

```php
<?php
phpinfo();
?>
```

and open:

```text
http://server/phpinfo.php
```

to verify that Apache and PHP are correctly integrated.
