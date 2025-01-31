#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "parameter: $0 <direktori> <username> <server_ip>"
    exit 1
fi

scp -r "$1" "$2@$3:~/"
