## 220. Managing Package Dependencies in DNF: Preventing Unintended Removals

### Automatic dependency uninstall

* `dnf` can automatically remove dependencies that are no longer needed.
* These dependencies are called **unused dependencies** or **leaf packages**.
* Example:

  * `python3-matplotlib` depends on `python3-numpy`.
  * When installing `python3-matplotlib`, `dnf` may also install `python3-numpy`.
  * If `python3-numpy` was installed only as a dependency, it may be removed later when removing `python3-matplotlib`.

### Example

```bash
sudo dnf install python3-matplotlib
```

Check that NumPy works:

```bash
python3 -c 'import numpy as np; print(np.__version__)'
```

Remove matplotlib:

```bash
sudo dnf remove python3-matplotlib
```

`dnf` may also remove `python3-numpy` if it considers it no longer needed.

---

### How to avoid automatic dependency removal

#### Method 1: Disable automatic dependency cleanup globally

Edit:

```bash
sudo nano /etc/dnf/dnf.conf
```

Add:

```ini
clean_requirements_on_remove=False
```

Now, when removing a package, `dnf` will not automatically remove unused dependencies.

Then you can clean unused dependencies manually:

```bash
sudo dnf autoremove
```

---

#### Method 2: Disable autoremove for one command only

```bash
sudo dnf remove package_name --noautoremove
```

Example:

```bash
sudo dnf remove python3-matplotlib --noautoremove
```

This removes only the selected package and avoids removing dependencies automatically.

---

### Best solution: mark important packages as manually installed

If you want to keep a dependency, mark it as manually installed.

```bash
sudo dnf mark install package_name
```

Example:

```bash
sudo dnf mark install python3-numpy
```

Now `dnf` treats `python3-numpy` as a package you installed intentionally, not only as a dependency.

So if you remove:

```bash
sudo dnf remove python3-matplotlib
```

`python3-numpy` should remain installed.

---

### Check package reason

```bash
dnf repoquery --userinstalled
```

Shows packages marked as installed by the user.

You can also check package info:

```bash
dnf history userinstalled
```

---

### Important note

In Debian/Ubuntu:

```bash
sudo apt install python3-numpy
```

usually marks the package as manually installed.

In CentOS/RHEL/Rocky Linux, installing a package that already exists as a dependency may not always change its reason to user-installed.

So in DNF, the clearer way is:

```bash
sudo dnf mark install python3-numpy
```

---

### Summary

```bash
sudo dnf remove package_name --noautoremove
```

Use this to prevent dependency removal for one command.

```bash
clean_requirements_on_remove=False
```

Use this to disable automatic dependency cleanup globally.

```bash
sudo dnf mark install package_name
```

Best method when you want to protect a specific package from being removed automatically.
