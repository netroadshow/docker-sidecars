# nginx Source Image

This docker image contains only nginx so that it can be used to create other images.
This is published to a scratch image so the only things in it are the raw binaries and configurations.

## Requirements

In order to use this image, you must:

- Provide a system openssl library to use
- Provide a user named 'nginx' or alternatively, override the nginx.conf file to have nginx use an alternate user

## Example

For debian based containers

```docker
FROM debian
RUN apt-get update && apt-get install -yy openssl && apt-get clean && useradd nginx
COPY --from=netroadshow/nginx-sidecar . .

# Install your services and whatnot here

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
