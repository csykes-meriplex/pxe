#!/usr/bin/env bash
# Run on the Docker host to SCP the staged boot files from the Windows Server.
# Requires OpenSSH to be enabled on the Windows Server (it's available by
# default on Windows Server 2019+; enable via Settings > Optional Features).
#
# Usage: ./pull-mdt-files.sh <windows-server-ip> [username]
#   e.g. ./pull-mdt-files.sh 192.168.1.20 Administrator
set -euo pipefail

WIN_HOST=${1:?Usage: $0 <windows-server-ip> [username]}
WIN_USER=${2:-Administrator}
REMOTE_PATH="C:/MDT-PXE-Export"
DEST="$(cd "$(dirname "$0")/.." && pwd)/tftp/windows"

mkdir -p "${DEST}"

echo "Pulling boot files from ${WIN_USER}@${WIN_HOST}:${REMOTE_PATH} ..."
echo "(You will be prompted for the Windows Server password)"

scp "${WIN_USER}@${WIN_HOST}:${REMOTE_PATH}/BCD"                   "${DEST}/BCD"
scp "${WIN_USER}@${WIN_HOST}:${REMOTE_PATH}/boot.sdi"              "${DEST}/boot.sdi"
scp "${WIN_USER}@${WIN_HOST}:${REMOTE_PATH}/LiteTouchPE_x64.wim"  "${DEST}/LiteTouchPE_x64.wim"

echo ""
echo "Done. tftp/windows/ now contains:"
ls -lh "${DEST}"
