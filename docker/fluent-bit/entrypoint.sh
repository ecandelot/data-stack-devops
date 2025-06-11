#!/bin/sh
envsubst < /fluent-bit/etc/fluent-bit.conf.template > /fluent-bit/etc/fluent-bit.conf
exec /fluent-bit/bin/fluent-bit -c /fluent-bit/etc/fluent-bit.conf
