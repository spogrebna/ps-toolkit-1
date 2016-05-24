#!/bin/bash

pid=`ps aux | grep -v grep | grep process.marker=webui-marker | awk '{print $2}'`
if [ -z $pid ]; then
    echo "Web management console is not running"
    exit
fi
echo "Stopping web management console (pid: $pid)..."
kill -SIGTERM $pid
    
TIMEOUT=60
while ps -p $pid > /dev/null; do
    if [ $TIMEOUT -le 0 ]; then
        break
    fi
    let "TIMEOUT--"
    sleep 1
done
echo "Web management console stopped"