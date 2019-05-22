# nginx Source Image

This docker image contains only monit and nginx so that it can be used to create other images.
This is published to a scratch image so the only things in it are the raw binaries and configurations.

## Requirements

In order to use this image, you must:

- Provide a system openssl library to use
- Provide a user named 'nginx' or alternatively, override the nginx.conf file to have nginx use an alternate user
- A non-secret SSL/TLS cert is provided at /etc/nginx/ssl/cert.{key|crt} **that should be replaced!**

## Details

The default init script uses mustache-cli from the [monit source](../monit/README.md) with a default config template
to quickly generate a configuration file on startup. The default config can be overridden with these options:

- **PROXY_URL**: The URL to pass to proxy_pass.
- **SSL_CERT**: The location of the SSL cert.
- **SSL_KEY**: The location of the SSL key.

Default values [can be seen here.](./fs/etc/nginx/yaml.d/default.conf.yaml).

Default template [can be seen here.](./fs/etc/nginx/template.d/default.conf)

## Example

For debian based containers

```docker
FROM debian
RUN apt-get update && apt-get install -yy openssl && apt-get clean && useradd nginx
COPY --from=netroadshow/nginx-sidecar . .

# Install your services and whatnot here
ENV PROXY_URL "http://servicepath:3333" # Override the default proxy url, this could also be a path to a sock file

CMD ["/etc/monit.rc/monit.sh"]
```

For alpine based containers

```docker
FROM alpine
RUN apk add --no-cache openssl linux-pam pcre && adduser -D nginx
COPY --from=netroadshow/nginx-sidecar:alpine . .

# Install your services and whatnot here

CMD ["/etc/monit.rc/monit.sh"]
```
