# Prefix-based build system – Belle II GSoC 2026 evaluation

This repository contains a small, prefix-based build setup created as part of the
Belle II GSoC 2026 evaluation task.

The goal is to demonstrate how third-party dependencies and Python can be built
and isolated inside a user-controlled installation prefix, without relying on
system packages.

The following stack is built:

- XZ Utils
- libffi
- SQLite
- Python

Python depends on SQLite and libffi, forming a small but realistic dependency graph.

---

## Repository structure

```text
belle2-eval/
├── sources/     # unpacked source trees   
├── Makefile     # build orchestration
├── env.sh       # environment setup
├── README.md
└──.gitignore
```

---

## Build approach

A single installation prefix is used for all packages:

```bash
$HOME/belle2-eval/install
```

Each package is configured with:

```bash
--prefix=$(PREFIX)
```

GNU Make is used only to encode the dependency order and orchestrate the builds.
The native build systems of each package are used internally.

The dependency order is:

- xz
- libffi
- sqlite
- python

Python is built last because it links against SQLite and libffi.

---

## Forcing the use of local dependencies

During the Python build, the following variables are set:

```bash
CPPFLAGS=-I$(PREFIX)/include
LDFLAGS=-L$(PREFIX)/lib
PKG_CONFIG_PATH=$(PREFIX)/lib/pkgconfig
```

This ensures that Python is built against the locally installed libraries
and not against system libraries.

---
## Go to the repository root
```bash
cd belle2-eval
```
---
## How to build

From the repository root:

```bash
make
```

---

## Environment setup

After the build:

```bash
source env.sh
```

This activates the locally built stack by setting `PATH`,
`LD_LIBRARY_PATH` and `PKG_CONFIG_PATH`.

---
## Check python:
```
which python3
```
## Functional test

```bash
python3 -c "import sqlite3; print(sqlite3.sqlite_version)"
```

---

## Verifying that system libraries are not used

Check that the Python SQLite module uses the local SQLite library:

```bash
ldd $PREFIX/lib/python3.*/lib-dynload/_sqlite3*.so | grep sqlite
```

Check that the ctypes module uses the local libffi:

```bash
ldd $PREFIX/lib/python3.*/lib-dynload/_ctypes*.so | grep ffi
```

The printed paths must point inside the installation prefix:

```bash
$PREFIX
```

---

## Clean rebuild

```bash
make clean
make
```

---

## Changing the installation prefix

You can override the prefix when running make:

```bash
make PREFIX=$HOME/belle2-custom
```

The same prefix must also be updated in `env.sh`.

---

## Relation to the Belle II project

This prototype demonstrates the core principles required for a sustainable
externals build workflow for the Belle II software:

- explicit dependency ordering
- strict prefix-based installation
- isolation from system libraries
- reproducible and automatable builds

The same approach can be extended to larger dependency sets and to
multi-architecture environments (x86 and ARM).
