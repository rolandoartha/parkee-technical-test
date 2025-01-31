#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "gunakan parameter: $0 <public_key> <username>"
    exit 1
fi

cat "$1" >> "/home/$2/.ssh/authorized_keys"
