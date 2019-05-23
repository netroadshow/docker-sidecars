FROM debian:stretch-slim
COPY --from=fluent/fluent-bit:1.1 /fluent-bit/etc/ /etc/fluent/
COPY --from=fluent/fluent-bit:1.1 /fluent-bit/bin/fluent-bit /bin/fluent-bit
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/*sasl* /usr/lib/x86_64-linux-gnu/
#COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/libz* /usr/lib/x86_64-linux-gnu/
#COPY --from=fluent/fluent-bit:1.1 /lib/x86_64-linux-gnu/libz* /lib/x86_64-linux-gnu/
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/libssl.so* /usr/lib/x86_64-linux-gnu/
COPY --from=fluent/fluent-bit:1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so* /usr/lib/x86_64-linux-gnu/
COPY fs/ /

CMD ["/bin/fluent-bit", "-c", "/etc/fluent/fluent-bit.conf"]
