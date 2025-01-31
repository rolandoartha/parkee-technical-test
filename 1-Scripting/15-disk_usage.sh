#!/bin/bash

THRESHOLD=80
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

#contoh notifikasi menggunakan wall
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Warning: Penggunaan disk diatas $THRESHOLD% ($USAGE%)" | wall
fi
