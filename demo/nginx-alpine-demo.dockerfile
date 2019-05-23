FROM alpine
RUN apk add --no-cache openssl linux-pam pcre && adduser -D nginx
COPY --from=netroadshow/nginx-sidecar:alpine / /
CMD ["/etc/monit.rc/monit.sh"]
