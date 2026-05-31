# 359. How Does a VirtualHost Work?

## What Is a VirtualHost?

### The Problem

A single Apache server may need to host multiple websites.

Example:

```text
example.com
blog.example.com
shop.example.com
```

We do not want to run a separate Apache instance for each website.

Instead, we want a single Apache server to serve all of them.

---

### How Does Apache Know Which Website Was Requested?

Suppose a user visits:

```text
http://server.local
```

The browser first resolves the domain name to an IP address:

```text
server.local
      ↓
192.168.1.15
```

The browser then sends an HTTP request to the server:

```text
GET / HTTP/1.1
Host: server.local
```

Notice the:

```text
Host
```

header.

This tells Apache which website the client wants to access.

---

### The Solution: Virtual Hosts

Apache provides:

```text
VirtualHost
```

configurations.

A VirtualHost defines:

* Which domain names belong to a website
* Which folder contains the website files
* Which logs should be used
* Other website-specific settings

This allows multiple websites to be hosted on the same server.

---

## How Virtual Hosts Work

Example:

```text
192.168.1.15
      │
      ▼
Apache
      │
 ┌────┼────┐
 ▼    ▼    ▼
Site1 Site2 Site3
```

Apache receives the request and checks:

```text
Host Header
```

to determine which VirtualHost should handle it.

---

## Example

Request:

```text
http://blog.local
```

Browser sends:

```http
GET / HTTP/1.1
Host: blog.local
```

Apache finds the matching VirtualHost:

```apache
ServerName blog.local
```

and serves files from that website.

---

## Virtual Hosts and Configuration Inheritance

A VirtualHost inherits most settings from the main Apache configuration.

Example:

```text
Main Apache Configuration
           │
           ▼
      VirtualHost
```

However, the VirtualHost can override many settings.

Examples:

* DocumentRoot
* ErrorLog
* CustomLog
* ServerName
* SSL settings
* Directory permissions

---

## Typical VirtualHost Configuration

Example:

```apache
<VirtualHost *:80>

    ServerName example.com
    ServerAdmin admin@example.com

    DocumentRoot /var/www/example

    ErrorLog logs/example-error.log
    CustomLog logs/example-access.log combined

</VirtualHost>
```

---

## Explanation of the Directives

### VirtualHost *:80

```apache
<VirtualHost *:80>
```

Meaning:

```text
Handle HTTP requests
received on port 80
```

The asterisk means:

```text
All IP addresses
```

---

### ServerName

```apache
ServerName example.com
```

Defines the hostname that this VirtualHost serves.

Example request:

```text
Host: example.com
```

will match this VirtualHost.

---

### ServerAdmin

```apache
ServerAdmin admin@example.com
```

Administrative contact for the website.

May appear in error pages.

---

### DocumentRoot

```apache
DocumentRoot /var/www/example
```

Defines where the website files are located.

Example:

```text
http://example.com/index.html
```

maps to:

```text
/var/www/example/index.html
```

---

### ErrorLog

```apache
ErrorLog logs/example-error.log
```

Stores:

* Apache errors
* PHP errors
* Configuration issues

---

### CustomLog

```apache
CustomLog logs/example-access.log combined
```

Stores:

* Client IP addresses
* Requested URLs
* HTTP methods
* Response codes

---

## Example: Multiple Websites

Suppose we have:

```text
Website 1:
example.com

Website 2:
blog.example.com
```

Directory structure:

```text
/var/www/example
/var/www/blog
```

VirtualHosts:

```apache
<VirtualHost *:80>
    ServerName example.com
    DocumentRoot /var/www/example
</VirtualHost>

<VirtualHost *:80>
    ServerName blog.example.com
    DocumentRoot /var/www/blog
</VirtualHost>
```

---

### Request Flow

User visits:

```text
http://example.com
```

Apache serves:

```text
/var/www/example
```

---

User visits:

```text
http://blog.example.com
```

Apache serves:

```text
/var/www/blog
```

---

## Why Use Virtual Hosts?

Benefits:

* Host multiple websites on one server.
* Separate configurations for each site.
* Separate logs for each site.
* Separate SSL certificates.
* Easier administration.

---

## Important Takeaway

A VirtualHost is a website-specific Apache configuration.

It allows Apache to:

```text
Receive Request
       ↓
Check Host Header
       ↓
Find Matching VirtualHost
       ↓
Apply Website Configuration
       ↓
Serve Files
```

The most commonly overridden setting is:

```apache
DocumentRoot
```

which determines from which directory Apache serves the website's files.

Using VirtualHosts, a single Apache server can host many websites while each website appears to have its own independent server and configuration.
