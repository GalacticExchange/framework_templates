FROM ubuntu:16.04

ENV RAILS_ENV production
ENV RACK_ENV production
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get update
RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor git openvpn

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -q -y oracle-java8-installer oracle-java8-set-default

RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby2.3 ruby-dev nodejs libmysqlclient-dev
RUN gem install bundler rake mysql2


# Download Confluent
RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add -
RUN add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main"
RUN apt-get update && apt-get install -y confluent-platform-oss-2.11
# Download Cassandra Sink
RUN mkdir -p kafka-connect-cassandra
RUN wget https://github.com/datamountaineer/stream-reactor/releases/download/v0.2.4/kafka-connect-cassandra-0.2.4-3.1.1-all.tar.gz
RUN tar -xvf kafka-connect-cassandra-0.2.4-3.1.1-all.tar.gz -C kafka-connect-cassandra
RUN cp kafka-connect-cassandra/kafka-connect-cassandra-0.2.4-3.1.1-all.jar /usr/share/java/kafka/
RUN rm -rf kafka-connect-cassandra

# Copy java client
RUN mkdir -p /usr/lib/data_enchilada
COPY data_enchilada.jar /usr/lib/data_enchilada/

# Ruby app
RUN mkdir -p /var/www/apps/data_enchilada
RUN mkdir -p /root/.fluentd-ui
RUN chmod 777 /root/.fluentd-ui
ADD ruby /var/www/apps/data_enchilada
RUN cd /var/www/apps/data_enchilada && bundle install


# provision
RUN mkdir -p /opt/gex/config
ADD files/configure.sh /opt/gex/configure.sh
RUN chmod +x /opt/gex/configure.sh
RUN mkdir -p /templates/create
