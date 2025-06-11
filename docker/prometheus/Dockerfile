FROM prom/prometheus:v2.52.0

USER root

COPY prometheus.yml.template /etc/prometheus/prometheus.yml.template
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

USER nobody

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--config.file=/etc/prometheus/prometheus.yml"]
