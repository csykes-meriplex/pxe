FROM alpine:3.20
RUN apk add --no-cache dnsmasq gettext
COPY dnsmasq.conf.tpl /dnsmasq.conf.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
