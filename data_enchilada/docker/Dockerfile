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

RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby2.3 ruby-dev nodejs libmysqlclient-dev

RUN gem install bundler rake mysql2

RUN apt-get install -y redis-server

# Create user and password
RUN useradd -p $(openssl passwd -1 gexborsch4) -m -s /bin/bash gex
RUN adduser gex sudo

# Download Confluent
#RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add -
#RUN add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main"
#RUN apt-get update && apt-get install -y confluent-platform-oss-2.11
# Download Cassandra Sink
#RUN mkdir -p kafka-connect-cassandra
#RUN wget https://github.com/datamountaineer/stream-reactor/releases/download/v0.2.4/kafka-connect-cassandra-0.2.4-3.1.1-all.tar.gz
#RUN tar -xvf kafka-connect-cassandra-0.2.4-3.1.1-all.tar.gz -C kafka-connect-cassandra
#RUN cp kafka-connect-cassandra/kafka-connect-cassandra-0.2.4-3.1.1-all.jar /usr/share/java/kafka/
#RUN rm kafka-connect-cassandra-0.2.4-3.1.1-all.tar.gz && rm -rf kafka-connect-cassandra

# Copy java client
#RUN mkdir -p /usr/lib/data_enchilada
#COPY data_enchilada.jar /usr/lib/data_enchilada/

# Ruby app
RUN mkdir -p /var/www/apps/data_enchilada
RUN mkdir -p /root/.data_enchilada
RUN chmod 777 /root/.data_enchilada
ADD ruby /var/www/apps/data_enchilada
RUN cd /var/www/apps/data_enchilada && bundle install

# Flume
RUN mkdir -p /usr/local/flume/logs
RUN wget http://51.0.0.101:80/flume_1_7_0_kafka_es/my-flume-1.7.0-for-docker.tar.gz
RUN tar -xvzf my-flume-1.7.0-for-docker.tar.gz
RUN mv my-flume-1.7.0-for-docker/* /usr/local/flume
RUN wget http://51.0.0.101:80/flume_1_7_0_kafka_es/kudu/kudu-producer.jar
RUN wget http://51.0.0.101:80/flume_1_7_0_kafka_es/kudu/kudu-flume-sink-1.3.0.jar
RUN mv kudu-producer.jar /usr/local/flume/lib
RUN mv kudu-flume-sink-1.3.0.jar /usr/local/flume/lib
RUN rm my-flume-1.7.0-for-docker.tar.gz && rm -rf /usr/local/flume/conf/
RUN touch /usr/local/flume/logs/flume.log
RUN chmod 777 /usr/local/flume/logs/flume.log

# Nutch
RUN mkdir -p /usr/local/nutch
RUN wget apache.volia.net/nutch/1.13/apache-nutch-1.13-bin.tar.gz
RUN tar -xvzf apache-nutch-1.13-bin.tar.gz
RUN mv apache-nutch-1.13/* /usr/local/nutch
RUN rm apache-nutch-1.13-bin.tar.gz

# Provision
RUN mkdir -p /opt/gex/config
ADD files/configure.sh /opt/gex/configure.sh
RUN chmod +x /opt/gex/configure.sh
RUN mkdir -p /templates/create

