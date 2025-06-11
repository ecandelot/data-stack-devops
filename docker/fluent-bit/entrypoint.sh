#!/bin/sh
set -e

echo "Using Loki port: $LOKI_PORT"
envsubst < /docker/fluent-bit/fluent-bit.conf.template > /docker/fluent-bit/fluent-bit.conf

# Pour le débogage, affichez le contenu du fichier généré
echo "Generated Fluent-bit configuration:"
cat /docker/fluent-bit/fluent-bit.conf

# Exécutez Fluent-bit avec le fichier de configuration généré
exec /fluent-bit/bin/fluent-bit -c /docker/fluent-bit/fluent-bit.conf
