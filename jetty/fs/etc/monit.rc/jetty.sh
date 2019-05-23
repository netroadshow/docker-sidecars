#!/bin/sh
JAVA_CMD="/docker-entrypoint.sh"
START_JETTY="su jetty -s /bin/sh -c $JAVA_CMD"
LOGFILE=/var/log/out
ERRLOGFILE=/var/log/err
PIDFILE=/var/run/jetty.pid
SOCKFILE=/tmp/jetty.sock
JETTY_ROOT=/var/lib/jetty
PID=$(cat $PIDFILE)

start() {
    (
        cd $JETTY_ROOT
        $START_JETTY >> $LOGFILE 2>> $ERRLOGFILE &
        echo "$!" > $PIDFILE
    )
    count=0
    until chmod 770 $SOCKFILE || (( count++ >= 60 )); do sleep 0.5; done
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
