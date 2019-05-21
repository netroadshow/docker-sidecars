#!/bin/sh

# Monit will start all apps and monitor them
/usr/bin/monit -c /etc/monitrc

# Catch signals
trap "kill $(cat /var/run/monit.pid) ; exit" EXIT

# Stay up for container to stay alive
while [ 1 ] ; do
   sleep 1d
done
