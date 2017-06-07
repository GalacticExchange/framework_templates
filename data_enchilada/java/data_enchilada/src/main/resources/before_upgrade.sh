#!/bin/bash

echo "before upgrade"

PROC_PID=$(ps o pid,cmd -C java |grep data_enchilada)
if [ ! -z "$PROC_PID" ]; then
  supervisorctl stop data_enchilada
fi

supervisorctl update

PROC_PID=$(supervisorctl avail | grep data_enchilada)
if [ ! -z "$PROC_PID" ]; then
  supervisorctl remove data_enchilada
fi

if test -e "/etc/supervisor/conf.d/data_enchilada.conf"; then
    rm /etc/supervisor/conf.d/data_enchilada.conf
fi




