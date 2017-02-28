FROM ubuntu:16.04
#USER root
#RUN echo "root:vagrant" | chpasswd

# Copy java client
RUN mkdir -p /usr/lib/enchilada
COPY enchilada.jar /usr/lib/enchilada/

RUN apt-get update

RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor git

RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
RUN apt-get install -y ruby2.3 ruby-dev

# Ruby app
RUN mkdir -p /var/www/apps/enchilada
#RUN git clone https://kladkogex:Galactic1@github.com/GalacticExchange/framework_templates.git
ADD ruby /var/www/apps/enchilada
RUN apt-get install -y nodejs
RUN gem install bundler


# run
RUN gem install rake json

RUN apt-get install -y libmysqlclient-dev
RUN gem install mysql2


RUN cd /var/www/apps/enchilada && bundle install




