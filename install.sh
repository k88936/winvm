#!/bin/bash

# === Configuration ===
# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOT_SCRIPT="$SCRIPT_DIR/boot.sh"
# 设置服务文件路径
SERVICE_FILE="/etc/systemd/system/winvm.service"


echo "Installing Windows VM..."


# 检查 boot.sh 是否存在
if [ ! -f "$BOOT_SCRIPT" ]; then
    echo "❌ 错误：$BOOT_SCRIPT 不存在！请确认该文件存在。"
    exit 1
fi

# 写入服务单元文件内容
cat <<EOF > $SERVICE_FILE
[Unit]
Description=Windows VM via QEMU
After=network.target

[Service]
ExecStart=$BOOT_SCRIPT
WorkingDirectory=$SCRIPT_DIR
User=root
RemainAfterExit=no
Restart=on-failure
RestartSec=5s
TimeoutSec=300

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Enable and start service
sudo systemctl enable winvm
sudo systemctl start winvm

echo "✅ Installation complete!"
