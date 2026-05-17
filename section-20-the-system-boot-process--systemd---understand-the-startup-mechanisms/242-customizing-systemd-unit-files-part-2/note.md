## 242. Customizing systemd Unit Files (Part 2)

### better way to customize unit files

instead of:

* copying the whole unit file

we usually use:

```text id="ovr001"
drop-in override files
```

managed with:

```bash id="ovr002"
systemctl edit
```

this is:

* cleaner
* safer
* recommended by systemd

---

## why overrides are better

advantages:

* only override changed settings
* keep original packaged unit untouched
* package updates still apply
* easier maintenance
* smaller configuration files

---

## viewing current configuration

```bash id="ovr003"
sudo systemctl cat apache2.service
```

shows:

* original unit
* all overrides merged together

---

## editing with override mechanism

```bash id="ovr004"
sudo systemctl edit apache2.service
```

this opens editor automatically

---

## what happens internally

systemd creates:

```text id="ovr005"
/etc/systemd/system/apache2.service.d/
```

inside it:

```text id="ovr006"
override.conf
```

example:

```text id="ovr007"
/etc/systemd/system/apache2.service.d/override.conf
```

---

## important concept

original unit remains:

```text id="ovr008"
/usr/lib/systemd/system/apache2.service
```

override file only modifies selected options

systemd merges:

1. original unit
2. override files

together dynamically

---

## example override

open editor:

```bash id="ovr009"
sudo systemctl edit apache2.service
```

add:

```ini id="ovr010"
[Install]
WantedBy=graphical.target
```

save and exit

---

## viewing merged configuration

```bash id="ovr011"
sudo systemctl cat apache2.service
```

you will see:

* original file
* override file appended

example:

```text id="ovr012"
# /etc/systemd/system/apache2.service.d/override.conf
```

---

## important behavior of list directives

problem:

```ini id="ovr013"
[Install]
WantedBy=graphical.target
```

does NOT replace existing value

instead:

* appends new value

result:

```text id="ovr014"
WantedBy=multi-user.target
WantedBy=graphical.target
```

service becomes wanted by BOTH targets

---

## how to replace existing list values

must first clear list:

```ini id="ovr015"
[Install]
WantedBy=
WantedBy=graphical.target
```

---

## explanation

### empty assignment

```ini id="ovr016"
WantedBy=
```

clears inherited values

---

### second assignment

```ini id="ovr017"
WantedBy=graphical.target
```

adds new value only

---

## apply installation changes

after changing `[Install]`:

```bash id="ovr018"
sudo systemctl disable apache2.service
sudo systemctl enable apache2.service
```

required because:

* symlink structure must be recreated

---

## why daemon-reload alone is insufficient

```bash id="ovr019"
sudo systemctl daemon-reload
```

only:

* reloads unit definitions

it does NOT:

* recreate `.wants/` symlinks

---

## checking symlink locations

example:

```bash id="ovr020"
ls -l /etc/systemd/system/*.wants/
```

---

## viewing override files directly

```bash id="ovr021"
ls /etc/systemd/system/apache2.service.d/
```

view contents:

```bash id="ovr022"
cat /etc/systemd/system/apache2.service.d/override.conf
```

---

## removing overrides

automatic cleanup:

```bash id="ovr023"
sudo systemctl revert apache2.service
```

removes:

* override files
* customizations

restores packaged defaults

---

## manual removal

```bash id="ovr024"
sudo rm -r /etc/systemd/system/apache2.service.d
```

then:

```bash id="ovr025"
sudo systemctl daemon-reload
```

---

## overriding other settings

example:

```ini id="ovr026"
[Service]
Restart=always
MemoryMax=500M
Environment=APP_ENV=production
```

---

## overriding ExecStart

special case:

* must clear first

example:

```ini id="ovr027"
[Service]
ExecStart=
ExecStart=/opt/myapp/start.sh
```

because:

* `ExecStart` is also a list-type directive

---

## checking effective configuration

very useful command:

```bash id="ovr028"
systemd-analyze cat-config apache2.service
```

shows:

* fully merged final configuration
* source locations
* override order

---

## full workflow example

edit:

```bash id="ovr029"
sudo systemctl edit apache2.service
```

contents:

```ini id="ovr030"
[Install]
WantedBy=
WantedBy=graphical.target
```

reload:

```bash id="ovr031"
sudo systemctl daemon-reload
```

recreate symlinks:

```bash id="ovr032"
sudo systemctl disable apache2.service
sudo systemctl enable apache2.service
```

verify:

```bash id="ovr033"
systemctl cat apache2.service
```

---

## override precedence

priority order:

1. `/etc/systemd/system/*.d/`
2. `/etc/systemd/system/`
3. `/run/systemd/system/`
4. `/usr/lib/systemd/system/`

higher overrides lower

---

## useful commands summary

view merged config:

```bash id="ovr034"
systemctl cat apache2.service
```

create override:

```bash id="ovr035"
sudo systemctl edit apache2.service
```

reload config:

```bash id="ovr036"
sudo systemctl daemon-reload
```

recreate symlinks:

```bash id="ovr037"
sudo systemctl disable apache2.service
sudo systemctl enable apache2.service
```

view override directory:

```bash id="ovr038"
ls /etc/systemd/system/apache2.service.d/
```

remove overrides:

```bash id="ovr039"
sudo systemctl revert apache2.service
```

show final merged config:

```bash id="ovr040"
systemd-analyze cat-config apache2.service
```
