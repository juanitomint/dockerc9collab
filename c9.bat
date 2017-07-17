#/bin/bash

# check user and password if passed

if [ -z ${C9_USER+x} ]; 
    then 
        echo "C9_USER environment is unset setting to: developer";
        C9_USER='developer'
    else echo "using C9_USER : $C9_USER"; 
fi
echo

if [ -z ${C9_PASSWD+x} ]; 
    then 
        echo "C9_PASSWD environment is unset setting to: developer";
        C9_PASSWD='developer'
    else echo "using C9_PASSWD : $C9_PASSWD"; 
fi
echo

node /core/server.js -p 80 -w /workspace --listen 0.0.0.0 --collab --packed  -a $C9_USER:$C9_PASSWD