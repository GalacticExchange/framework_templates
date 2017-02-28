#!/bin/bash

echo "after remove"

if test -e "/data/enchilada"; then
    rm -rf /data/enchilada
fi

if test -e "/etc/enchilada"; then
    rm -rf /etc/enchilada
fi

find /var/log -name 'enchilada*.log' -delete