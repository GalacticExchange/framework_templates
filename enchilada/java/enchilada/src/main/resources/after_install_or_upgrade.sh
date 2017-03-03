#!/bin/bash

echo "after install"

SERVICE_HOME="/etc/supervisor/conf.d/enchilada.conf"
chown -R root /etc/enchilada
chown -R root /usr/lib/enchilada
chown -R root /data/enchilada
chmod -R a=rx,u=rwx /etc/enchilada
chmod -R a=rx,u=rwx /usr/lib/enchilada
chmod -R a=rwx /data/enchilada

cat >> $SERVICE_HOME <<EOL
[program:enchilada]
command=java -jar /usr/lib/enchilada/enchilada.jar
user=${SUDO_USER}
autostart=true
autorestart=true
stderr_logfile=/var/log/enchilada.err.log
stdout_logfile=/var/log/enchilada.out.log
EOL

RELEASE=$(lsb_release -r -s)
if [ "$RELEASE" = "16.04" ]; then
  systemctl enable supervisor.service
fi

service supervisor restart 
echo "Enchilada has been installed successfully!"




