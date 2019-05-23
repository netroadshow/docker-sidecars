FROM jetty:9.4-jre8-alpine
USER root
RUN apk add --no-cache openssl linux-pam pcre && adduser -D nginx
COPY --from=netroadshow/nginx-sidecar:alpine / /
COPY fs/ /
RUN chown -R jetty:jetty /var/lib/jetty
ENV PROXY_URL "http://localhost:8080"
ENTRYPOINT []
CMD ["/etc/monit.rc/monit.sh"]