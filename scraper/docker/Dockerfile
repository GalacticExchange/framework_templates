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

RUN apt-get install -y gawk git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby2.3 ruby-dev nodejs libmysqlclient-dev

RUN gem install bundler rake mysql2

RUN apt-get install -y redis-server

# Create user and password
RUN useradd -p $(openssl passwd -1 gexborsch4) -m -s /bin/bash gex
RUN adduser gex sudo

# Nutch
RUN apt-get install -y libasound2 libasound2-data libcanberra0 libdbusmenu-glib4 libdbusmenu-gtk4 libogg0 \
    libtdb1 libvorbis0a libvorbisfile3 sound-theme-freedesktop xul-ext-ubufox fonts-lyx libasound2-plugins \
    alsa-utils libcanberra-gtk0 libcanberra-pulse
RUN wget https://sourceforge.net/projects/ubuntuzilla/files/mozilla/apt/pool/main/f/firefox-mozilla-build/firefox-mozilla-build_38.0.5-0ubuntu1_amd64.deb/download -O firefox
RUN dpkg -i firefox
RUN rm firefox
COPY ./keyboard /etc/default/keyboard
RUN apt-get install -y xorg synaptic xvfb gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi \
    xfonts-75dpi xfonts-base xfonts-scalable freeglut3-dev dbus-x11 openbox x11-xserver-utils libxrender1 cabextract
# error while loading shared libraries: libGL.so.1: cannot open shared object file: No such file or directory FIX
#RUN apt-get --reinstall install libgl1-mesa-glx
#RUN ldconfig
# end of FIX
RUN mkdir -p /usr/local/nutch
RUN wget http://51.0.0.101:80/nutch/nutch-1.13-patch.tar.gz
RUN tar -xvzf nutch-1.13-patch.tar.gz
RUN mv nutch/* /usr/local/nutch
RUN rm nutch-1.13-patch.tar.gz

# Provision
RUN mkdir -p /opt/gex/config
ADD files/configure.sh /opt/gex/configure.sh
RUN chmod +x /opt/gex/configure.sh
RUN mkdir -p /templates/create

