# Monit Source Image

This docker image contains only Monit so that it can be used to create other images.
This is published to a scratch image so the only things in it are the raw binaries.

In addition to Monit, this image contains [mustache-cli](https://github.com/quantumew/mustache-cli)
so that startup scripts can dynamically generate configuration files from the environment.

## Example

For debian based containers

```docker
FROM nginx
COPY --from=netroadshow/monit . .

# Copy service monitors to /etc/monit.d/* to start services

CMD ["/sbin/monitor.sh"]
```

For alpine based containers

```docker
FROM nginx:alpine
COPY --from=netroadshow/monit:alpine . .

# Copy service monitors to /etc/monit.d/* to start services

CMD ["/sbin/monitor.sh"]
```
