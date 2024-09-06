#!/bin/bash

# Get battery information
battery_info=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage|state")

# Extract battery percentage and charging status
battery_percentage=$(echo "$battery_info" | grep 'percentage' | awk '{print $2}' | sed 's/%//')
charging_status=$(echo "$battery_info" | grep 'state' | awk '{print $2}')

# Determine the battery icon based on percentage
if [ "$battery_percentage" -ge 75 ]; then
    battery_icon=""  # Full
elif [ "$battery_percentage" -ge 50 ]; then
    battery_icon=""  # 75%
elif [ "$battery_percentage" -ge 25 ]; then
    battery_icon=""  # 50%
else
    battery_icon=""  # Low
fi

# Adjust icon for charging status
if [ "$charging_status" == "charging" ]; then
    battery_icon=" $battery_icon"  # Add charging symbol
fi

# Output the battery icon and percentage
echo "$battery_icon $battery_percentage%"
