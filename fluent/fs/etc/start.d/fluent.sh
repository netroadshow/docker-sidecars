#!/bin/sh
TEMPLATEBIN=/usr/bin/mustache
BINFILE=/bin/fluent-bit
CONFFILE=/etc/fluent/fluent-bit.conf
USER=fluent
STARTCMD="$BINFILE -c $CONFFILE"
LOGFILE=/dev/null
PIDFILE=/var/run/fluent.pid
PID=$(cat $PIDFILE 2>> /dev/null)

start() {
    (
        $STARTCMD >> $LOGFILE 2>> $LOGFILE &
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
