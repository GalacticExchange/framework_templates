FROM ubuntu:16.04
#USER root
#RUN echo "root:vagrant" | chpasswd

# Copy java client
RUN mkdir -p /usr/lib/enchilada
COPY enchilada.jar /usr/lib/enchilada/

RUN apt-get update

RUN apt-get install -y ssh sudo net-tools wget software-properties-common iputils-ping telnet dnsutils curl nano supervisor git ruby ruby-dev

# Ruby app
RUN mkdir -p /var/www/apps/enchilada
#RUN git clone https://kladkogex:Galactic1@github.com/GalacticExchange/framework_templates.git
ADD ruby /var/www/apps/enchilada
RUN apt-get install -y nodejs
RUN gem install bundler

RUN cd /var/www/apps/enchilada && bundle install



