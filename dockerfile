FROM node:7
# APT proxy for faster install uses apt-cacher-ng instance
#COPY c9.bat apt.conf /etc/apt/

RUN apt update
RUN apt install -y git tig curl nano build-essential python2.7 php5-cli php5-curl&& rm -rf /var/lib/apt/lists/*

#### START install C9
RUN git clone https://github.com/c9/core.git
COPY plugins/c9.ide.run.debug.xdebug/netproxy.js /core/plugins/c9.ide.run.debug.xdebug/netproxy.js
WORKDIR /core
RUN scripts/install-sdk.sh
#### END install C9

RUN apt update
RUN apt install -y tig nano php5-cli php5-curl

#### START install composer
COPY install-composer.sh /core
RUN chmod +x ./install-composer.sh
RUN ./install-composer.sh
RUN mv composer.phar /usr/local/bin/composer  
#### END install composer

COPY bash.bashrc /etc
#CLEAN UP
RUN rm -rf /root/*.*
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/*
COPY c9.bat /root
COPY bash.bashrc /etc
RUN apt -y purge build-essential gcc g++&&apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /root/.npm
RUN rm -rf /root//.c9/tmp/.npm

CMD /root/c9.bat