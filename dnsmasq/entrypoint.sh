#!/bin/sh
set -e

# Copy iPXE binaries and wimboot into the TFTP volume on first run
mkdir -p /tftp/windows
cp -n /usr/share/ipxe/undionly.kpxe  /tftp/undionly.kpxe       2>/dev/null || true
cp -n /usr/share/ipxe/ipxe.efi       /tftp/ipxe.efi            2>/dev/null || true
cp -n /usr/share/ipxe/wimboot        /tftp/windows/wimboot      2>/dev/null || true

envsubst < /dnsmasq.conf.tpl > /etc/dnsmasq.conf
exec dnsmasq --no-daemon --log-facility=-
