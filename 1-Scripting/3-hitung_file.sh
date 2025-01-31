#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "gunakan parameter: $0 <direktori>"
    exit 1
fi

direktori=$1

echo -e "File\tBaris\tKata\tKarakter"
for file in "$direktori"/*.txt; do
    [ -e "$file" ] || continue
    stats=$(wc "$file")
    echo -e "$(basename "$file")\t$stats"
done
