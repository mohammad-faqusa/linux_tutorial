## 241. Customizing systemd Unit Files (Part 1)

### customizing unit files

sometimes we want to:

* modify startup behavior
* change dependencies
* alter restart policies
* add environment variables
* change install targets

for this:

* we can customize unit files

---

## important concept: unit file precedence

systemd searches unit files in multiple directories

priority order:

1. `/etc/systemd/system`
2. `/run/systemd/system`
3. `/usr/lib/systemd/system`
   or:
4. `/lib/systemd/system`

higher directories override lower ones

---

## default packaged unit files

usually stored in:

```text id="jlwm90"
/usr/lib/systemd/system/
```

or:

```text id="jlwm91"
/lib/systemd/system/
```

these files:

* belong to packages
* may be overwritten during updates

therefore:

```text id="jlwm92"
we should NOT edit them directly
```

---

## manual customization approach

copy original unit:

```bash id="’wini93"
sudo cp /lib/systemd/system/apache2.service \
/etc/systemd/system/
```

now:

* `/etc/systemd/system/apache2.service`
  takes precedence

---

## checking loaded unit source

before reload:

```bash id="jlwm94"
systemctl cat apache2.service
```

may still show:

```text id="’wini95"
/lib/systemd/system/apache2.service
```

because:

* systemd caches unit definitions

---

## reload systemd configuration

after modifying or copying unit files:

```bash id="’wini96"
sudo systemctl daemon-reload
```

this:

* reloads unit database
* rescans directories
* updates cached definitions

---

## verify updated path

after reload:

```bash id="’wini97"
systemctl cat apache2.service
```

should now show:

```text id="’wini98"
/etc/systemd/system/apache2.service
```

---

## editing customized unit

example:

```bash id="’wini99"
sudo nano /etc/systemd/system/apache2.service
```

---

## example modification

change:

```ini id="mov100"
[Install]
WantedBy=multi-user.target
```

to:

```ini id="mov101"
WantedBy=graphical.target
```

meaning:

* apache2 starts when graphical target loads

---

## why daemon-reload alone is not enough

important distinction:

### `daemon-reload`

only reloads unit definitions

it does NOT:

* recreate enable symlinks
* update installation state

---

## after changing `[Install]`

must:

1. disable unit
2. enable unit again

example:

```bash id="mov102"
sudo systemctl disable apache2.service
sudo systemctl enable apache2.service
```

this recreates:

```text id="mov103"
/etc/systemd/system/*.wants/
```

symlinks according to new configuration

---

## full workflow example

copy unit:

```bash id="mov104"
sudo cp /lib/systemd/system/apache2.service \
/etc/systemd/system/
```

edit:

```bash id="mov105"
sudo nano /etc/systemd/system/apache2.service
```

reload:

```bash id="mov106"
sudo systemctl daemon-reload
```

recreate install symlinks:

```bash id="mov107"
sudo systemctl disable apache2.service
sudo systemctl enable apache2.service
```

restart service:

```bash id="mov108"
sudo systemctl restart apache2.service
```

---

## inspecting symlinks

example:

```bash id="mov109"
ls -l /etc/systemd/system/graphical.target.wants/
```

you may see:

```text id="mov110"
apache2.service -> /etc/systemd/system/apache2.service
```

---

## removing custom changes

remove overridden unit:

```bash id="mov111"
sudo rm /etc/systemd/system/apache2.service
```

reload:

```bash id="mov112"
sudo systemctl daemon-reload
```

systemd falls back to:

```text id="mov113"
/lib/systemd/system/apache2.service
```

or:

```text id="mov114"
/usr/lib/systemd/system/apache2.service
```

---

## verify fallback

```bash id="mov115"
systemctl cat apache2.service
```

should now point back to original packaged unit

---

## important best practice

copying full unit files:

* works
* but not ideal for small modifications

because:

* package updates to original unit are no longer inherited

better method:

```text id="mov116"
drop-in overrides
```

using:

```bash id="mov117"
systemctl edit
```

covered later

---

## difference between approaches

### full copy override

pros:

* complete control

cons:

* harder maintenance
* misses package updates

---

### drop-in override

pros:

* safer
* cleaner
* inherits upstream changes

cons:

* slightly more advanced

---

## common reasons to customize units

* change startup order
* add environment variables
* adjust restart behavior
* limit resources
* run under different user
* modify ExecStart
* add dependencies

---

## important commands summary

copy unit:

```bash id="mov118"
sudo cp /lib/systemd/system/apache2.service \
/etc/systemd/system/
```

reload systemd:

```bash id="mov119"
sudo systemctl daemon-reload
```

edit unit:

```bash id="mov120"
sudo nano /etc/systemd/system/apache2.service
```

disable:

```bash id="mov121"
sudo systemctl disable apache2.service
```

enable:

```bash id="mov122"
sudo systemctl enable apache2.service
```

restart:

```bash id="mov123"
sudo systemctl restart apache2.service
```

view active unit:

```bash id="mov124"
systemctl cat apache2.service
```

remove override:

```bash id="mov125"
sudo rm /etc/systemd/system/apache2.service
```
