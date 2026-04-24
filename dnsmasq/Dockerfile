FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    dnsmasq \
    gettext-base \
    ipxe \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download wimboot at build time so startup doesn't need internet access
RUN wget -q -O /usr/lib/ipxe/wimboot \
    "https://github.com/ipxe/wimboot/releases/latest/download/wimboot"

COPY dnsmasq.conf.tpl /dnsmasq.conf.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
