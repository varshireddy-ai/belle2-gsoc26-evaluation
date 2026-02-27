# Prefix-based build system – Belle II GSoC 2026 evaluation

This repository contains a small, clean, prefix-based build setup created as part of the
Belle II GSoC 2026 evaluation task.

The goal of this project is to demonstrate how third-party dependencies and Python can be
built and isolated inside a user-controlled installation prefix, without relying on
system packages.

The build produces a self-contained environment that includes:

- liblzma
- sqlite3
- libffi
- Python (built against the above libraries)

All artifacts are installed into a single prefix directory.

---

## Directory layout

