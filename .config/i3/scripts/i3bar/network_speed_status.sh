#!/bin/bash

# Choose the network interface (e.g., eth0, wlan0)
interface="wlo1"

# Function to fetch upload and download speeds using ifstat
fetch_speeds() {
    ifstat -i "$interface" 1 1 | awk 'NR==3 {print $1, $2}'
}

# Function to convert speeds into the most appropriate units
convert_speed() {
    local speed=$1
    local unit="b/s"
    
    if (( $(echo "$speed > 1048576" | bc -l) )); then
        speed=$(echo "scale=2; $speed / 1048576" | bc)
        unit="MB/s"
    elif (( $(echo "$speed > 1024" | bc -l) )); then
        speed=$(echo "scale=2; $speed / 1024" | bc)
        unit="KB/s"
    elif (( $(echo "$speed > 8" | bc -l) )); then
        speed=$(echo "scale=2; $speed / 8" | bc)
        unit="B/s"
    else
        speed=$(echo "scale=2; $speed" | bc)
        unit="b/s"
    fi
    
    echo "$speed $unit"
}

# Get upload and download speeds
read download_speed upload_speed <<< $(fetch_speeds)

# Convert speeds from KB/s to bits/s (1 KB = 1024 bytes; 1 byte = 8 bits)
download_speed_bits=$(echo "$download_speed * 1024 * 8" | bc)
upload_speed_bits=$(echo "$upload_speed * 1024 * 8" | bc)

# Convert speeds for display
download_speed_formatted=$(convert_speed "$download_speed_bits")
upload_speed_formatted=$(convert_speed "$upload_speed_bits")

# Return the speeds to i3bar with Font Awesome icons
echo "↑ $upload_speed_formatted  ↓ $download_speed_formatted"
