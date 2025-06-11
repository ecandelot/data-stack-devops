#!/bin/sh
set -e
echo "Using Loki port: $LOKI_PORT"
envsubst < /fluent-bit/etc/fluent-bit.conf.template > /fluent-bit/etc/fluent-bit.conf
cat /fluent-bit/etc/fluent-bit.conf  # pour debug
exec /fluent-bit/bin/fluent-bit -c /fluent-bit/etc/fluent-bit.conf
