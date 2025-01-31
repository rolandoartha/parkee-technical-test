#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "gunakan parameter: $0 <public-key> <username>"
    exit 1
fi

sed -i "/$1/d" "/home/$2/.ssh/authorized_keys"
