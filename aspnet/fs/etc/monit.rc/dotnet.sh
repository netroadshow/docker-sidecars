#!/bin/sh
DOTNET=/usr/bin/dotnet
TEMPLATEBIN=/usr/bin/mustache
APPROOT=/app/
DLLNAME=${DOTNET_DLL:-Service.dll}
LOGFILE=/var/log/out
PIDFILE=/var/run/dotnet.pid
PID=$(cat $PIDFILE)

start() {
    (
        cd $APPROOT
        $DOTNET "$DLLNAME" >> $LOGFILE 2>> $LOGFILE &
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
