#!/bin/bash

echo "after remove"

if test -e "/data/data_enchilada"; then
    rm -rf /data/data_enchilada
fi

if test -e "/etc/data_enchilada"; then
    rm -rf /etc/data_enchilada
fi

find /var/log -name 'data_enchilada*.log' -delete