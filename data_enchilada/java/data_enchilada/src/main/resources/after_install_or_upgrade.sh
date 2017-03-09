#!/bin/bash

echo "after install"

SERVICE_HOME="/etc/supervisor/conf.d/data_enchilada.conf"
chown -R root /etc/data_enchilada
chown -R root /usr/lib/data_enchilada
chown -R root /data/data_enchilada
chmod -R a=rx,u=rwx /etc/data_enchilada
chmod -R a=rx,u=rwx /usr/lib/data_enchilada
chmod -R a=rwx /data/data_enchilada

cat >> $SERVICE_HOME <<EOL
[program:data_enchilada]
command=java -jar /usr/lib/data_enchilada/data_enchilada.jar
user=${SUDO_USER}
autostart=true
autorestart=true
stderr_logfile=/var/log/data_enchilada.err.log
stdout_logfile=/var/log/data_enchilada.out.log
EOL

RELEASE=$(lsb_release -r -s)
if [ "$RELEASE" = "16.04" ]; then
  systemctl enable supervisor.service
fi

service supervisor restart 
echo "Data Enchilada has been installed successfully!"




