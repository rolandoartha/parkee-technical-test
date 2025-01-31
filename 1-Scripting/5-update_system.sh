#!/bin/bash

LOG_FILE="/var/log/system_update.log"

if command -v apt &>/dev/null; then
    sudo apt update && sudo apt upgrade -y | tee -a "$LOG_FILE"
elif command -v yum &>/dev/null; then
    sudo yum update -y | tee -a "$LOG_FILE"
else
    echo "package tidak support" | tee -a "$LOG_FILE"
fi
