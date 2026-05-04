## 145. Streamlining Filesystem Structure: the Project usrmerge

`usrmerge` is a Linux project that **simplifies the filesystem structure** by merging old top-level system folders into `/usr`.

Meaning these become symlinks:

```bash
/bin  -> /usr/bin
/sbin -> /usr/sbin
/lib  -> /usr/lib
/lib64 -> /usr/lib64
```

So instead of having commands/libraries split between `/bin` and `/usr/bin`, most of them live in **one place**: `/usr`.

---

## Why was this done?

Historically:

```text
/bin  = essential commands needed early in boot
/usr/bin = normal user commands
```

But modern Linux boot systems can mount `/usr` early, so the old split became less useful.

`usrmerge` makes the system:

```text
simpler
more consistent
easier for package managers
easier for containers/distributions
```

---

## Example

On many modern distros:

```bash
ls -ld /bin /sbin /lib
```

You may see:

```text
/bin -> usr/bin
/sbin -> usr/sbin
/lib -> usr/lib
```

So when you run:

```bash
/bin/ls
```

you are actually using:

```bash
/usr/bin/ls
```

---

## Important idea

`/bin` did not disappear completely.

It still exists as a **symbolic link**, so old scripts still work:

```bash
#!/bin/bash
```

This still works because:

```text
/bin/bash -> /usr/bin/bash
```

---

## Simple summary

Before usrmerge:

```text
/bin/ls
/usr/bin/python
/sbin/reboot
/usr/sbin/nginx
/lib/...
/usr/lib/...
```

After usrmerge:

```text
/usr/bin/ls
/usr/bin/python
/usr/sbin/reboot
/usr/sbin/nginx
/usr/lib/...
```

with compatibility links:

```text
/bin -> /usr/bin
/sbin -> /usr/sbin
/lib -> /usr/lib
```

