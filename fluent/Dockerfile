FROM debian:stretch-slim as builder
COPY --from=fluent/fluent-bit:1.1 /fluent-bit/etc/ /pkg/etc/fluent/
COPY --from=fluent/fluent-bit:1.1 /fluent-bit/bin/fluent-bit /pkg/bin/fluent-bit
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/libssl.so* /pkg/usr/lib/x86_64-linux-gnu/
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so* /pkg/usr/lib/x86_64-linux-gnu/
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/*sasl* /pkg/usr/lib/x86_64-linux-gnu/
COPY fs/ /pkg/

FROM scratch
COPY --from=builder /pkg/ /
