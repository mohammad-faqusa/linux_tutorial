# 364. PHP on Ubuntu

## How Does PHP Work with Apache on Ubuntu?

### Overview

Unlike CentOS, Ubuntu typically integrates PHP directly into Apache using a module.

Architecture:

```text id="m95kvi"
Browser
    │
    ▼
Apache
    │
    ▼
PHP Module
    │
    ▼
PHP Script
```

In this setup:

* Apache receives the request.
* Apache executes the PHP code itself.
* The generated output is returned to the browser.

---

## Apache Module Approach

Ubuntu commonly uses:

```text id="d6wcvn"
libapache2-mod-php
```

This package installs the PHP module for Apache.

---

## Advantages

### Simpler Architecture

```text id="w3c3ld"
Browser
    │
    ▼
Apache + PHP Module
```

No separate PHP-FPM service is required.

---

### Slightly Lower Overhead

Because PHP runs inside Apache:

```text id="v85vyu"
Apache
   │
Execute PHP Directly
```

there is no communication between two separate processes.

This can result in slightly better performance for small workloads.

---

## Disadvantages

### Less Isolation

PHP runs inside Apache worker processes.

Architecture:

```text id="wklhmu"
Apache Worker
      │
      ▼
PHP Code
```

compared to CentOS:

```text id="p9clcf"
Apache
   │
   ▼
PHP-FPM
```

which provides better process separation.

---

# Creating a PHP Test Page

Navigate to the default website directory:

```bash id="z4yk9x"
cd /var/www/html
```

Create a PHP file:

```bash id="e8m4o7"
nano phpinfo.php
```

---

## Add PHP Code

```php id="6qegdi"
<?php
phpinfo();
?>
```

Save the file.

---

# Verify File Ownership

List files:

```bash id="qv7zht"
ls -al
```

Example:

```text id="zl5jhf"
-rw-r--r-- 1 mohammad mohammad phpinfo.php
```

---

## Change Ownership (If Needed)

Sometimes Apache cannot access files because of ownership issues.

Example:

```bash id="k6f3s7"
sudo chown www-data:www-data phpinfo.php
```

or:

```bash id="m6k57o"
sudo chown -R www-data:www-data /var/www/html
```

### Explanation

```text id="5jjd4l"
www-data
```

is the default Apache user on Ubuntu.

---

# Testing PHP

Open:

```text id="4k4gpi"
http://localhost/phpinfo.php
```

or

```text id="gssmr9"
http://server-ip/phpinfo.php
```

---

## Expected Result

You should see a large PHP information page containing:

* PHP version
* Extensions
* Configuration values
* Environment information

Example:

```text id="hh5klo"
PHP Version 8.x.x
```

---

# Common Problem

## PHP Code Is Displayed Instead of Executed

Suppose the browser shows:

```text id="8w0t5o"
<?php phpinfo(); ?>
```

instead of the PHP information page.

This means Apache is serving the file as plain text and is not processing PHP.

---

## Cause

The PHP module is not enabled.

---

# Enable the PHP Module

Example for PHP 8.1:

```bash id="g3myns"
sudo a2enmod php8.1
```

This creates a symlink in:

```text id="3phf5t"
/etc/apache2/mods-enabled/
```

allowing Apache to load the PHP module.

---

# Apache Multi-Processing Modules (MPM)

Apache can use different Multi-Processing Modules.

Common examples:

```text id="y9d8jk"
mpm_event
mpm_worker
mpm_prefork
```

---

## mpm_event

Modern and efficient.

```text id="w1pg4d"
High Performance
Low Memory Usage
```

However, traditional mod_php cannot run with it.

---

## mpm_prefork

Creates a separate process for each request.

```text id="vkz6xn"
One Request
      ↓
One Process
```

Required by many PHP module configurations.

---

# Disable mpm_event

If Apache reports conflicts:

```bash id="8v7lhx"
sudo a2dismod mpm_event
```

---

# Enable mpm_prefork

```bash id="d7i3hd"
sudo a2enmod mpm_prefork
```

---

# Enable PHP Again

```bash id="6jlwm0"
sudo a2enmod php8.1
```

---

# Restart Apache

Apply the changes:

```bash id="wqhjw4"
sudo systemctl restart apache2.service
```

---

# Verify Loaded Modules

Display loaded modules:

```bash id="5stjnq"
apache2ctl -M
```

Look for:

```text id="xyc9o5"
php_module
```

and:

```text id="h4x4ii"
mpm_prefork_module
```

---

# Request Flow

When a browser requests:

```text id="7mp1pa"
http://localhost/phpinfo.php
```

Apache performs:

```text id="cav4lm"
Browser
    │
    ▼
Apache
    │
    ▼
PHP Module
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

# Useful Commands

### Enable PHP Module

```bash id="x6md6m"
sudo a2enmod php8.1
```

### Disable Event MPM

```bash id="09chdm"
sudo a2dismod mpm_event
```

### Enable Prefork MPM

```bash id="qmcl7o"
sudo a2enmod mpm_prefork
```

### Restart Apache

```bash id="d99g7l"
sudo systemctl restart apache2.service
```

### List Loaded Modules

```bash id="c6mb0s"
apache2ctl -M
```

---

# Ubuntu vs CentOS PHP Architecture

| Ubuntu                 | CentOS               |
| ---------------------- | -------------------- |
| mod_php                | PHP-FPM              |
| PHP inside Apache      | Separate PHP service |
| Slightly less overhead | Better isolation     |
| Simpler setup          | More flexible        |

---

## Important Takeaway

Ubuntu commonly executes PHP using:

```text id="j4dy7x"
mod_php
```

which runs PHP directly inside Apache worker processes.

Typical setup:

```text id="v8mpa2"
Apache
    +
PHP Module
```

If PHP code appears in the browser instead of executing:

1. Enable the PHP module:

```bash id="jlwm17"
sudo a2enmod php8.1
```

2. Disable `mpm_event`:

```bash id="jlwm24"
sudo a2dismod mpm_event
```

3. Enable `mpm_prefork`:

```bash id="jlwm31"
sudo a2enmod mpm_prefork
```

4. Restart Apache:

```bash id="jlwm38"
sudo systemctl restart apache2.service
```

Then test using:

```php id="jlwm45"
<?php
phpinfo();
?>
```

to verify that PHP is correctly integrated with Apache.
