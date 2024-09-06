#!/bin/bash

# Check if PulseAudio is running
if ! pactl info > /dev/null 2>&1; then
  echo "PulseAudio not running"
  exit 1
fi

# Get the default source (microphone) name
MIC_NAME=$(pactl info | grep 'Default Source' | cut -d: -f2 | xargs)

# Get the microphone volume percentage
MIC_VOLUME=$(pactl get-source-volume "$MIC_NAME" | grep -oP '\d+%' | head -n 1 | tr -d '%')

# Check if the microphone is muted
if [ "$MIC_VOLUME" -eq 0 ]; then
  MIC_ICON=""  # Font Awesome icon for muted microphone
else
  MIC_ICON=""  # Font Awesome icon for active microphone
fi

# Output the status with volume percentage
echo "$MIC_ICON${MIC_VOLUME}% | "
