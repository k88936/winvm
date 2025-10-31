#!/bin/bash

# Usage: boot.sh [ --debug ]

set -e

# Default: no graphics
VMLINUX="winvm.qcow2"
VMLINUX="winvm.cow"

GRAPHICS=0
if [[ "$1" == "--debug" ]]; then
    GRAPHICS=1
fi

CMD="
qemu-system-x86_64 \
-m 4G \
-cpu host \
-smp 16 \
-enable-kvm \
-boot order=d \
-drive file=$VMLINUX,format=qcow2,if=none,id=disk0 \
-device virtio-blk-pci,drive=disk0 \
-device virtio-balloon-pci,id=balloon0 \
-nic user,model=virtio-net-pci,hostfwd=tcp::21022-:22 \
-device usb-ehci,id=usb,bus=pci.0 \
-device usb-tablet \
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

