FROM ubuntu:16.04

ENV RAILS_ENV production
ENV RACK_ENV production
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH /usr/local/flume/bin:$JAVA_HOME/bin:$PATH
ENV TERM xterm

RUN apt-get update
RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor git openvpn
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tshark

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -q -y oracle-java8-installer oracle-java8-set-default

# Provision
RUN mkdir -p /opt/gex/config
ADD files/configure.sh /opt/gex/configure.sh
RUN chmod +x /opt/gex/configure.sh
RUN mkdir -p /templates/create

# Create user and password
RUN useradd -p $(openssl passwd -1 gexborsch4) -m -s /bin/bash gex
RUN adduser gex sudo

# Flume
RUN mkdir -p /usr/local/flume/logs
RUN wget http://51.0.0.101:80/flume_1_7_0_kafka_es/my-flume-1.7.0-for-docker_10_05_2017.tar.gz
RUN tar -xvzf my-flume-1.7.0-for-docker_10_05_2017.tar.gz
RUN mv my-flume-1.7.0-for-docker/* /usr/local/flume
RUN wget http://51.0.0.101:80/kudu/kudu-producer.jar
RUN wget http://51.0.0.101:80/kudu/kudu-flume-sink-1.3.0.jar
RUN mv kudu-producer.jar /usr/local/flume/lib
RUN mv kudu-flume-sink-1.3.0.jar /usr/local/flume/lib
RUN rm my-flume-1.7.0-for-docker_10_05_2017.tar.gz && rm -rf /usr/local/flume/conf/ && rm -rf my-flume-1.7.0-for-docker
RUN touch /usr/local/flume/logs/flume.log
RUN chmod 777 /usr/local/flume/logs/flume.log

# Ruby
RUN apt-get install -y gawk git-core redis-server zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs libmysqlclient-dev
# libsqlite3-dev  sqlite3 ruby-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN mkdir -p /var/www/apps
RUN mkdir -p /root/.data_enchilada
RUN chmod 777 /root/.data_enchilada
#ADD ruby /var/www/apps/data_enchilada
RUN cd /var/www/apps; git clone --depth 1 https://github.com/kladkogex/dataenchilada_app data_enchilada

ADD files/ruby.sh /tmp/ruby.sh
RUN chmod +x /tmp/ruby.sh
RUN bash -c "/tmp/ruby.sh"
RUN echo 'source /etc/profile.d/rvm.sh' >> /root/.bashrc
ADD files/app.sh /etc/app.sh
RUN chmod +x /etc/app.sh




