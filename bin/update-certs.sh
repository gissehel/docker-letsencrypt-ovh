#!/bin/sh

[[ -f /etc/update-certs/config ]] && . /etc/update-certs/config


while true; do
    for domain_group in ${DOMAINS}
    do
        certbot certonly \
            --dns-ovh \
            --dns-ovh-credentials /etc/update-certs/.ovhapi \
            --expand \
            --agree-tos \
            --no-eff-email \
            --non-interactive \
            --preferred-challenges=dns \
            --post-hook reload-nginx.sh \
            --email "$EMAIL" \
            -d "${domain_group}" \
            --server https://acme-v02.api.letsencrypt.org/directory
            "$@"
    done
    sleep 5d
done
