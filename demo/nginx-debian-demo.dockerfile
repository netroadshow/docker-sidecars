FROM debian:stable-slim
RUN apt-get update && apt-get install -yy openssl && apt-get clean && useradd nginx
COPY --from=netroadshow/nginx-sidecar / /
ENV PROXY_URL "http://localhost:3333"
CMD ["/etc/monit.rc/monit.sh"]
