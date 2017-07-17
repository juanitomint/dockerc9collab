FROM node:7

RUN git clone https://github.com/c9/core.git

COPY c9.bat /root

WORKDIR /core

RUN npm install 

RUN scripts/install-sdk.sh

CMD /root/c9.bat