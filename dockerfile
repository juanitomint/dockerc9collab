FROM node:carbon-stretch
ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/juanitomint/dockerc9collab"

# APT proxy for faster install uses apt-cacher-ng instance
COPY config/20proxy.conf /etc/apt/apt.conf.d/

# Copy start script
COPY c9.bat /root

# Install some helpers
RUN apt update && apt install -y git tig curl nano build-essential python2.7 tmux locales-all

#### START C9 install
#RUN env GIT_SSL_NO_VERIFY=true git clone https://github.com/c9/core.git /core

RUN git clone --depth 1 -b master https://github.com/c9/core.git /core
WORKDIR /core

#RUN install 

## copy tmux so it doesnt need compile
RUN mkdir -p "/root/.c9/bin" && ln -s /usr/bin/tmux /root/.c9/bin/

RUN scripts/install-sdk.sh

#### END C9 install

COPY c9.bat /root
#CLEAN UP
COPY bash.bashrc /etc
RUN apt -y purge build-essential gcc g++ && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN rm -rf /root/.npm && \
    rm -rf /root//.c9/tmp/.npm && \
    rm -rf /core/.git && \
    rm -f /etc/apt/apt.conf.d/20proxy.conf


CMD /root/c9.bat