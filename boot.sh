#!/bin/bash

# Usage: boot.sh [ --debug ]

set -e

# Default: no graphics
GRAPHICS=0
VMLINUX="win10.qcow2"
OVMF="OVMF.4m.fd"

if [[ "$1" == "--debug" ]]; then
    GRAPHICS=1
    VMLINUX="win10.qcow2"
    OVMF="OVMF.4m.fd"
fi



CMD="/usr/bin/qemu-system-x86_64 \


    -smp 64 \
    -enable-kvm \
    -m 8G \
    -drive file=$VMLINUX,format=qcow2,if=none,id=disk0 \
    -drive if=pflash,format=raw,file=$OVMF \
    -netdev user,id=net0,hostfwd=tcp::21022-:22 \
    -device e1000,netdev=net0 \
    -device virtio-blk-pci,drive=disk0 \
    -device virtio-balloon-pci,id=balloon0 \
    "

if [[ $GRAPHICS -eq 1 ]]; then
    # Enable graphical output (for debugging)
    CMD="$CMD -vga qxl -display gtk"
else
    # Headless mode
    CMD="$CMD -nographic"
fi

# Run command
eval $CMD

