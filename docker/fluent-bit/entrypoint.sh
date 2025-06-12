#!/bin/sh
set -e

cd /docker/fluent-bit

echo "Using Loki port: $LOKI_PORT"
envsubst < fluent-bit.conf.template > fluent-bit.conf

echo "Generated Fluent-bit configuration:"
cat fluent-bit.conf

# Exécute Fluent Bit avec la configuration générée
exec fluent-bit -c /docker/fluent-bit/fluent-bit.conf
