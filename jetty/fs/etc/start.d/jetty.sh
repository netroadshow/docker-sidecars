#!/bin/sh
JAVA_CMD="/docker-entrypoint.sh"
START_JETTY="su jetty -s /bin/bash -c $JAVA_CMD"
LOGFILE=/var/log/jetty.log
PIDFILE=/var/run/jetty.pid
SOCKFILE=/tmp/jetty.sock
JETTY_ROOT=/var/lib/jetty
PID=$(cat $PIDFILE)

start() {
    (
        cd $JETTY_ROOT
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
