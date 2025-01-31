#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "gunakan parameter: $0 <public_key> <username> <server_ip>"
    exit 1
fi

scp "$1" "$2@$3:~/.ssh/authorized_keys"
