#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "gunakan parameter: $0 <direktori>"
    exit 1
fi

dir=$1
mkdir -p "$dir"
ssh-keygen -t rsa -b 2048 -f "$dir/id_rsa" -N ""
echo "SSH key tersimpan di $dir"
