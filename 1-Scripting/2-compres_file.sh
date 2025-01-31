#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "gunakan parameter: $0 <direktori> <lokasi_backup>"
    exit 1
fi

source_dir=$1
backup_dir=$2
timestamp=$(date +%Y%m%d%H%M%S)
file_backup="$backup_dir/backup_$timestamp.tar.gz"

tar -czf "$file_backup" -C "$source_dir" .
echo "file beckup tersimpan di $file_backup"
