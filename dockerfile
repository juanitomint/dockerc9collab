FROM debian:stretch-slim
# APT proxy for faster install uses apt-cacher-ng instance
# COPY c9.bat apt.conf /etc/apt/

RUN apt update
RUN apt install -y git tig curl nano build-essential python2.7&& rm -rf /var/lib/apt/lists/*

#### START C9 install
#RUN env GIT_SSL_NO_VERIFY=true git clone https://github.com/c9/core.git /core

RUN git clone https://github.com/c9/core.git /core
WORKDIR /core

#RUN install 

RUN scripts/install-sdk.sh

#### END C9 install

COPY c9.bat /root
# Install some helpers
#CLEAN UP
COPY bash.bashrc /etc
RUN apt -y purge build-essential gcc g++ && apt -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /root/.npm
RUN rm -rf /root//.c9/tmp/.npm


CMD /root/c9.bat