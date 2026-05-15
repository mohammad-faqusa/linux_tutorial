# difference between `--supplements` and `--whatsupplements`

## `--supplements`

Shows:

> what conditions THIS package supplements

Meaning:

* what package/environment must exist for this package to become useful

Example:

```bash id="n2q4vt"
dnf repoquery --supplements hunspell-de
```

Possible output:

```text
(libreoffice and langpacks-de)
```

Meaning:

* `hunspell-de` is useful when:

  * LibreOffice exists
  * German language packs exist

So this command asks:

> "what does THIS package depend on conceptually for enhancement?"

---

# `--whatsupplements`

Shows:

> which packages supplement THIS package

Meaning:

* what extra packages may automatically integrate with this package

Example:

```bash id="u6k8yx"
dnf repoquery --whatsupplements libreoffice
```

Possible output:

```text
hunspell-de
langpack-de
```

Meaning:

* these packages enhance/supplement LibreOffice

So this command asks:

> "what packages enhance THIS package?"

---

# simple mental model

## `--supplements`

Look FROM the package outward.

```text
this package supplements WHAT?
```

---

## `--whatsupplements`

Look TOWARD the package inward.

```text
WHAT packages supplement this package?
```

---

# analogy

Suppose:

* LibreOffice = phone
* hunspell-de = optional keyboard extension

## `--supplements hunspell-de`

asks:

```text
this extension works with what?
```

Answer:

```text
LibreOffice
```

---

## `--whatsupplements libreoffice`

asks:

```text
what extensions work with LibreOffice?
```

Answer:

```text
hunspell-de
```
