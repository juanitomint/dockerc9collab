#/bin/bash
apache2ctl start
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

# check if passed workspace specific dir (for debugger has to be the same as web server)
if [ -z ${C9_WORKSPACE+x} ];
    then 
        echo "C9_WORKSPACE environment is unset setting to: /workspace";
        C9_WORKSPACE='/workspace'
    else echo "using C9_WORKSPACE : $C9_WORKSPACE"; 
fi
echo
/root/.c9/node/bin/node /core/server.js -p 8080 -w $C9_WORKSPACE --listen 0.0.0.0 --collab --packed  -a $C9_USER:$C9_PASSWD
