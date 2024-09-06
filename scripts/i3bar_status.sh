#!/bin/bash

while true; do
    # Call your microphone and speaker status scripts and capture their outputs
    MIC_STATUS=$(~/.config/i3/scripts/i3bar/mic_status.sh)
    SPEAKER_STATUS=$(~/.config/i3/scripts/i3bar/speaker_status.sh)
    WIFI_STATUS=$(~/.config/i3/scripts/i3bar/wifi_status.sh)
    BATTERY_STATUS=$(~/.config/i3/scripts/i3bar/battery_status.sh)
    DATE_TIME_STATUS=$(~/.config/i3/scripts/i3bar/date_time_status.sh)
    CPU_STATUS=$(~/.config/i3/scripts/i3bar/cpu_status.sh)
    RAM_STATUS=$(~/.config/i3/scripts/i3bar/ram_status.sh)
    SWAP_STATUS=$(~/.config/i3/scripts/i3bar/swap_status.sh)
    NETWORK_SPEED_STATUS=$(~/.config/i3/scripts/i3bar/network_speed_status.sh)
    IP_STATUS=$(~/.config/i3/scripts/i3bar/ip_status.sh)


    
    # Combine the outputs and display
    echo " | $MIC_STATUS | $SPEAKER_STATUS | $WIFI_STATUS | $BATTERY_STATUS | $DATE_TIME_STATUS | $CPU_STATUS | $RAM_STATUS | $SWAP_STATUS | $NETWORK_SPEED_STATUS | $IP_STATUS | "
    
    sleep 1
done
