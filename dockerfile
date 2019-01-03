FROM juanitomint/php7:laravel
# APT proxy for faster install uses apt-cacher-ng instance
COPY apt.conf /etc/apt/
COPY build/root/.c9 /root/.c9
COPY build/core /core
ENV C9_WORKSPACE /var/www/html
WORKDIR ${C9_WORKSPACE}
RUN apt update && \
apt install -y \
git tig \
curl \
nano \
wget \
gnupg


#### START install composer
COPY install-composer.sh /core
RUN chmod +x /core/install-composer.sh
RUN /core/install-composer.sh
#### END install composer

COPY bash.bashrc /etc
COPY c9.bat /root

### install nodejs Carbon LTS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt install -y nodejs
###

### CLEAN UP
RUN apt -y purge php-dev build-essential gcc g++&&apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin
RUN rm -rf /root/.npm
RUN rm -rf /root/.c9/tmp/.npm
RUN rm -rf /etc/apt/apt.conf

CMD /root/c9.bat