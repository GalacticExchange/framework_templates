FROM ubuntu:16.04
#USER root
#RUN echo "root:vagrant" | chpasswd

RUN apt-get update

RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor

# todo: need this line ?
RUN systemctl enable supervisor.service

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $JAVA_HOME/bin:$PATH

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-get install -q -y oracle-java8-installer
RUN apt-get install -q -y oracle-java8-set-default

# Download Confluent
# wget http://packages.confluent.io/archive/3.1/confluent-oss-3.1.2-2.11.tar.gz
RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main"
RUN sudo apt-get update && sudo apt-get install -y confluent-platform-oss-2.11

