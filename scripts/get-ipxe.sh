#!/usr/bin/env bash
# Downloads pre-built iPXE binaries from boot.ipxe.org into ./tftp/
# Run this once on the Docker host before starting the stack.
set -euo pipefail

TFTP_DIR="$(cd "$(dirname "$0")/.." && pwd)/tftp"
BASE="https://boot.ipxe.org"

echo "Downloading iPXE binaries into ${TFTP_DIR} ..."

curl -fL --progress-bar "${BASE}/undionly.kpxe"    -o "${TFTP_DIR}/undionly.kpxe"
curl -fL --progress-bar "${BASE}/ipxe.efi"         -o "${TFTP_DIR}/ipxe.efi"
curl -fL --progress-bar "${BASE}/ipxe32.efi"       -o "${TFTP_DIR}/ipxe32.efi"
curl -fL --progress-bar "${BASE}/arm64-efi/ipxe.efi" -o "${TFTP_DIR}/ipxe-arm64.efi"

echo "Done."
echo
echo "IMPORTANT: The pre-built binaries from boot.ipxe.org do not embed a"
echo "script, so they rely on DHCP to point them at boot.ipxe. This works"
echo "fine for this setup. If you need custom iPXE features (HTTPS, custom"
echo "drivers) you will need to build iPXE from source with an embedded script."
