#!/bin/bash

# === Configuration ===
# 设置服务文件路径
SERVICE_FILE="/etc/systemd/system/winvm.service"

echo "Uninstalling Windows VM..."

# Stop and disable service
if systemctl is-active --quiet winvm; then
    sudo systemctl stop winvm
fi
sudo systemctl disable winvm

# Remove service file
if [ -f "$SERVICE_DST" ]; then
    sudo rm "$SERVICE_DST"
    echo "Removed systemd service."
else
    echo "Service not found, skipping removal."
fi

# Reload systemd
sudo systemctl daemon-reload

echo "✅ Uninstallation complete!"

