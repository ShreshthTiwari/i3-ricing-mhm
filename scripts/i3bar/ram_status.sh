#!/bin/bash

# Function to get RAM usage
get_ram_usage() {
  # Get total and used memory from `free`
  local mem_info=$(free -m)
  local total_mem_mb=$(echo "$mem_info" | awk '/^Mem:/ {print $2}')
  local used_mem_mb=$(echo "$mem_info" | awk '/^Mem:/ {print $3}')

  # Convert total memory if >= 1000 MB
  if [ "$total_mem_mb" -ge 1000 ]; then
    local total_mem=$(echo "scale=2; $total_mem_mb / 1024" | bc)
    local total_mem_label="GB"
  else
    local total_mem=$total_mem_mb
    local total_mem_label="MB"
  fi

  # Convert used memory if >= 1000 MB
  if [ "$used_mem_mb" -ge 1000 ]; then
    local used_mem=$(echo "scale=2; $used_mem_mb / 1024" | bc)
    local used_mem_label="GB"
  else
    local used_mem=$used_mem_mb
    local used_mem_label="MB"
  fi

  # Calculate RAM usage percentage
  local usage_percentage=$(( 100 * used_mem_mb / total_mem_mb ))

  # Output RAM usage
  echo "RAM: $used_mem $used_mem_label / $total_mem $total_mem_label ($usage_percentage%)"
}

# Output RAM usage
get_ram_usage
