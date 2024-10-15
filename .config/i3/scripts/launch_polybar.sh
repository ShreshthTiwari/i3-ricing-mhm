#!/bin/bash

# Kill any existing Polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Get the list of connected monitors
monitors=$(xrandr --listmonitors | awk '{print $4}')

# Start Polybar on eDP-1 if it exists
if echo "$monitors" | grep -q "eDP-1"; then
    MONITOR=eDP-1 polybar mybar -c ~/.config/polybar/config-monitor-1.ini &
fi

# Start Polybar on HDMI-1 if it exists
if echo "$monitors" | grep -q "HDMI-1"; then
    MONITOR=HDMI-1 polybar mybar -c ~/.config/polybar/config-monitor-2.ini &
fi
