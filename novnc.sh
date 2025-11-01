#!/bin/bash

# Simple noVNC launcher to access QEMU's VNC display via browser
# Defaults:
#   - Listens on 0.0.0.0:6080 (configurable via LISTEN_PORT)
#   - Proxies to 127.0.0.1:5900 (configurable via VNC_TARGET)

set -euo pipefail

LISTEN_PORT=${LISTEN_PORT:-6080}
VNC_TARGET=${VNC_TARGET:-127.0.0.1:5900}

if ! command -v novnc >/dev/null 2>&1; then
  echo "Error: 'novnc' command not found. Install it (e.g., 'apt install novnc websockify') and retry." >&2
  exit 1
fi

# Determine primary IP for convenience (may be blank in some environments)
HOST_IP=$(hostname -I 2>/dev/null | awk '{print $1}')

echo "Starting noVNC..."
if [[ -n "${HOST_IP}" ]]; then
  echo "Open: http://${HOST_IP}:${LISTEN_PORT}/vnc.html?host=${HOST_IP}&port=${LISTEN_PORT}"
else
  echo "noVNC listening on port ${LISTEN_PORT}. If connecting remotely, replace HOST with this machine's IP."
fi

exec novnc --listen "0.0.0.0:${LISTEN_PORT}" --vnc "${VNC_TARGET}"
