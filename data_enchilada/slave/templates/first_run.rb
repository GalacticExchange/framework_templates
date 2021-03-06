dexec "/bin/bash -c 'echo \"export TERM=xterm\" >> /etc/bash.bashrc'"
dexec 'chown -R mysql /var/lib/mysql'
dexec 'service mysql start'
dexec "mysql -e \"CREATE USER 'enchilada'@'localhost' IDENTIFIED BY 'Galactic1';\""
dexec "mysql -e \"GRANT ALL PRIVILEGES ON *.* TO 'enchilada'@'localhost';\""
dexec "/bin/bash -c 'source /etc/profile.d/rvm.sh; cd /var/www/apps/data_enchilada/config; rake db:create'"
dexec "/bin/bash -c 'source /etc/profile.d/rvm.sh; cd /var/www/apps/data_enchilada/config; rake db:migrate'"
dexec "/bin/bash -c 'source /etc/profile.d/rvm.sh; cd /var/www/apps/data_enchilada; rake agent:fill_types'"