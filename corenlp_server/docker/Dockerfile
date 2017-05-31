FROM ubuntu:16.04

# Use baseimage-docker's init system.

# Install Java
RUN \
  apt-get update && \
  apt-get install -y software-properties-common python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer

RUN apt-get install -y unzip net-tools iputils-ping

#Provision
RUN mkdir -p /opt/gex/config /templates/create /var/cache/apt/archives/partial

#Add user
RUN useradd -p $(openssl passwd -1 gexborsch4) -m -s /bin/bash gex
RUN adduser gex sudo

# Install CoreNLP
ENV VERSION stanford-corenlp-full-2016-10-31
RUN mkdir -p /opt/corenlp
WORKDIR /opt/corenlp

RUN wget --quiet http://nlp.stanford.edu/software/$VERSION.zip -O corenlp.zip && \
    unzip corenlp.zip && \
    mv $VERSION src && \
    rm -r corenlp.zip

# Add service
RUN mkdir -p /etc/service/corenlp
ADD corenlp.sh /etc/service/corenlp/run
ADD init.sh /etc/init.sh
EXPOSE 9000

# Clean up
RUN apt-get install -y iproute && apt-get autoclean