#!/bin/bash

# Function to get swap usage
get_swap_usage() {
  # Get swap usage from `free`
  local mem_info=$(free -m)
  local total_swap_mb=$(echo "$mem_info" | awk '/^Swap:/ {print $2}')
  local used_swap_mb=$(echo "$mem_info" | awk '/^Swap:/ {print $3}')

  # Convert total swap if >= 1000 MB
  if [ "$total_swap_mb" -ge 1000 ]; then
    local total_swap=$(echo "scale=2; $total_swap_mb / 1024" | bc) 
    local total_swap_label="GB"
  else
    local total_swap=$total_swap_mb
    local total_swap_label="MB"
  fi

  # Convert used swap if >= 1000 MB
  if [ "$used_swap_mb" -ge 1000 ]; then
    local used_swap=$(echo "scale=2; $used_swap_mb / 1024" | bc)
    local used_swap_label="GB"
  else
    local used_swap=$used_swap_mb
    local used_swap_label="MB"
  fi

  # Calculate swap usage percentage
  local swap_usage_percentage=$(( 100 * used_swap_mb / total_swap_mb ))

  # Output swap usage
  echo "SWAP: $used_swap $used_swap_label / $total_swap $total_swap_label ($swap_usage_percentage%)"
}

# Output swap usage
get_swap_usage
