#!/bin/bash

# Usage: boot.sh [ -m ]

set -e


if [[ "$1" == "-m" ]]; then
    VMLINUX="winvm.qcow2"
    GRAPHICS=1
else
    VMLINUX="winvm.cow"
    GRAPHICS=0
fi

CMD="
qemu-system-x86_64 \
-m 8G \
-cpu host \
-smp 64 \
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
    # Use VNC on localhost:5900 (display :0)
    CMD="$CMD -display none -vga virtio -vnc 127.0.0.1:0"
else
    # Headless mode
    CMD="$CMD -nographic"
fi
# Run command
eval $CMD