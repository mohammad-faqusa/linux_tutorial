# 360. Creating a VirtualHost [CentOS]

## Goal

Create a separate website hosted by Apache using a VirtualHost.

Example:

```text
http://centos.local
```

instead of using the default website.

---

## Create a VirtualHost Configuration

Navigate to Apache's additional configuration directory:

```bash
cd /etc/httpd/conf.d
```

Create a new configuration file:

```bash
sudo nano centos.local.conf
```

Example configuration:

```apache
<VirtualHost *:80>

    ServerName centos.local
    ServerAdmin admin@centos.local

    DocumentRoot /var/www/html/centos.local

    ErrorLog logs/centos.local-error.log
    CustomLog logs/centos.local-access.log combined

</VirtualHost>
```

---

## Understanding the Configuration

### ServerName

```apache
ServerName centos.local
```

The hostname that Apache should match.

---

### DocumentRoot

```apache
DocumentRoot /var/www/html/centos.local
```

Defines where the website files are stored.

---

### ErrorLog

```apache
ErrorLog logs/centos.local-error.log
```

Stores Apache error messages for this website.

---

### CustomLog

```apache
CustomLog logs/centos.local-access.log combined
```

Stores visitor requests and access information.

---

## Create the Website Directory

```bash
sudo mkdir -p /var/www/html/centos.local
```

---

## Create the Homepage

```bash
sudo nano /var/www/html/centos.local/index.html
```

Example:

```html
<h1>This is the centos.local server</h1>
```

---

## SELinux Considerations

On CentOS, SELinux controls access permissions.

After creating new web directories, Apache may not have permission to access them.

Refresh the SELinux contexts:

```bash
sudo restorecon -R /var/www/html/
```

### Explanation

```text
restorecon
```

restores the default SELinux security labels for files and directories.

Without this step, Apache may return:

```text
403 Forbidden
```

even when file permissions appear correct.

---

## Test the Configuration

Before restarting Apache:

```bash
sudo httpd -t
```

Expected output:

```text
Syntax OK
```

Always test the configuration before restarting the service.

---

## Restart Apache

```bash
sudo systemctl restart httpd.service
```

---

# Creating Additional VirtualHosts

If you want another website, you can copy the existing configuration:

```bash
cp centos.local.conf mysite.local.conf
```

Edit it:

```bash
nano mysite.local.conf
```

Change:

```apache
ServerName mysite.local
DocumentRoot /var/www/html/mysite.local
```

Create the corresponding directory:

```bash
sudo mkdir -p /var/www/html/mysite.local
```

and add its own `index.html`.

---

# Local Hostname Resolution with mDNS

To access:

```text
http://centos.local
```

the hostname must resolve correctly.

Install mDNS support:

```bash
sudo dnf install nss-mdns
```

Reboot:

```bash
sudo reboot
```

---

## Verify Hostname Resolution

Test:

```bash
ping centos.local
```

Expected result:

```text
PING centos.local (...)
```

If the hostname resolves successfully, Apache can be accessed through:

```text
http://centos.local
```

---

# Request Flow

```text
Browser
    │
    ▼
http://centos.local
    │
    ▼
Apache Receives Request
    │
    ▼
Matches VirtualHost
(ServerName centos.local)
    │
    ▼
DocumentRoot
/var/www/html/centos.local
    │
    ▼
index.html
```

---

# Useful Commands

### Test Configuration

```bash
sudo httpd -t
```

### Restart Apache

```bash
sudo systemctl restart httpd.service
```

### View Apache Status

```bash
sudo systemctl status httpd.service
```

### View Logs

```bash
sudo journalctl -u httpd.service
```

### Restore SELinux Labels

```bash
sudo restorecon -R /var/www/html/
```

---

## Important Takeaway

Creating a VirtualHost on CentOS involves:

1. Creating a configuration file in:

```bash
/etc/httpd/conf.d/
```

2. Defining:

```apache
ServerName
DocumentRoot
ErrorLog
CustomLog
```

3. Creating the website directory:

```bash
/var/www/html/centos.local
```

4. Restoring SELinux labels:

```bash
sudo restorecon -R /var/www/html/
```

5. Testing and restarting Apache:

```bash
sudo httpd -t
sudo systemctl restart httpd.service
```

A VirtualHost allows a single Apache server to host multiple independent websites, each with its own domain name, files, and logs.
