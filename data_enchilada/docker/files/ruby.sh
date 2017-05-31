#!/bin/bash

\curl -sSL https://get.rvm.io | bash -s stable

source /etc/profile.d/rvm.sh

echo "source /etc/profile.d/rvm.sh" >> /etc/bash.bashrc

rvm install ruby-2.3.3

rvm use --default 2.3.3

gem install bundle bundler rake mysql2

# fluent plugin
rvm wrapper ruby-2.3.3 boot fluentd

cd /var/www/apps/data_enchilada && bundle install
