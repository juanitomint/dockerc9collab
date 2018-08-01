#!/bin/bash
mkdir build
cd build
git clone https://github.com/c9/core.git
echo "current dir" $(pwd)
docker run --rm \
    -v $(pwd)/core:/core \
    -v $(pwd)/../apt.conf:/etc/apt/apt.conf \
    -v $(pwd)/root:/root \
    debian:stretch \
    bash -c "apt update && apt install -y curl python2.7 build-essential git && /core/scripts/install-sdk.sh"