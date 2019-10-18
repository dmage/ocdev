#!/bin/sh -eu
PID=$(cat ./qemu.pid)
if ./ssh.sh sudo shutdown -h now; then
    sleep 2 || true
    kill "$PID" && sleep 1 || true
else
    kill "$PID" && sleep 1
fi
! kill -0 "$PID" 2>/dev/null
rm ./qemu.pid
echo "Successfully stopped" >&2
