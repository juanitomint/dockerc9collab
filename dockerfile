FROM tklx/base:stretch

### comment out if you don't have an apt proxy
COPY 20proxy /etc/apt/apt.conf.d/20proxy
RUN apt-get update \
    && apt-get -y install \
       curl \
       ca-certificates \
       build-essential \
       python \
       git \
       libssl-dev \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin
# Install nvm for managing node versions
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | sh

RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install v7.10.1
#RUN /root/.nvm/nvm.sh install v7.10.1

RUN ln -s /root/.nvm/versions/node/v7.10.1/bin/npm /usr/bin/npm
RUN ln -s /root/.nvm/versions/node/v7.10.1/bin/node /usr/bin/node
RUN npm --version
### START C9 install
RUN git clone https://github.com/c9/core.git

COPY c9.bat /root

WORKDIR /core

RUN npm install 

RUN scripts/install-sdk.sh

#### END C9 install

# Install some helpers
COPY bash.bashrc /etc


#CLEAN UP
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin

### comment out if you don't have an apt proxy
RUN rm -f /etc/apt/apt.conf.d/20proxy

CMD /root/c9.bat