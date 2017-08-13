FROM node:7

#### START C9 install
RUN git clone https://github.com/c9/core.git

COPY c9.bat /root

WORKDIR /core

RUN npm install 

RUN scripts/install-sdk.sh

#### END C9 install

# Install some helpers
COPY bash.bashrc /etc
RUN apt update
RUN apt install -y tig nano

#CLEAN UP
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/apt/lists/*

CMD /root/c9.bat