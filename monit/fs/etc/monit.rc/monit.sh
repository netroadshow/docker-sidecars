#!/bin/sh
PIDFILE=/var/run/monit.pid
BINFILE=/usr/bin/monit

# Send logs that go to /var/log/out directly to stdout
ln -s /proc/1/fd/1 /var/log/out
ln -s /proc/1/fd/2 /var/log/err

# Monit will start all apps and monitor them
$BINFILE -c /etc/monitrc

COUNT=0
while ! [ -f "$PIDFILE" ]
do
   sleep 0.1
   COUNT=$(expr $COUNT + 1)
   if [ "$COUNT" -gt "100" ]; then
      echo "Monit failed the start after 10 seconds, bailing!!!"
      exit 1
   fi
done

PID=$(cat $PIDFILE)

# Catch signals
trap "kill $PID ; exit" EXIT

# Stay up and pipe logs to stdout, if monit dies though we need to exit so that docker can restart the container
while kill -0 $PID 2> /dev/null; do
   sleep 5
done

exit 1
