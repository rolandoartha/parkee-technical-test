#!/bin/bash

# Cek apakah dua parameter diberikan
if [ "$#" -ne 2 ]; then
    echo "berikan parameter: $0 <directori> <ekstensi>"
    exit 1
fi

direktori=$1
ekstensi=$2

# Cek apakah direktori ada
if [ ! -d "$direktori" ]; then
    echo "Error: Direketori '$direktori' tidak ditemukan."
    exit 1
fi

find "$direktori" -type f -name "*.$ekstensi"
