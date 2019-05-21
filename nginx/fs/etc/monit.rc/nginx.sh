#!/bin/sh
BINFILE=/usr/sbin/nginx
PIDFILE=/var/run/nginx.pid

start() {
    $BINFILE &
}

stop() {
    kill -QUIT $( cat $PIDFILE )
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: {start|stop}" >&2
        ;;
esac
