FROM node:7

#### START install C9
RUN git clone https://github.com/c9/core.git
COPY plugins/c9.ide.run.debug.xdebug/netproxy.js /core/plugins/c9.ide.run.debug.xdebug/netproxy.js
WORKDIR /core
RUN npm install 
RUN scripts/install-sdk.sh
#### START install C9

RUN apt update
RUN apt install -y tig nano php5-cli php5-curl

#### START install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN mv composer /usr/bin/  
#### END install composer

COPY bash.bashrc /etc
#CLEAN UP
RUN rm -rf /root/*.*
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/*
CMD /root/c9.bat