#!/bin/bash

LOG_FILE="cpu_monitor.log"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

if (( $(echo "$CPU_USAGE > 75" | bc -l) )); then
    echo "$(date) - Penggunaan CPU tinggi: $CPU_USAGE%" >> "$LOG_FILE"
fi
