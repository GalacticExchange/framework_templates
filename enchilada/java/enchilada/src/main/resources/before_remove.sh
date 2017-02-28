#!/bin/bash

echo "before remove"

if test -e "/etc/supervisor/conf.d/enchilada.conf"; then
    supervisorctl stop enchilada
    supervisorctl remove enchilada
    rm /etc/supervisor/conf.d/enchilada.conf
fi





