#!/bin/sh
mkdir build
cd build
git clone https://github.com/c9/core.git
docker run -it --rm \
    -v $(pwd)/.c9:/root/.c9 \
    -v $(pwd)/core:/core \
    -v $(pwd)/apt.conf:/etc/apt/apt.conf \
    -v $(pwd)/build.sh:/root/build.sh \
    debian:stretch \
    /root/build.sh