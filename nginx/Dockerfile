FROM nginx:1.15 as builder

COPY --from=netroadshow/monit ./ /pkg/
COPY --from=netroadshow/fluent ./ /pkg/
RUN mkdir -p /pkg/usr/sbin /pkg/usr/lib/nginx /pkg/var/log/nginx /pkg/var/cache/nginx && \
    rm /etc/nginx/conf.d/default.conf && \
    mv -f /etc/nginx /pkg/etc/nginx && \
    mv -f /usr/lib/nginx/modules /pkg/usr/lib/nginx/modules && \
    mv /usr/sbin/nginx /pkg/usr/sbin/nginx
COPY fs/ /pkg/

EXPOSE 80 443

FROM scratch
COPY --from=builder /pkg/ /
