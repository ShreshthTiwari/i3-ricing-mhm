#!/bin/bash

# Check if NetworkManager is running
if ! nmcli -t -f active,ssid dev wifi | grep '^yes' > /dev/null; then
  echo "睊"
  exit 1
fi

# Get the SSID and signal strength
WIFI_INFO=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | head -n 1)
WIFI_SSID=$(echo "$WIFI_INFO" | cut -d: -f2)
WIFI_SIGNAL=$(echo "$WIFI_INFO" | cut -d: -f3)

# Convert signal strength to percentage (approximation)
# Example conversion: signal strength in dBm to percentage
if [ -n "$WIFI_SIGNAL" ]; then
  SIGNAL_PERCENT=$(( (WIFI_SIGNAL + 100) * 100 / 60 ))
  SIGNAL_PERCENT=$(( SIGNAL_PERCENT > 100 ? 100 : SIGNAL_PERCENT ))
else
  SIGNAL_PERCENT=0
fi

# Output the status with SSID and signal strength percentage
echo "  $WIFI_SSID ${SIGNAL_PERCENT}%"

