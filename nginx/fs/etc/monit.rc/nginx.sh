#!/bin/sh
BINFILE=/usr/sbin/nginx
PIDFILE=/var/run/nginx.pid
TEMPLATEBIN=/usr/bin/mustache
TEMPLATEDIR=/etc/nginx/template.d/
YAMLDIR=/etc/nginx/yaml.d/
CONFDIR=/etc/nginx/conf.d/

process_templates() {
    for filepath in $TEMPLATEDIR*; do
        filename=${filepath#$TEMPLATEDIR}
        config=${YAMLDIR}${filename}.yaml
        OVERRIDE=""
        if [ -f "$config" ]; then
            OVERRIDE="--override ${config}"
        fi
        $TEMPLATEBIN ENV $filepath ${OVERRIDE} > ${CONFDIR}${filename}
    done
}

start() {
    process_templates
    $BINFILE
}

stop() {
    $BINFILE -s stop
    while [ -f "$PIDFILE" ]
    do
        sleep 0.1
    done
}

restart() {
    process_templates
    $BINFILE -s reload
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "Usage: {start|stop|restart}" >&2
        ;;
esac
