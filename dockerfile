#FROM node:7
FROM debian:stretch-slim
# APT proxy for faster install uses apt-cacher-ng instance
COPY apt.conf /etc/apt/

RUN apt update && \
apt install -y git tig curl wget nano build-essential python2.7 php7.0-cli php7.0-mysql php7.0-curl php7.0-gd php7.0-mbstring php7.0-xml && \
rm -rf /var/lib/apt/lists/*

#### START install C9
RUN git clone https://github.com/c9/core.git
COPY plugins/c9.ide.run.debug.xdebug/netproxy.js /core/plugins/c9.ide.run.debug.xdebug/netproxy.js
WORKDIR /core
RUN scripts/install-sdk.sh
#### END install C9


#### START install composer
COPY install-composer.sh /core
RUN chmod +x /core/install-composer.sh
RUN /core/install-composer.sh
#### END install composer

COPY bash.bashrc /etc
COPY c9.bat /root

#CLEAN UP
RUN apt -y purge build-essential gcc g++&&apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin
RUN rm -rf /root/.npm
RUN rm -rf /root/.c9/tmp/.npm
RUN rm -rf /etc/apt/apt.conf

CMD /root/c9.bat