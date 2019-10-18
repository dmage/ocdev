#!/bin/sh -eu
if [ -e ./qemu.pid ]; then
    echo qemu.pid found. Please stop the qemu process, remove this file and try again. 2>&1
    ls -al "$PWD/qemu.pid"
    ps auxf | grep '[q]emu'
    exit 1
fi
./run.sh -daemonize -display none -pidfile ./qemu.pid
