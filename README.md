# Prefix-based build system – Belle II GSoC 2026 evaluation

This repository contains a small, clean, prefix-based build setup created as part of the
Belle II GSoC 2026 evaluation task.

The goal of this project is to demonstrate how third-party dependencies and Python can be
built and isolated inside a user-controlled installation prefix, without relying on
system packages.

It builds and installs a minimal dependency stack consisting of:

- XZ Utils
- libffi
- SQLite
- Python

All packages are built from source and installed into a private prefix
directory. No system libraries are used at runtime.

## Directory layout


belle2-eval/
├── sources/ # unpacked source trees
├── build/ # (optional) build directory
├── install/ # installation prefix
├── Makefile
├── env.sh
└── README.md


---

## Changing the installation prefix

The installation prefix is controlled by the variable `PREFIX`.

By default it is set to:


$HOME/belle2-eval/install


You can change it either by editing `env.sh` and the Makefile, or directly
when invoking make:

```bash
make PREFIX=/your/custom/path


