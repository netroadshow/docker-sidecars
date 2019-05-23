#!/bin/sh
JAVA_CMD="/docker-entrypoint.sh"
START_JETTY="su jetty -s /bin/sh -c $JAVA_CMD"
LOGFILE=/var/log/out
PIDFILE=/var/run/jetty.pid
PID=$(cat $PIDFILE)

start() {
    (
        cd /var/lib/jetty
        $START_JETTY >> $LOGFILE 2>> $LOGFILE &
        echo "$!" > $PIDFILE
    )
}

stop() {
    kill "$PID"
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
