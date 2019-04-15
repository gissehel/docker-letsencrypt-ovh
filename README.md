docker-letsencrypt-ovh
======================

The container can then be started as follows:

	docker run -d \
		--restart=always \
		--name letsencrypt-ovh \
		-v /path/to/certs:/etc/letsencrypt \
		-v /path/to/config/file:/etc/update-certs/config:ro \
		-v /path/to/ovhapi/file:/etc/update-certs/.ovhapi:ro \
		-v /var/run/docker.sock:/var/run/docker.sock \
		letsencrypt-ovh

docker-letsencrypt-gandi
========================

This container generates [LetsEncrypt](https://www.letsencrypt.org) certificates for subdomains at [Gandi](https://www.ovh.com) using the DNS-01 challenge type and Gandi's new LiveDNS API. It can also send a SIGHUP signal to a [Nginx container](https://store.docker.com/images/nginx) which tells it to reload its certificates.

This image is based on Alpine and uses [Certbot](https://certbot.eff.org/) to communicate with Letsencrypt.

Based on
--------

Based on https://github.com/Roliga/docker-letsencrypt-gandi

Based on official certbot/dns-ovh image

Building
--------

Simply clone this repository and build the image:

	git clone https://github.com/gissehel/docker-letsencrypt-ovh.git
	docker build -t letsencrypt-ovh docker-letsencrypt-ovh

Configuration
-------------

Some example configuration files are provided named `config.example` and `ovhapi.example`. Copy it somewhere and add your OVH API keys (found at https://api.ovh.com/createToken/), email address and comma separated list of domain names, and optional Nginx container to tell about new certificates.

The container can then be started as follows:

	docker run -d \
		--restart=always \
		--name letsencrypt-ovh \
		-v /path/to/certs:/etc/letsencrypt \
		-v /path/to/config/file:/etc/update-certs/config:ro \
		-v /path/to/config/ovhapi:/etc/update-certs/.ovhapi:ro \
		-v /var/run/docker.sock:/var/run/docker.sock \
		gissehel/letsencrypt-ovh

The container will then generate a certificate as it starts, then check if it needs renewing every 5 days. The certificate will be available in `path/to/certs/live/`, in a directory named after the first domain specified in the config file.

Exposing the docker control socket to the container (`-v /var/run/docker.sock:/var/run/docker.sock`) is optional and only required if you want the container to be able to tell Nginx about new certificates.
