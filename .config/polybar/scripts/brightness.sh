# Get the current brightness percentage
BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENT=$(echo "$BRIGHTNESS * 100 / $MAX_BRIGHTNESS" | bc)

# Choose an icon based on brightness level, specifying the font index
if [ "$PERCENT" -le 30 ]; then
    ICON=""
elif [ "$PERCENT" -le 70 ]; then
    ICON=""
else
    ICON=""
fi

# Output the icon and percentage together
# echo " | $ICON $PERCENT% "
echo " | B: $PERCENT% "
