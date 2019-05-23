#Pull dependencies for enabled plugins
FROM maven:3-alpine as deps
COPY mvn/pom.xml .
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:copy-dependencies

#Build the managed container
FROM jetty:9.4-jre8-alpine
USER root
RUN apk add --no-cache openssl linux-pam pcre && \
    adduser -D nginx && adduser nginx jetty
COPY --from=netroadshow/nginx-sidecar:alpine / /
COPY --chown=jetty:jetty --from=deps /target/dependency/ /var/lib/jetty/lib/ext/
COPY fs/etc/ /etc/
COPY --chown=jetty:jetty fs/var/lib/jetty/ /var/lib/jetty/
ENV PROXY_URL "unix:/tmp/jetty.sock"
EXPOSE 443
ENTRYPOINT []
CMD ["/etc/monit.rc/monit.sh"]
