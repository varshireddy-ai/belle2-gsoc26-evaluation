Belle II evaluation task – prefix-based dependency stack

This repository builds a small isolated software stack using GNU Make.

Packages:
- xz
- libffi
- sqlite
- Python

All packages are installed into a private prefix.

Build instructions
------------------
make all

Environment setup
-----------------
source env.sh

Test
----
which python3
python3 -c "import sqlite3"
