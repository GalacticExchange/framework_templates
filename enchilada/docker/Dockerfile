FROM ubuntu:16.04


ENV RAILS_ENV production
ENV RACK_ENV production
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $JAVA_HOME/bin:$PATH

# Copy java client
RUN mkdir -p /usr/lib/enchilada
COPY enchilada.jar /usr/lib/enchilada/

RUN apt-get update

RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor git

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-get install -q -y oracle-java8-installer
RUN apt-get install -q -y oracle-java8-set-default

RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
RUN apt-get install -y ruby2.3 ruby-dev nodejs libmysqlclient-dev
RUN gem install bundler rake mysql2

# Download Confluent
RUN wget http://packages.confluent.io/archive/3.1/confluent-oss-3.1.2-2.11.tar.gz
RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main"
RUN sudo apt-get update && sudo apt-get install -y confluent-platform-oss-2.11

# Ruby app
RUN mkdir -p /var/www/apps/enchilada
RUN mkdir -p /root/.fluentd-ui
RUN chmod 777 /root/.fluentd-ui
ADD ruby /var/www/apps/enchilada
RUN cd /var/www/apps/enchilada && bundle install


