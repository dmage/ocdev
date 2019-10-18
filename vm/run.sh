#!/bin/sh
exec qemu-system-x86_64 \
    -machine type=q35,accel=kvm \
    -cpu host \
    -m 2048 \
    -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
    -device virtio-net,netdev=net0 \
    -drive file="$PWD/drives/seed.iso",media=cdrom \
    -drive format=raw,file=drives/fedora.raw \
    -fsdev local,id=src,path="$HOME/src",security_model=passthrough,readonly \
    -device virtio-9p-pci,fsdev=src,mount_tag=src \
    "$@"
