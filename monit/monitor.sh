#!/bin/bash

# Monit will start all apps and monitor them
monit -c /etc/monitrc

# Catch signals
trap "kill $(cat /var/run/monit.pid) ; exit" EXIT SIGINT SIGTERM

# Stay up for container to stay alive
tail -F --pid=$(cat /var/run/monit.pid) -s 1 /var/log/monit.log
