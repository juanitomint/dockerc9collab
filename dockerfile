#FROM node:7
FROM debian:stretch-slim
# APT proxy for faster install uses apt-cacher-ng instance
COPY apt.conf /etc/apt/

RUN apt update && \
apt install -y \
git tig \
curl \
wget \
nano \
build-essential \
python2.7 \
php-cli \
php-dev \
php-mysql \
php-mongodb \
php-curl \
php-gd \
php-mbstring \
php-xml \
php-zip &&\
rm -rf /var/lib/apt/lists/* 

RUN pecl install mongodb

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
RUN apt -y purge php-dev build-essential gcc g++&&apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin
RUN rm -rf /root/.npm
RUN rm -rf /root/.c9/tmp/.npm
RUN rm -rf /etc/apt/apt.conf

CMD /root/c9.bat