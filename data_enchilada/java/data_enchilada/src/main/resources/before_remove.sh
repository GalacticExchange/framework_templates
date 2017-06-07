#!/bin/bash

echo "before remove"

if test -e "/etc/supervisor/conf.d/data_enchilada.conf"; then
    supervisorctl stop data_enchilada
    supervisorctl remove data_enchilada
    rm /etc/supervisor/conf.d/data_enchilada.conf
fi





