#Pull dependencies for enabled plugins
FROM maven:3 as deps
COPY mvn/pom.xml .
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:copy-dependencies

#Build the managed container
FROM jetty:9.4-jre8
USER root
RUN java -jar /usr/local/jetty/start.jar --add-to-start=http,logging-log4j2 --approve-all-licenses && \
    useradd nginx -G jetty 
    #&& echo "jetty.unixsocket.acceptorQueueSize=1024" >> /var/lib/jetty/start.d/unixsocket.ini

COPY --from=netroadshow/nginx-sidecar / /
COPY --from=netroadshow/fluent / /
COPY --from=deps /target/dependency/ /var/lib/jetty/lib/ext/
COPY fs/etc/ /etc/
COPY --chown=jetty:jetty fs/var/lib/jetty/ /var/lib/jetty/

ENV PROXY_URL "localhost:8080"
EXPOSE 443 80 8080
ENTRYPOINT []
CMD ["/etc/start.d/monit.sh"]
