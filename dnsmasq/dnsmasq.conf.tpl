# Do not use system DNS
no-resolv
no-poll

# Bind only to the interface facing the PXE network.
# Uncomment and set the correct interface name if dnsmasq picks up wrong ones.
# bind-interfaces
# interface=eth0

# DHCP range
dhcp-range=${DHCP_RANGE_START},${DHCP_RANGE_END},${SUBNET_MASK},${LEASE_TIME}

# Default gateway
dhcp-option=option:router,${GATEWAY_IP}

# DNS
dhcp-option=option:dns-server,${DNS_SERVER}

# TFTP server
enable-tftp
tftp-root=/tftp

# -----------------------------------------------------------------------
# Architecture detection
# Clients send DHCP option 93 (client-arch) to identify their firmware.
# We set a tag and use it to serve the right iPXE binary.
# -----------------------------------------------------------------------

# BIOS (arch 0)
dhcp-match=set:bios,option:client-arch,0

# UEFI 32-bit (arch 6)
dhcp-match=set:efi32,option:client-arch,6

# UEFI 64-bit (arch 7) — most modern hardware
dhcp-match=set:efi64,option:client-arch,7

# UEFI ARM64 (arch 11)
dhcp-match=set:efi-arm64,option:client-arch,11

# -----------------------------------------------------------------------
# iPXE loop prevention
# Once a client is running iPXE it sends user-class "iPXE" in its DHCP
# request. We detect this and serve the HTTP menu instead of the binary,
# preventing an infinite chainload loop.
# -----------------------------------------------------------------------
dhcp-userclass=set:ipxe,iPXE

# Boot file selection (tag:!ipxe = client NOT yet running iPXE)
dhcp-boot=tag:bios,tag:!ipxe,undionly.kpxe,pxeserver,${DOCKER_HOST_IP}
dhcp-boot=tag:efi32,tag:!ipxe,ipxe32.efi,pxeserver,${DOCKER_HOST_IP}
dhcp-boot=tag:efi64,tag:!ipxe,ipxe.efi,pxeserver,${DOCKER_HOST_IP}
dhcp-boot=tag:efi-arm64,tag:!ipxe,ipxe-arm64.efi,pxeserver,${DOCKER_HOST_IP}

# Once iPXE is running, hand it the menu script
dhcp-boot=tag:ipxe,http://${DOCKER_HOST_IP}/boot/boot.ipxe

# Verbose logging (remove for quieter logs once stable)
log-dhcp
log-queries
