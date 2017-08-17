FROM ubuntu:16.04

ENV RAILS_ENV production
ENV RACK_ENV production
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH /usr/local/flume/bin:$JAVA_HOME/bin:$PATH
ENV TERM xterm

RUN apt-get update --fix-missing
RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano git openvpn ruby

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -q -y oracle-java8-installer oracle-java8-set-default

# Create user and password
RUN useradd -p $(openssl passwd -1 gexborsch4) -m -s /bin/bash gex
RUN adduser gex sudo

# Install phantom js
COPY ./keyboard /etc/default/keyboard
RUN apt-get install -q -y build-essential chrpath libssl-dev libxft-dev
RUN apt-get install -q -y libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
RUN ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
RUN rm phantomjs-2.1.1-linux-x86_64.tar.bz2

# Provision
RUN mkdir -p /opt/gex/config
ADD files/configure.sh /opt/gex/configure.sh
RUN chmod +x /opt/gex/configure.sh
RUN mkdir -p /templates/create

# Monitoring
RUN mkdir -p /opt/gex/goss
RUN curl -fsSL https://goss.rocks/install | sh
ADD files/healthcheck /opt/gex/healthcheck
ADD files/goss/goss.yaml /opt/gex/goss/goss.yaml
RUN chmod +x /opt/gex/healthcheck

# Install nutch
ADD nutch /usr/local/nutch
# Install scraper jar
ADD scraper.jar /usr/local/scraper/

