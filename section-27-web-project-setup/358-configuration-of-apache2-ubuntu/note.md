# 358. Configuration of Apache2 [Ubuntu]

## Ubuntu Apache Configuration Structure

Unlike CentOS, Ubuntu organizes Apache configuration into several directories.

The main configuration file is:

```bash
/etc/apache2/apache2.conf
```

Open it:

```bash
sudo nano /etc/apache2/apache2.conf
```

---

## Configuration Philosophy

Ubuntu splits Apache's configuration into many smaller files.

Benefits:

* Easier maintenance
* Cleaner organization
* Easier package management
* Features can be enabled or disabled individually

Instead of placing everything in one large file, Apache loads additional configuration files through `Include` directives.

---

## Include Directives

Inside `apache2.conf`, you will find directives such as:

```apache
Include
```

and

```apache
IncludeOptional
```

### Include

Loads a configuration file.

If the file does not exist:

```text
Apache startup fails
```

---

### IncludeOptional

Loads a configuration file only if it exists.

If the file is missing:

```text
Apache continues normally
```

This is commonly used for modular configurations.

---

# Configuration Directories

Ubuntu organizes Apache configurations into several directories:

```text
/etc/apache2
├── apache2.conf
├── conf-available/
├── conf-enabled/
├── mods-available/
├── mods-enabled/
├── sites-available/
└── sites-enabled/
```

---

## conf-available

Contains available configuration files.

Example:

```bash
ls /etc/apache2/conf-available
```

Possible output:

```text
charset.conf
security.conf
localized-error-pages.conf
```

These files are **available** but not necessarily loaded by Apache.

---

## Example: charset.conf

View the file:

```bash
cat /etc/apache2/conf-available/charset.conf
```

This file contains character encoding settings.

Example:

```apache
AddDefaultCharset UTF-8
```

This helps Apache serve pages using UTF-8 encoding.

---

## Important

Files located only in:

```bash
/etc/apache2/conf-available
```

are **not automatically loaded**.

Apache only reads configurations that are enabled.

---

# conf-enabled

Enabled configurations are located in:

```bash
/etc/apache2/conf-enabled
```

View them:

```bash
cd /etc/apache2/conf-enabled
ls -l
```

Example output:

```text
charset.conf -> ../conf-available/charset.conf
security.conf -> ../conf-available/security.conf
```

---

## Why Do the Colors Look Different?

When running:

```bash
ls
```

or

```bash
ls -l
```

the files often appear in a different color because they are:

```text
Symbolic Links (Symlinks)
```

---

## What Is a Symlink?

A symbolic link is essentially a shortcut.

Example:

```text
conf-enabled/charset.conf
          │
          ▼
conf-available/charset.conf
```

Apache loads the file through the symlink.

---

# Enabling a Configuration File

Ubuntu provides helper commands for managing configurations.

Enable a configuration:

```bash
sudo a2enconf <file-name>
```

Example:

```bash
sudo a2enconf charset
```

Result:

```text
Creates a symlink in conf-enabled/
```

---

## What Happens Internally?

```text
conf-available/charset.conf
             │
             ▼
conf-enabled/charset.conf
```

Apache now reads the configuration.

---

## Restart Apache

After enabling a configuration:

```bash
sudo systemctl restart apache2
```

or

```bash
sudo systemctl reload apache2
```

---

# Disabling a Configuration File

Disable a configuration:

```bash
sudo a2disconf <file-name>
```

Example:

```bash
sudo a2disconf charset
```

---

## What Happens?

The symlink is removed:

```text
conf-enabled/charset.conf
        removed
```

The original file remains in:

```bash
/etc/apache2/conf-available
```

but Apache no longer loads it.

---

## Restart Apache

Apply the changes:

```bash
sudo systemctl restart apache2
```

---

# Verify Enabled Configurations

List enabled configurations:

```bash
ls -l /etc/apache2/conf-enabled
```

Example:

```text
charset.conf -> ../conf-available/charset.conf
security.conf -> ../conf-available/security.conf
```

These are the configuration files currently loaded by Apache.

---

# Typical Workflow

### View Available Configurations

```bash
ls /etc/apache2/conf-available
```

---

### Enable a Configuration

```bash
sudo a2enconf charset
```

---

### Restart Apache

```bash
sudo systemctl restart apache2
```

---

### Disable a Configuration

```bash
sudo a2disconf charset
```

---

### Restart Apache Again

```bash
sudo systemctl restart apache2
```

---

# Configuration Loading Flow

```text
conf-available/
       │
       ▼
a2enconf
       │
       ▼
conf-enabled/
       │
       ▼
Apache Reads Configuration
```

---

## Important Takeaway

Ubuntu uses a modular Apache configuration system.

Configuration files are stored in:

```bash
/etc/apache2/conf-available
```

but Apache only loads files that are enabled through symlinks in:

```bash
/etc/apache2/conf-enabled
```

Useful commands:

```bash
sudo a2enconf <name>
```

Enable a configuration.

```bash
sudo a2disconf <name>
```

Disable a configuration.

This modular approach makes Apache configuration cleaner and easier to manage on Ubuntu systems.
