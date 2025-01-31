#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "gunakan parameter: $0 <username> <server_ip>"
    exit 1
fi

ssh -o BatchMode=yes -o ConnectTimeout=5 "$1@$2" exit
if [ "$?" -eq 0 ]; then
    echo "koneksi SSH berhasil"
else
    echo "koneksi SSH gagal"
fi
