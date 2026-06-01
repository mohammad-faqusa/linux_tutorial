# 365. Setting Up MySQL

## MySQL Architecture

### Overview

MySQL follows a client-server architecture.

The database server stores and manages the data, while clients connect to it and execute SQL queries.

Architecture:

```text
                MySQL Server
                      ▲
                      │
       ┌──────────────┼──────────────┐
       │              │              │
       ▼              ▼              ▼
 MySQL CLI       PHP Application   phpMyAdmin
```

This allows multiple applications and users to share the same database simultaneously.

---

## MySQL Server

The MySQL server is responsible for:

* Storing databases
* Managing tables
* Executing SQL queries
* Handling authentication
* Managing concurrent connections

The server process usually runs continuously in the background.

---

## MySQL Clients

A MySQL client is any application that connects to the MySQL server.

Examples:

### Command-Line Client

```bash
mysql
```

Used by administrators and developers.

---

### PHP Applications

Examples:

* WordPress
* Laravel
* Drupal
* Custom PHP applications

These applications connect to MySQL to store and retrieve data.

---

### phpMyAdmin

A web-based administration tool that allows database management through a browser.

Example:

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

# Starting MySQL

## CentOS

The MySQL server service is:

```text
mysqld.service
```

### Check Status

```bash
sudo systemctl status mysqld
```

---

### Enable and Start

```bash
sudo systemctl enable --now mysqld.service
```

Explanation:

```text
enable
```

Start automatically after reboot.

```text
--now
```

Start immediately.

---

### Verify

```bash
sudo systemctl status mysqld
```

Expected:

```text
active (running)
```

---

## Ubuntu

The service name is:

```text
mysql.service
```

### Check Status

```bash
systemctl status mysql
```

Expected:

```text
active (running)
```

---

### Start Manually (if needed)

```bash
sudo systemctl start mysql
```

Usually Ubuntu enables MySQL automatically during installation.

---

# Connecting to MySQL

## Method 1: Connect as Root (No Password)

On many Linux distributions, MySQL is configured to trust the Linux root user.

Connect using:

```bash
sudo mysql -u root
```

Why does this work?

```text
Linux Root User
        ↓
MySQL Verifies Linux Account
        ↓
Access Granted
```

This is called:

```text
socket authentication
```

or

```text
auth_socket
```

authentication.

---

## Method 2: Password Authentication

Connect with:

```bash
mysql -u root -p
```

MySQL asks:

```text
Enter password:
```

and then authenticates using the database password.

---

## Method 3: Without sudo

```bash
mysql -u root
```

This may fail if:

* Password authentication is enabled
* Socket authentication is disabled

Example error:

```text
Access denied for user 'root'
```

---

# Entering the MySQL Shell

After a successful connection:

```text
mysql>
```

You are now inside the MySQL command-line interface.

---

## Running a Simple Query

```sql
SELECT CURRENT_TIME();
```

Example output:

```text
+--------------+
| CURRENT_TIME |
+--------------+
| 14:32:55     |
+--------------+
```

---

## Useful Test Queries

### Current Date

```sql
SELECT CURRENT_DATE();
```

---

### MySQL Version

```sql
SELECT VERSION();
```

Example:

```text
8.0.42
```

---

### Current User

```sql
SELECT USER();
```

Example:

```text
root@localhost
```

---

## Listing Databases

```sql
SHOW DATABASES;
```

Example:

```text
information_schema
mysql
performance_schema
sys
```

---

## Exiting MySQL

```sql
EXIT;
```

or

```sql
QUIT;
```

or:

```bash
CTRL + D
```

---

# Setting a Root Password

In older MySQL installations:

```sql
ALTER USER 'root'@'localhost'
IDENTIFIED BY 'StrongPassword';
```

After that:

```bash
mysql -u root -p
```

will require the password.

> Note: The exact command depends on the MySQL version and authentication plugin being used.

---

# Checking the MySQL Process

View running processes:

```bash
ps aux | grep mysql
```

or

```bash
ps aux | grep mysqld
```

Example:

```text
mysql    1234  ... mysqld
```

---

# Verify Listening Port

MySQL normally listens on:

```text
3306
```

Check:

```bash
ss -tulpn | grep 3306
```

Example:

```text
LISTEN 0 80 127.0.0.1:3306
```

---

# Client-Server Flow

```text
MySQL Client
      │
      ▼
TCP Socket / Local Socket
      │
      ▼
MySQL Server (mysqld)
      │
      ▼
Database Files
```

---

# Common Commands

### CentOS

```bash
sudo systemctl status mysqld
```

```bash
sudo systemctl enable --now mysqld.service
```

---

### Ubuntu

```bash
systemctl status mysql
```

```bash
sudo systemctl start mysql
```

---

### Connect to MySQL

```bash
sudo mysql -u root
```

```bash
mysql -u root -p
```

---

### Inside MySQL

```sql
SHOW DATABASES;
```

```sql
SELECT VERSION();
```

```sql
SELECT CURRENT_TIME();
```

```sql
EXIT;
```

---

## Important Takeaway

MySQL uses a **client-server architecture**:

```text
Clients
   │
   ▼
MySQL Server
   │
   ▼
Databases
```

Common clients include:

* MySQL CLI
* PHP applications
* WordPress
* phpMyAdmin

Useful commands:

```bash
sudo mysql -u root
```

```bash
mysql -u root -p
```

```sql
SELECT CURRENT_TIME();
```

Before using PHP applications such as WordPress or phpMyAdmin, ensure that the MySQL server is running and that you can successfully connect to it.
