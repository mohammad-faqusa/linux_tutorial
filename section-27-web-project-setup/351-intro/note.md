# 351. Introduction to Web Servers and Firewalls

## Why This Chapter?

In this chapter, we will learn how to build a complete web server environment on Linux.

A traditional web server stack consists of:

* Linux (Operating System)
* Apache (HTTP Server)
* MySQL (Database Server)
* PHP (Server-Side Programming Language)

This combination is commonly known as the:

```text
LAMP Stack

L = Linux
A = Apache
M = MySQL
P = PHP
```

---

## What Will We Build?

The goal is to create a server capable of:

* Serving websites
* Running web applications
* Processing PHP code
* Storing data in databases
* Accepting HTTP/HTTPS requests

Example architecture:

```text
Client Browser
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

---

## Distribution Differences

Unfortunately, web server configuration is not identical across Linux distributions.

The setup process differs significantly between:

* Ubuntu / Debian
* CentOS / Rocky Linux / RHEL

---

## CentOS Approach

CentOS generally follows the upstream Apache configuration structure.

This means:

* Configuration files are closer to the official Apache documentation.
* Less abstraction is added by the distribution.
* Commonly preferred in enterprise environments.

Example service name:

```bash
httpd
```

---

## Ubuntu / Debian Approach

Ubuntu and Debian add additional management tools and configuration layers on top of Apache.

Examples:

* sites-available
* sites-enabled
* a2ensite
* a2dissite
* a2enmod
* a2dismod

These tools simplify administration but differ from the upstream Apache approach.

---

## Why Learn Both?

Even if you primarily use Ubuntu, it is highly recommended to also watch the CentOS sections.

Reasons:

* Many enterprise servers use RHEL-based distributions.
* Cloud environments frequently use Rocky Linux, AlmaLinux, or RHEL.
* Understanding both approaches makes you more flexible as an administrator.

---

## Lecture Categories

Throughout this chapter, lectures may be classified as:

### Theory

Concepts that apply to all Linux distributions.

Examples:

* HTTP
* Web servers
* Virtual hosts
* SSL/TLS
* Firewalls

---

### CentOS

Distribution-specific instructions for:

* CentOS
* Rocky Linux
* AlmaLinux
* RHEL

---

### Ubuntu

Distribution-specific instructions for:

* Ubuntu
* Debian

---

### CentOS / Ubuntu

Instructions that apply to both families of Linux distributions.

---

# Adding a Firewall

## Why Do We Need a Firewall?

A firewall controls which network traffic is allowed to reach the server.

Without a firewall:

```text
Internet
    │
    ▼
Server
```

All open services may be reachable.

---

## With a Firewall

```text
Internet
    │
    ▼
Firewall
    │
 ┌──┴──┐
 │     │
Allow Block
```

The firewall decides which connections are permitted.

---

## Benefits of a Firewall

A firewall helps:

* Reduce the attack surface
* Block unauthorized access
* Restrict unnecessary services
* Protect production servers

---

## Firewalld

In this chapter, we will primarily use:

```text
firewalld
```

Firewalld is a dynamic firewall management tool commonly used on:

* CentOS
* Rocky Linux
* AlmaLinux
* RHEL

---

## Example

Allow HTTP traffic:

```bash
sudo firewall-cmd --add-service=http --permanent
```

Allow HTTPS traffic:

```bash
sudo firewall-cmd --add-service=https --permanent
```

Apply changes:

```bash
sudo firewall-cmd --reload
```

---

## Why This Chapter Is Important

As a backend developer, DevOps engineer, or system administrator, you will frequently deploy applications to Linux servers.

Understanding:

* Apache
* MySQL
* PHP
* Firewalls

is essential for:

* Hosting websites
* Deploying applications
* Securing servers
* Managing production environments

---

## Important Takeaway

This chapter focuses on building and securing a Linux web server environment using:

```text
Linux
    +
Apache (httpd)
    +
MySQL
    +
PHP
    +
Firewall
```

Although Ubuntu and CentOS configure these components differently, understanding both approaches will make you a more capable Linux administrator and developer.
