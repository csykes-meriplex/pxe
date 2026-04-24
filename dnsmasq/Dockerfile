FROM alpine:3.20

RUN apk add --no-cache dnsmasq gettext ipxe wget

# Download wimboot at build time so startup doesn't need internet access
RUN wget -q -O /usr/share/ipxe/wimboot \
    "https://github.com/ipxe/wimboot/releases/latest/download/wimboot"

COPY dnsmasq.conf.tpl /dnsmasq.conf.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
