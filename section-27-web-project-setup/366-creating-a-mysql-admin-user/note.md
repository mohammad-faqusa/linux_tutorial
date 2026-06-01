# 366. Creating a MySQL Admin User

## Why Create an Admin User?

Although MySQL provides a `root` account, it is generally a good idea to create a separate administrative user.

Benefits:

* Avoid using `root` for daily administration.
* Easier auditing and management.
* Ability to create different accounts with different privileges.
* Better security practices.

---

## MySQL Users

MySQL users are identified by:

```text
'username'@'host'
```

Example:

```text
'admin'@'localhost'
```

Meaning:

* Username: `admin`
* Allowed to connect from: `localhost`

---

## Understanding localhost

```text
'admin'@'localhost'
```

means:

```text
Only connections originating from the same machine
are allowed.
```

For example:

```bash
mysql -u admin -p
```

from the server itself.

---

## Connect as Root

On Linux systems:

```bash
sudo mysql -u root
```

You should see:

```text
mysql>
```

---

## Select the mysql Database

Although not strictly required for creating users, many administrators switch to the MySQL system database:

```sql
USE mysql;
```

Expected:

```text
Database changed
```

---

# Create the Admin User

### Correct Syntax

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';
```

### Explanation

```text
admin
```

Username.

```text
localhost
```

Allowed host.

```text
admin
```

Password.

---

> **Note:** In production, never use weak passwords such as:
>
> ```text
> admin
> password
> 123456
> ```
>
> Use a strong password instead.

---

# Grant Administrative Privileges

Grant full privileges:

```sql
GRANT ALL PRIVILEGES
ON *.*
TO 'admin'@'localhost'
WITH GRANT OPTION;
```

---

## What Does This Mean?

### ALL PRIVILEGES

```text
Create databases
Delete databases
Create tables
Delete tables
Modify users
Manage permissions
```

Essentially gives administrative access.

---

### ON *.*

```text
*.* = all databases and all tables
```

Examples:

```text
wordpress.*
shop.*
employees.*
```

All are included.

---

### WITH GRANT OPTION

Allows the user to grant permissions to other users.

Example:

```text
admin
   │
   ▼
Can create additional MySQL users
and assign privileges
```

Without this option, the user could administer databases but could not grant permissions to others.

---

# Reload Privileges

Apply changes:

```sql
FLUSH PRIVILEGES;
```

Although modern MySQL versions often apply changes immediately, running this command is still common practice.

---

# Exit MySQL

```sql
QUIT;
```

or

```sql
EXIT;
```

---

# Test the New User

Connect:

```bash
mysql -u admin -p
```

MySQL asks:

```text
Enter password:
```

Enter:

```text
admin
```

If successful:

```text
mysql>
```

appears again.

---

# Verify Current User

Inside MySQL:

```sql
SELECT USER();
```

Example output:

```text
+------------------+
| USER()           |
+------------------+
| admin@localhost  |
+------------------+
```

This confirms that you are connected as the new admin account.

---

# Verify Privileges

Show grants:

```sql
SHOW GRANTS FOR 'admin'@'localhost';
```

Example output:

```text
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost'
WITH GRANT OPTION
```

---

# Common Mistakes

## Missing Semicolon

Incorrect:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin'
```

Correct:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';
```

---

## Typo in FLUSH PRIVILEGES

Incorrect:

```sql
FLUSH PRIVALEGES;
```

Correct:

```sql
FLUSH PRIVILEGES;
```

---

## Typo in IDENTIFIED

Incorrect:

```sql
sIDENTIFIED BY 'admin';
```

Correct:

```sql
IDENTIFIED BY 'admin';
```

---

# Security Recommendation

For learning purposes:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';
```

is acceptable.

For production systems:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'T9!vK#4mL2@xP8';
```

Use a long and unique password.

---

# Complete Example

```bash
sudo mysql -u root
```

```sql
USE mysql;

CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'admin';

GRANT ALL PRIVILEGES
ON *.*
TO 'admin'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

EXIT;
```

Test:

```bash
mysql -u admin -p
```

---

## Important Takeaway

Creating a MySQL administrator consists of:

```sql
CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'password';
```

```sql
GRANT ALL PRIVILEGES
ON *.*
TO 'admin'@'localhost'
WITH GRANT OPTION;
```

```sql
FLUSH PRIVILEGES;
```

This creates a user capable of managing all databases and other MySQL users, making it suitable for administration tasks and tools such as phpMyAdmin.
