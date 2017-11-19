#FROM tklx/base:stretch
FROM node:7
### comment out if you don't have an apt proxy
COPY 20proxy /etc/apt/apt.conf.d/20proxy

### START C9 install
RUN git clone https://github.com/c9/core.git

COPY c9.bat /root

WORKDIR /core

RUN npm install 

RUN scripts/install-sdk.sh

#### END C9 install

# Install some helpers
COPY bash.bashrc /etc

RUN apt-get update \
    && apt-get -y install \
       curl \
       ca-certificates \
       git \
       libssl-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin

# Install nvm for managing node versions
WORKDIR /root
RUN git clone https://github.com/creationix/nvm.git .nvm

RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && nvm install v7.10.1

# custom /root/.profile
COPY .profile /root/

# create node executable
#COPY node /usr/local/bin/
#RUN chmod +x /usr/local/bin/node



# create npm executable
#COPY npm /usr/local/bin/
#RUN chmod +x /usr/local/bin/npm

#CLEAN UP
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin

### comment out if you don't have an apt proxy
RUN rm -f /etc/apt/apt.conf.d/20proxy

CMD /root/c9.bat