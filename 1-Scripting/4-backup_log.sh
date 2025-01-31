#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "gunakan parameter: $0 <direktori_sumber> <direktori_backup>"
    exit 1
fi

SOURCE_DIR=$1
BACKUP_DIR=$2
TIMESTAMP=$(date +%Y%m%d)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
echo "Backup selesai dan file backup lama telah dihapus."
