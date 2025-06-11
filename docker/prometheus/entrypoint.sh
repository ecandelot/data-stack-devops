#!/bin/sh

# Remplacement des variables d'environnement dans le template
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Démarrage de Prometheus avec le fichier généré
exec /bin/prometheus "$@"
