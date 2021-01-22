#!/usr/bin/env bash
set -euo pipefail

source dependencies.sh

git clone https://github.com/DesertRose2/BSQL --depth=1
cd BSQL

mkdir -p artifacts
cd artifacts
export CXX=g++
# The -D will be unnecessary past BSQL v1.4.0.0
cmake .. -DMARIA_LIBRARY=/usr/lib/i386-linux-gnu/libmariadb.so
make

mkdir -p ~/.byond/bin
ln -s $PWD/src/BSQL/libBSQL.so ../../libBSQL.so
ldd ../../libBSQL.so
