#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "parameter: $0 <start|stop|status> <nama-service>"
    exit 1
fi

action=$1
SERVICE=$2

case $action in
    start)
        sudo systemctl start "$SERVICE"
        echo "$SERVICE dijalankan."
        ;;
    stop)
        sudo systemctl stop "$SERVICE"
        echo "$SERVICE dihentikan."
        ;;
    status)
        sudo systemctl status "$SERVICE"
        ;;
    *)
        echo "Invalid."
        exit 1
        ;;
esac
