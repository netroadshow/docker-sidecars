#When using this as a source image, copy out /bin/monit and possibly /etc/monitrc
FROM alpine as builder

ADD fs/ /pkg/
RUN mkdir -p /pkg/etc/monit.d /pkg/usr/bin && \
    apk add --no-cache monit && \
    mv /usr/bin/monit /pkg/usr/bin/monit

FROM scratch
COPY --from=builder /pkg /
