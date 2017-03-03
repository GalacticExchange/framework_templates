#!/bin/bash

echo "before upgrade"

PROC_PID=$(ps o pid,cmd -C java |grep enchilada)
if [ ! -z "$PROC_PID" ]; then
  supervisorctl stop enchilada
fi

supervisorctl update

PROC_PID=$(supervisorctl avail | grep enchilada)
if [ ! -z "$PROC_PID" ]; then
  supervisorctl remove enchilada
fi

if test -e "/etc/supervisor/conf.d/enchilada.conf"; then
    rm /etc/supervisor/conf.d/enchilada.conf
fi




