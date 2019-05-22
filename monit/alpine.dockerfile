FROM golang:alpine as templates
RUN apk add --no-cache git
RUN go get github.com/quantumew/mustache-cli

#When using this as a source image, copy out /bin/monit and possibly /etc/monitrc
FROM alpine as builder
ADD fs/ /pkg/
RUN mkdir -p /pkg/etc/monit.d /pkg/usr/bin && \
    apk add --no-cache monit && \
    mv /usr/bin/monit /pkg/usr/bin/monit

FROM scratch
COPY --from=builder /pkg /
COPY --from=templates /go/bin/mustache-cli /usr/bin/mustache
