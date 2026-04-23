#!/bin/sh
set -e
envsubst < /dnsmasq.conf.tpl > /etc/dnsmasq.conf
exec dnsmasq --no-daemon --log-facility=-
