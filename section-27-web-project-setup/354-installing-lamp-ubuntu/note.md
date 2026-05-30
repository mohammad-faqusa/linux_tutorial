# 354. Installing LAMP on Ubuntu

## Important: Remove Third-Party PHP Installations

### Why?

Ubuntu repositories already provide PHP packages.

If PHP was previously installed from a third-party repository, package conflicts may occur during installation or upgrades.

Common symptoms:

* Dependency conflicts
* Multiple PHP versions installed
* Apache PHP module errors
* Upgrade failures

---

## Remove Third-Party PHP Repositories

Check:

```bash
ls /etc/apt/sources.list.d/
```

Look for PHP-related repositories.

Example:

```text
ondrej-ubuntu-php.list
```

If such repositories exist and are no longer needed, remove them.

---

## Remove Existing PHP Installations

Remove all PHP packages:

```bash
sudo apt remove --purge 'php*'
```

---

## Remove Apache PHP Modules

```bash
sudo apt remove --purge 'libapache2-mod-php*'
```

---

## Clean Unused Dependencies

```bash
sudo apt autoremove
```

---

# Installing the LAMP Components

## Apache

Apache's package name on Ubuntu is:

```text
apache2
```

Apache acts as the web server and handles HTTP/HTTPS requests.

---

## MySQL

### MySQL Server

Package:

```text
mysql-server
```

Installs:

* Database server
* Storage engine
* SQL processing

---

### MySQL Client

Package:

```text
mysql-client
```

Provides command-line tools for connecting to MySQL servers.

Example:

```bash
mysql -u root -p
```

---

## PHP

Package:

```text
php
```

Installs the PHP interpreter.

---

## Apache PHP Module

Package:

```text
libapache2-mod-php
```

Allows Apache to execute PHP files.

Without this module:

```text
Apache
    +
PHP
```

would not be properly integrated.

---

# Installing the Complete LAMP Stack

Install everything using:

```bash
sudo apt update
sudo apt install apache2 mysql-server mysql-client php libapache2-mod-php
```

This installs:

* Apache
* MySQL Server
* MySQL Client
* PHP
* Apache PHP Module

---

# Apache Service

## Systemd Service

When Apache is installed, Ubuntu creates:

```text
apache2.service
```

This service manages the Apache web server.

---

## Verify Service Status

Check whether Apache is running:

```bash
systemctl status apache2.service
```

Expected result:

```text
active (running)
```

---

## Enable Apache

If Apache is not enabled:

```bash
sudo systemctl enable --now apache2.service
```

### Explanation

```text
enable
```

Start automatically after reboot.

```text
--now
```

Start immediately.

---

# Verify Apache Is Running

Check listening ports:

```bash
ss -tulpn | grep apache2
```

or:

```bash
ss -tulpn | grep :80
```

Example:

```text
LISTEN 0 511 *:80
```

This indicates that Apache is listening for HTTP connections.

---

# Testing Apache

## Local Test

Open:

```text
http://localhost
```

---

## Remote Test

If the server IP is:

```text
192.168.1.15
```

Open:

```text
http://192.168.1.15
```

---

## Expected Result

You should see the default Apache page:

```text
Apache2 Ubuntu Default Page
```

This confirms that Apache is functioning correctly.

---

# Apache Default Web Directory

Ubuntu stores website files in:

```bash
/var/www/html
```

---

## Create a Test Page

```bash
echo "Hello from Apache" | sudo tee /var/www/html/index.html
```

Visit:

```text
http://server-ip
```

Expected output:

```text
Hello from Apache
```

---

# Useful Apache Commands

### Start Apache

```bash
sudo systemctl start apache2
```

### Stop Apache

```bash
sudo systemctl stop apache2
```

### Restart Apache

```bash
sudo systemctl restart apache2
```

### Reload Configuration

```bash
sudo systemctl reload apache2
```

### Check Status

```bash
sudo systemctl status apache2
```

---

# Ubuntu vs CentOS Package Names

| Component      | Ubuntu          | CentOS        |
| -------------- | --------------- | ------------- |
| Apache         | apache2         | httpd         |
| Apache Service | apache2.service | httpd.service |
| MySQL Server   | mysql-server    | mysql-server  |
| MySQL Client   | mysql-client    | mysql         |
| PHP            | php             | php           |

---

# LAMP Installation Summary

Install:

```bash
sudo apt update
sudo apt install apache2 mysql-server mysql-client php libapache2-mod-php
```

Verify Apache:

```bash
systemctl status apache2.service
```

Enable if necessary:

```bash
sudo systemctl enable --now apache2.service
```

Test in a browser:

```text
http://localhost
```

or

```text
http://server-ip
```

If the Apache default page appears, the first part of the Ubuntu LAMP stack has been installed successfully.

---

## Important Takeaway

The Ubuntu LAMP stack consists of:

```text
apache2
      +
mysql-server
      +
mysql-client
      +
php
      +
libapache2-mod-php
```

Apache is managed through:

```text
apache2.service
```

and web content is served from:

```bash
/var/www/html
```

Once Apache is running, the server should be reachable through a web browser on port **80 (HTTP)**.
