# 355. How Does Apache Work and How Is It Configured?

## How Does Apache (httpd) Work?

### Overview

Apache HTTP Server (httpd) is a web server that receives HTTP requests from clients and returns the appropriate content.

Example:

```text
Web Browser
      │
HTTP Request
      ▼
Apache Server
      │
HTTP Response
      ▼
Web Browser
```

---

## Main Operations

When Apache receives a request, it typically performs the following steps:

### 1. Listen for Requests

Apache listens on network ports such as:

```text
80   → HTTP
443  → HTTPS
```

Example:

```text
http://localhost
```

---

### 2. Interpret the Request

Apache examines the requested URL.

Example:

```text
http://localhost/index.html
```

Apache translates this into a file path:

```text
/var/www/html/index.html
```

---

### 3. Return the Response

If the file exists:

```text
200 OK
```

The file is sent to the client.

If the file does not exist:

```text
404 Not Found
```

An error page is returned.

---

# Apache Document Root

By default, Apache serves files from:

```bash
/var/www/html
```

This directory is called the:

```text
Document Root
```

---

## Creating a Simple Website

Create an HTML file:

```bash
cd /var/www/html
sudo nano index.html
```

Example content:

```html
<h1>Mohammad Faqusa</h1>
```

Open a browser:

```text
http://localhost
```

or

```text
http://server-ip
```

Expected output:

```text
Mohammad Faqusa
```

---

# Serving Additional Files

Create a directory:

```bash
mkdir /var/www/html/folder
```

Create a file:

```bash
touch /var/www/html/folder/test.txt
```

Add content:

```bash
echo "Hello World" > /var/www/html/folder/test.txt
```

---

## Access the File

Open:

```text
http://localhost/folder/test.txt
```

Apache maps the URL:

```text
/folder/test.txt
```

to:

```text
/var/www/html/folder/test.txt
```

and returns the file contents.

---

# Apache Module System

Apache uses a modular architecture.

Its functionality can be extended through modules.

---

## Why Modules?

The core Apache server is relatively small.

Additional features are provided through modules.

Examples:

| Module      | Purpose                  |
| ----------- | ------------------------ |
| mod_ssl     | HTTPS support            |
| mod_php     | PHP support              |
| mod_rewrite | URL rewriting            |
| mod_proxy   | Reverse proxy            |
| mod_headers | HTTP header manipulation |

---

## Example

Without:

```text
mod_ssl
```

Apache cannot serve HTTPS websites.

With:

```text
mod_ssl
```

Apache can support:

```text
https://example.com
```

---

# Virtual Hosts

## What Are Virtual Hosts?

Virtual Hosts allow a single Apache server to host multiple websites.

Example:

```text
Server
   │
   ├── example.com
   ├── company.com
   └── blog.com
```

All websites can share the same Apache installation.

---

## Why Use Virtual Hosts?

Instead of running:

```text
1 Apache Server
per Website
```

we can run:

```text
1 Apache Server
      │
      ▼
Multiple Websites
```

This is how most shared hosting environments work.

---

# Apache Architecture

## Main Process

Apache starts a parent process.

Responsibilities:

* Read configuration
* Manage worker processes
* Coordinate requests

---

## Worker Processes

Apache also starts multiple worker processes.

Responsibilities:

* Handle incoming requests
* Serve files
* Execute modules

---

### Architecture

```text
Apache Parent Process
          │
 ┌────────┼────────┐
 ▼        ▼        ▼
Worker  Worker  Worker
```

This allows Apache to serve many clients simultaneously.

---

## Viewing Apache Processes

### CentOS

```bash
systemctl status httpd.service
```

---

### Ubuntu

```bash
systemctl status apache2.service
```

Example:

```text
Main PID: 1234
Tasks: 6
```

You will often see several Apache processes running.

---

# How Apache Configuration Works

## General Idea

Apache uses:

```text
Main Configuration File
          +
Additional Included Files
```

This makes configuration easier to manage.

---

## Why Split Configuration?

Benefits:

* Easier maintenance
* Cleaner organization
* Package compatibility
* Modular configuration

Additional packages can simply add their own configuration files.

Example:

```text
PHP Package
      ↓
Adds PHP Configuration
```

without modifying the main Apache configuration file.

---

# Apache Configuration on CentOS

Apache configuration is primarily stored in:

---

## Main Configuration

```bash
/etc/httpd/conf/httpd.conf
```

Contains the primary Apache settings.

---

## Module Configuration

```bash
/etc/httpd/conf.modules.d/*.conf
```

Contains module-related configuration.

Examples:

```text
php.conf
ssl.conf
proxy.conf
```

---

## Additional Configuration

```bash
/etc/httpd/conf.d/*.conf
```

Contains additional server configuration files.

---

### CentOS Configuration Structure

```text
httpd.conf
      │
      ├── conf.modules.d/*.conf
      └── conf.d/*.conf
```

---

# Apache Configuration on Ubuntu

Ubuntu organizes Apache differently.

---

## Main Configuration

```bash
/etc/apache2/apache2.conf
```

Main Apache configuration file.

---

## Additional Configuration

```bash
/ etc/apache2/conf-enabled/
```

Contains enabled configuration snippets.

---

## Enabled Websites

```bash
/etc/apache2/sites-enabled/
```

Contains enabled Virtual Host configurations.

---

### Ubuntu Configuration Structure

```text
apache2.conf
      │
      ├── conf-enabled/
      └── sites-enabled/
```

---

# CentOS vs Ubuntu Configuration

| CentOS                     | Ubuntu                    |
| -------------------------- | ------------------------- |
| /etc/httpd/conf/httpd.conf | /etc/apache2/apache2.conf |
| conf.modules.d             | conf-enabled              |
| conf.d                     | sites-enabled             |
| httpd service              | apache2 service           |

---

# Useful Commands

### Check Apache Status (CentOS)

```bash
systemctl status httpd.service
```

---

### Check Apache Status (Ubuntu)

```bash
systemctl status apache2.service
```

---

### Test Apache Configuration

CentOS:

```bash
sudo httpd -t
```

Ubuntu:

```bash
sudo apache2ctl configtest
```

---

# Important Takeaway

Apache works by:

```text
Receive Request
       ↓
Map URL To File
       ↓
Serve File
       ↓
Return Response
```

Key concepts:

* Document Root: `/var/www/html`
* Module-based architecture
* Virtual Hosts for multiple websites
* Parent process with multiple worker processes
* Configuration split across multiple files for easier management

Understanding Apache's architecture and configuration layout is essential before learning Virtual Hosts, PHP integration, SSL/TLS, and production web server management.
