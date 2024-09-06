#!/bin/bash

# Directory containing your backgrounds
BG_DIR="/media/shreshth/Data/Backgrounds"

# Number of images
MAX_IMAGES=768

while true; do
  # Generate a random number between 1 and MAX_IMAGES
  RANDOM_NUMBER=$(shuf -i 1-$MAX_IMAGES -n 1)

  # Construct the filename
  IMAGE_FILE="$BG_DIR/${RANDOM_NUMBER}.png"

  # Check if the file exists
  if [ -f "$IMAGE_FILE" ]; then
    # Set the background
    feh --bg-fill "$IMAGE_FILE"
  else
    echo "Background file $IMAGE_FILE does not exist."
  fi

  # Wait for 30 seconds before changing the background again
  sleep 30
done
