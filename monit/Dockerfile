FROM golang as templates
RUN go get github.com/quantumew/mustache-cli

#When using this as a source image, copy out /bin/monit and possibly /etc/monitrc
FROM debian as builder
ENV MONIT_VER 5.25.3

RUN apt-get update && apt-get install -yy wget && \
    wget https://mmonit.com/monit/dist/binary/${MONIT_VER}/monit-${MONIT_VER}-linux-x64.tar.gz && \
    mkdir -p /pkg/etc/monit.d /pkg/usr/bin && \
    tar -xvzf monit-${MONIT_VER}-linux-x64.tar.gz monit-${MONIT_VER}/bin/monit && \
    mv /monit-${MONIT_VER}/bin/monit /pkg/usr/bin/monit && \
    rm -rf monit-${MONIT_VER}/ monit-${MONIT_VER}-linux-x64.tar.gz

ADD fs/ /pkg/

FROM scratch
COPY --from=builder /pkg /
COPY --from=templates /go/bin/mustache-cli /usr/bin/mustache
