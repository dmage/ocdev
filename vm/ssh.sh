#!/bin/sh
exec ssh -o ConnectTimeout=2 -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 2222 cloud@localhost "$@"
