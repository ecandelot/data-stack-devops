#!/bin/sh
set -e

echo "Using Loki port: $LOKI_PORT"
envsubst < /fluent-bit/fluent-bit.conf.template > /fluent-bit/fluent-bit.conf

# Pour le débogage, affichez le contenu du fichier généré
echo "Generated Fluent-bit configuration:"
cat /fluent-bit/fluent-bit.conf

# Exécutez Fluent-bit avec le fichier de configuration généré
exec /fluent-bit/bin/fluent-bit -c /fluent-bit/fluent-bit.conf
