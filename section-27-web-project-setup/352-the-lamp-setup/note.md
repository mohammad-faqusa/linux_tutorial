# 352. The LAMP Setup

## What Is LAMP?

LAMP is a popular web server stack used to host dynamic websites and web applications.

```text
L = Linux
A = Apache
M = MySQL
P = PHP
```

Together, these components provide everything needed to build and host a traditional web application.

---

## How LAMP Works

```text
Web Browser
      │
      ▼
Apache Web Server
      │
      ▼
PHP Application
      │
      ▼
MySQL Database
```

### Example

1. A user visits a website.
2. Apache receives the HTTP request.
3. PHP executes the application logic.
4. PHP queries MySQL if data is needed.
5. The response is returned to the browser.

---

# Apache HTTP Server

## Overview

Apache HTTP Server (often called Apache or httpd) is an open-source web server.

It is developed and maintained by the Apache Software Foundation.

Apache is one of the most widely used web servers in the world.

---

## What Does a Web Server Do?

A web server:

* Receives HTTP/HTTPS requests from clients.
* Processes the requests.
* Returns web pages and other content.

Example:

```text
Browser
   │ HTTP Request
   ▼
Apache
   │
   ▼
HTML Response
```

---

## Key Features

### Highly Configurable

Apache can be configured to support many different use cases.

Examples:

* Personal websites
* Company websites
* APIs
* Reverse proxies
* Load balancers

---

### Modular Architecture

Apache can be extended through modules.

Examples:

* Authentication modules
* SSL/TLS modules
* PHP integration modules
* URL rewriting modules

Common module:

```text
mod_rewrite
```

used for friendly URLs.

---

### Supports Server-Side Languages

Apache can work with various programming languages:

* PHP
* Python
* Perl
* Java
* Node.js (through reverse proxying)

---

### SSL/TLS Support

Apache supports encrypted HTTPS connections.

```text
HTTP
   ↓
HTTPS
```

This protects data exchanged between clients and servers.

---

## Apache Service Name

### Ubuntu / Debian

```bash
apache2
```

### CentOS / Rocky Linux / RHEL

```bash
httpd
```

---

# MySQL

## Overview

MySQL is a popular open-source relational database management system (RDBMS).

It is currently developed and maintained by Oracle Corporation.

---

## What Is a Relational Database?

A relational database stores information in tables.

Example:

### Users Table

| id | name     | email                                           |
| -- | -------- | ----------------------------------------------- |
| 1  | Mohammad | [mohammad@email.com](mailto:mohammad@email.com) |
| 2  | Ahmad    | [ahmad@email.com](mailto:ahmad@email.com)       |

---

## SQL Support

MySQL uses:

```text
SQL
Structured Query Language
```

to manage data.

Examples:

### Create Table

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

### Insert Data

```sql
INSERT INTO users VALUES (1, 'Mohammad');
```

### Query Data

```sql
SELECT * FROM users;
```

---

## Schema-Based Design

Before storing data, we usually define the structure (schema) of the database.

Example:

```text
users
 ├── id
 ├── name
 └── email
```

This helps maintain data consistency.

---

## Multi-User Access

MySQL supports multiple users and applications accessing databases simultaneously.

Example:

```text
Website
      │
Mobile App
      │
Admin Panel
      ▼
MySQL Database
```

All can access the same database.

---

# MariaDB

## Overview

MariaDB is an open-source fork of MySQL.

It was created after concerns about Oracle's acquisition of MySQL.

---

## Key Features

### MySQL Compatibility

MariaDB is highly compatible with MySQL.

Most applications that work with MySQL will also work with MariaDB.

---

### Additional Features

MariaDB includes various enhancements and improvements.

Examples:

* GIS (Geographic Information System) features
* JSON support
* Additional storage engines
* Performance improvements

---

# MySQL or MariaDB?

## Which Should We Use?

For most users:

```text
MySQL ≈ MariaDB
```

The differences are relatively small for common web applications.

Both provide:

* SQL support
* Relational databases
* Multi-user access
* Good performance

---

## In This Course

The course focuses on:

```text
MySQL
```

because it remains one of the most widely used database systems.

---

# PHP

## Overview

PHP is an open-source scripting language designed primarily for web development.

PHP code is executed on the server before content is sent to the browser.

---

## How PHP Works

### Client Request

```text
Browser
    │
    ▼
Apache
    │
    ▼
PHP Script
```

PHP generates HTML dynamically and returns it to the browser.

---

## Example

```php
<?php
echo "Hello World!";
?>
```

Output:

```html
Hello World!
```

---

## Embedded in HTML

PHP can be placed directly inside HTML pages.

Example:

```php
<h1>Welcome</h1>

<?php
echo "Hello Mohammad";
?>
```

This makes it easy to generate dynamic web content.

---

## Key Features

### Gentle Learning Curve

PHP is relatively easy to learn.

Simple applications can be created quickly.

---

### Easy to Write Bad Code

Because PHP is very flexible, beginners can easily develop poor coding habits.

Examples:

* Mixing HTML and business logic
* Large unstructured files
* Lack of proper architecture

For this reason, frameworks are often used.

---

### Object-Oriented Programming (OOP)

Modern PHP supports advanced OOP features:

* Classes
* Interfaces
* Traits
* Inheritance
* Dependency Injection

This enables large, maintainable applications.

---

## Popular PHP Frameworks

Examples include:

* Laravel
* Symfony
* CodeIgniter

These frameworks help developers write cleaner and more maintainable code.

---

# Important Takeaway

The LAMP stack consists of:

```text
Linux
   +
Apache
   +
MySQL
   +
PHP
```

Each component has a specific role:

| Component | Purpose                          |
| --------- | -------------------------------- |
| Linux     | Operating System                 |
| Apache    | Web Server                       |
| MySQL     | Database                         |
| PHP       | Server-Side Programming Language |

Together, they form one of the most popular and widely used web application platforms in the world.
