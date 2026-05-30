# 353. Installing LAMP on CentOS

## Installing the LAMP Components

### Required Packages

To build a LAMP stack on CentOS, we need to install:

#### Apache Web Server

Package:

```text
httpd
```

Provides:

* Apache HTTP Server
* HTTP and HTTPS hosting
* Web server functionality

---

#### MySQL Client

Package:

```text
mysql
```

Provides:

* MySQL command-line client
* Database administration tools
* Ability to connect to MySQL servers

Example:

```bash
mysql -u root -p
```

---

#### MySQL Server

Package:

```text
mysql-server
```

Provides:

* MySQL database server
* Database storage engine
* SQL processing

---

#### PHP

Package:

```text
php
```

Provides:

* PHP interpreter
* Server-side scripting support
* Dynamic web page generation

---

## Installing All Components

Install the complete LAMP stack:

```bash
sudo dnf install httpd mysql mysql-server php
```

During installation, DNF automatically installs any required dependencies.

---

## Verifying Installation

Check installed packages:

```bash
rpm -qa | grep httpd
```

```bash
rpm -qa | grep mysql
```

```bash
rpm -qa | grep php
```

---

# Starting Apache (httpd)

## Service Installation

When Apache is installed, a systemd service is automatically created:

```text
httpd.service
```

This service manages the Apache web server.

---

## Start Apache

Start the service:

```bash
sudo systemctl start httpd.service
```

---

## Enable Apache at Boot

To automatically start Apache after every reboot:

```bash
sudo systemctl enable httpd.service
```

---

## Start and Enable in One Command

Most administrators use:

```bash
sudo systemctl enable --now httpd.service
```

### Explanation

```text
--now
```

Start immediately.

```text
enable
```

Start automatically after future reboots.

---

## Verify Service Status

Check whether Apache is running:

```bash
sudo systemctl status httpd.service
```

Expected result:

```text
active (running)
```

---

# Verifying Apache Is Listening

Check listening ports:

```bash
ss -tulpn | grep httpd
```

or:

```bash
ss -tulpn | grep :80
```

Example output:

```text
LISTEN 0 511 *:80
```

This indicates that Apache is accepting HTTP connections.

---

# Accessing Apache

## Local Access

Open a browser on the server:

```text
http://localhost
```

---

## Remote Access

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

You should see the default Apache welcome page.

Example:

```text
Test Page for the Apache HTTP Server
```

This confirms that Apache is installed and functioning correctly.

---

# Common Problem: Firewall

If Apache is running but the page cannot be accessed remotely:

```text
Browser
     │
     ▼
Connection Failed
```

the firewall may be blocking HTTP traffic.

---

## Verify Firewalld Status

```bash
sudo systemctl status firewalld
```

---

## Allow HTTP Traffic

```bash
sudo firewall-cmd --add-service=http --permanent
```

Apply the changes:

```bash
sudo firewall-cmd --reload
```

---

## Verify Allowed Services

```bash
sudo firewall-cmd --list-services
```

Example:

```text
http https ssh
```

---

# Apache Default Web Directory

Apache serves web pages from:

```bash
/var/www/html
```

---

## Example

Create a simple page:

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

# Useful Commands

### Start Apache

```bash
sudo systemctl start httpd
```

### Stop Apache

```bash
sudo systemctl stop httpd
```

### Restart Apache

```bash
sudo systemctl restart httpd
```

### Reload Configuration

```bash
sudo systemctl reload httpd
```

### View Status

```bash
sudo systemctl status httpd
```

---

# LAMP Installation Summary

Install:

```bash
sudo dnf install httpd mysql mysql-server php
```

Start Apache:

```bash
sudo systemctl enable --now httpd.service
```

Verify:

```bash
sudo systemctl status httpd.service
```

Open:

```text
http://server-ip
```

If the Apache welcome page appears, the first component of the LAMP stack is successfully installed.

---

## Important Takeaway

On CentOS, the core LAMP packages are:

```text
httpd         → Apache Web Server
mysql         → MySQL Client
mysql-server  → MySQL Server
php           → PHP Interpreter
```

After installation, Apache is managed through:

```text
httpd.service
```

and should be started using:

```bash
sudo systemctl enable --now httpd.service
```

Once running, the server should be accessible through a web browser on port **80 (HTTP)**.
