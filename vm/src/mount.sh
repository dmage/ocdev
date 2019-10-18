#!/bin/sh -eux
mkdir -p ./src && sudo mount -t 9p -o trans=virtio src ./src -oversion=9p2000.L
