#!/usr/bin/env bash
# Downloads iPXE binaries and wimboot into ./tftp/
# Run this once on the Docker host before starting the stack.
set -euo pipefail

TFTP_DIR="$(cd "$(dirname "$0")/.." && pwd)/tftp"
WIN_DIR="${TFTP_DIR}/windows"
IPXE_BASE="https://boot.ipxe.org"
WIMBOOT_URL="https://github.com/ipxe/wimboot/releases/latest/download/wimboot"

mkdir -p "${WIN_DIR}"

echo "Downloading iPXE binaries..."
curl -fL --progress-bar "${IPXE_BASE}/undionly.kpxe"      -o "${TFTP_DIR}/undionly.kpxe"
curl -fL --progress-bar "${IPXE_BASE}/ipxe.efi"           -o "${TFTP_DIR}/ipxe.efi"
curl -fL --progress-bar "${IPXE_BASE}/ipxe32.efi"         -o "${TFTP_DIR}/ipxe32.efi"
curl -fL --progress-bar "${IPXE_BASE}/arm64-efi/ipxe.efi" -o "${TFTP_DIR}/ipxe-arm64.efi"

echo "Downloading wimboot..."
curl -fL --progress-bar "${WIMBOOT_URL}" -o "${WIN_DIR}/wimboot"

echo "Done."
echo
echo "Next: run scripts/copy-mdt-files.ps1 on your Windows Server, then"
echo "      run scripts/pull-mdt-files.sh on this host to fetch BCD, boot.sdi,"
echo "      and LiteTouchPE_x64.wim into tftp/windows/."
