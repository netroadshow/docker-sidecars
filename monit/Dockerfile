#When using this as a source image, copy out /bin/monit and possibly /etc/monitrc
FROM debian as builder

ADD fs/ /pkg/
ENV MONIT_VER 5.25.3

ADD https://mmonit.com/monit/dist/binary/${MONIT_VER}/monit-${MONIT_VER}-linux-x64.tar.gz .
RUN mkdir -p /pkg/etc/monit.d /pkg/usr/bin && \
    tar -xvzf monit-${MONIT_VER}-linux-x64.tar.gz monit-${MONIT_VER}/bin/monit && \
    mv /monit-${MONIT_VER}/bin/monit /pkg/usr/bin/monit && \
    rm -rf monit-${MONIT_VER}/ monit-${MONIT_VER}-linux-x64.tar.gz

FROM scratch
COPY --from=builder /pkg /
