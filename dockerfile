FROM debian:jessie-slim
# APT proxy for faster install uses apt-cacher-ng instance
#COPY c9.bat apt.conf /etc/apt/

RUN apt update
RUN apt install -y git tig curl nano build-essential python2.7 php5-cli php5-curl&& rm -rf /var/lib/apt/lists/*

#### START install C9
RUN git clone https://github.com/c9/core.git /core
COPY plugins/c9.ide.run.debug.xdebug/netproxy.js /core/plugins/c9.ide.run.debug.xdebug/netproxy.js
WORKDIR /core
RUN scripts/install-sdk.sh
#### START install C9


#### START install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN mv composer /usr/bin/  
#### END install composer

#CLEAN UP
COPY c9.bat /root
COPY bash.bashrc /etc
RUN apt -y purge build-essential gcc g++&&apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /root/.npm
RUN rm -rf /root//.c9/tmp/.npm

CMD /root/c9.bat