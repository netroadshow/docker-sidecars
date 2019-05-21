#!/bin/sh
BINFILE=/usr/sbin/nginx
PIDFILE=/var/run/nginx.pid

start() {
    $BINFILE &
}

stop() {
    $BINFILE -s stop
}

restart() {
    stop
    start
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
