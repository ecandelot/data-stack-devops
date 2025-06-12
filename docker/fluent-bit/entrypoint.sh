#!/bin/sh
set -e

cd /fluent-bit-conf

echo "Using Loki port: $LOKI_PORT"
envsubst < fluent-bit.conf.template > /fluent-bit-conf/fluent-bit.conf

echo "Generated Fluent-bit configuration:"
cat /fluent-bit-conf/fluent-bit.conf

exec fluent-bit -c /fluent-bit-conf/fluent-bit.conf
