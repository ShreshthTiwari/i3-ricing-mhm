#!/bin/bash

# Check if PulseAudio is running
if ! pactl info > /dev/null 2>&1; then
  echo "PulseAudio not running"
  exit 1
fi

# Get the default sink (speaker) name
SINK_NAME=$(pactl info | grep 'Default Sink' | cut -d: -f2 | xargs)

# Get the speaker volume percentage
SINK_VOLUME=$(pactl get-sink-volume "$SINK_NAME" | grep -oP '\d+%' | head -n 1 | tr -d '%')

# Check if the speakers are muted
if [ "$(pactl get-sink-mute "$SINK_NAME")" = "Mute: yes" ] || [ "$SINK_VOLUME" -eq 0 ]; then
  # If muted or volume is 0, show muted icon
  SPEAKER_ICON=""  # Font Awesome icon for volume mute
  SINK_VOLUME="0"
else
  # Determine icon based on volume level
  if [ "$SINK_VOLUME" -le 40 ]; then
    SPEAKER_ICON=""  # Font Awesome icon for low volume
  else
    SPEAKER_ICON=""  # Font Awesome icon for high volume
  fi
fi

# Output the status with volume percentage
echo "$SPEAKER_ICON ${SINK_VOLUME}%"
