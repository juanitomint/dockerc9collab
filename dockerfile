FROM node:7

#### START install C9
RUN git clone https://github.com/c9/core.git
COPY plugins/c9.ide.run.debug.xdebug/netproxy.js /core/plugins/c9.ide.run.debug.xdebug/netproxy.js
WORKDIR /core
RUN npm install
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
CMD /root/c9.bat