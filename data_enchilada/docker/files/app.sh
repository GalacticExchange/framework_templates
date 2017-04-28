#!/bin/bash

source /etc/profile.d/rvm.sh;


cd /var/www/apps/data_enchilada

exec bundle exec  rails s -p 80 -e development --binding=0.0.0.0
