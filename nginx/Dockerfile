FROM nginx:1.15

COPY --from=monitor ["/usr/bin/monit", "/usr/bin/monit"]
COPY --from=monitor ["/etc/monitrc", "/etc/monitrc"]
COPY --from=monitor ["/sbin/monitor.sh", "/sbin/monitor.sh"]

RUN mkdir -p /etc/monit.d
COPY nginx.rc /etc/monit.d/nginx.rc
COPY ["start_nginx.sh", "stop_nginx.sh", "/sbin/"]

CMD ["/sbin/monitor.sh"]
