FROM debian:stable-slim
RUN apt-get update && apt-get install -yy openssl && apt-get clean && \
    useradd nginx && useradd fluent
COPY --from=netroadshow/nginx-sidecar / /
ENV PROXY_URL "localhost:3333"
CMD ["/etc/start.d/monit.sh"]
