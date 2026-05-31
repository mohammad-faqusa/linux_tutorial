# 361. Creating a VirtualHost [Ubuntu]

## Ubuntu VirtualHost Configuration

Unlike CentOS, Ubuntu stores VirtualHost configurations in dedicated directories.

The most important directories are:

```text
/etc/apache2/sites-available/
/etc/apache2/sites-enabled/
```

---

## Sites Available vs Sites Enabled

### sites-available

Contains all available website configurations.

```bash
cd /etc/apache2/sites-available
```

Example:

```text
000-default.conf
default-ssl.conf
mysite.conf
```

Apache does not automatically load all of these files.

---

### sites-enabled

Contains symbolic links (symlinks) to enabled websites.

```bash
cd /etc/apache2/sites-enabled
```

Example:

```text
000-default.conf -> ../sites-available/000-default.conf
```

Apache loads the VirtualHosts found in this directory.

---

## Default VirtualHost

Ubuntu ships with a default website configuration:

```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```

Example:

```apache
<VirtualHost *:80>

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```

---

## Environment Variables Inside Configuration Files

Notice:

```apache
${APACHE_LOG_DIR}
```

This is an environment variable.

Apache replaces it with the actual value when starting.

Example:

```text
${APACHE_LOG_DIR}
        ↓
/var/log/apache2
```

---

## Apache Environment Variables

Environment variables are defined in:

```bash
sudo nano /etc/apache2/envvars
```

---

### Example

Inside the file:

```bash
export APACHE_LOG_DIR=/var/log/apache2
```

Apache can then use:

```apache
${APACHE_LOG_DIR}
```

inside configuration files.

---

## Why Use Environment Variables?

Benefits:

* Easier maintenance
* Centralized configuration
* Avoid repeating paths
* Easier upgrades

Example:

Instead of writing:

```apache
ErrorLog /var/log/apache2/error.log
```

everywhere, Ubuntu uses:

```apache
ErrorLog ${APACHE_LOG_DIR}/error.log
```

---

# Creating a New VirtualHost

Create a new configuration:

```bash
sudo nano /etc/apache2/sites-available/mohammad.local.conf
```

Example:

```apache
<VirtualHost *:80>

    ServerName mohammad.local
    ServerAdmin admin@mohammad.local

    DocumentRoot /var/www/mohammad.local

    ErrorLog ${APACHE_LOG_DIR}/mohammad-error.log
    CustomLog ${APACHE_LOG_DIR}/mohammad-access.log combined

</VirtualHost>
```

---

## Create the Website Directory

```bash
sudo mkdir -p /var/www/mohammad.local
```

Create a homepage:

```bash
sudo nano /var/www/mohammad.local/index.html
```

Example:

```html
<h1>This is Mohammad's website</h1>
```

---

# Enable the VirtualHost

Ubuntu provides helper commands.

Enable the site:

```bash
sudo a2ensite mohammad.local.conf
```

Result:

```text
sites-enabled/mohammad.local.conf
      ↓
symlink
      ↓
sites-available/mohammad.local.conf
```

---

## Disable a VirtualHost

```bash
sudo a2dissite mohammad.local.conf
```

This removes the symlink but keeps the configuration file.

---

# Test the Configuration

Before restarting Apache:

```bash
sudo apache2ctl configtest
```

Expected output:

```text
Syntax OK
```

---

# Restart Apache

Apply the changes:

```bash
sudo systemctl restart apache2.service
```

---

# Verify the VirtualHost

If DNS or mDNS resolves:

```text
mohammad.local
```

to your server, open:

```text
http://mohammad.local
```

Apache will:

```text
Receive Request
        ↓
Check Host Header
        ↓
Match ServerName mohammad.local
        ↓
Use DocumentRoot /var/www/mohammad.local
        ↓
Serve index.html
```

---

# Ubuntu VirtualHost Workflow

```text
Create Configuration
        ↓
sites-available/
        ↓
a2ensite
        ↓
sites-enabled/
        ↓
apache2ctl configtest
        ↓
Restart Apache
        ↓
Website Available
```

---

## Useful Commands

### View Enabled Sites

```bash
ls -l /etc/apache2/sites-enabled
```

### Enable a Site

```bash
sudo a2ensite mysite.conf
```

### Disable a Site

```bash
sudo a2dissite mysite.conf
```

### Test Configuration

```bash
sudo apache2ctl configtest
```

### Restart Apache

```bash
sudo systemctl restart apache2.service
```

### View Environment Variables

```bash
sudo nano /etc/apache2/envvars
```

---

## Important Takeaway

Ubuntu manages VirtualHosts using:

```text
sites-available/
        +
sites-enabled/
```

A VirtualHost is typically:

1. Created in:

```bash
/etc/apache2/sites-available/
```

2. Enabled using:

```bash
sudo a2ensite site.conf
```

3. Tested with:

```bash
sudo apache2ctl configtest
```

4. Activated with:

```bash
sudo systemctl restart apache2.service
```

This modular approach makes it easy to manage multiple websites from a single Apache server while keeping configurations clean and organized.
