#!/bin/bash

echo "Hostname: $(hostname)"
echo "Tanggal: $(date)"
echo "Jumlah user yang sedang login: $(who | wc -l)"
