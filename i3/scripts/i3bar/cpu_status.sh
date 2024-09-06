#!/bin/bash

# Define the number of CPU threads to monitor
NUM_CPUs=12

# Function to get CPU usage for a given CPU core
get_cpu_usage() {
  local cpu_id=$1
  # Read CPU usage from /proc/stat
  local cpu_stats_1=$(grep "^cpu$cpu_id " /proc/stat)
  sleep 1
  local cpu_stats_2=$(grep "^cpu$cpu_id " /proc/stat)

  # Extract user, nice, system, and idle times
  local user1=$(echo $cpu_stats_1 | awk '{print $2}')
  local nice1=$(echo $cpu_stats_1 | awk '{print $3}')
  local system1=$(echo $cpu_stats_1 | awk '{print $4}')
  local idle1=$(echo $cpu_stats_1 | awk '{print $5}')
  local user2=$(echo $cpu_stats_2 | awk '{print $2}')
  local nice2=$(echo $cpu_stats_2 | awk '{print $3}')
  local system2=$(echo $cpu_stats_2 | awk '{print $4}')
  local idle2=$(echo $cpu_stats_2 | awk '{print $5}')

  # Calculate the differences
  local total_diff=$(( (user2 - user1) + (nice2 - nice1) + (system2 - system1) ))
  local idle_diff=$(( idle2 - idle1 ))
  local used_diff=$(( total_diff - idle_diff ))

  if [ "$total_diff" -eq 0 ]; then
    echo "Error: Total CPU time difference is zero."
    return
  fi

  local usage=$(( 100 * used_diff / total_diff ))

  echo "$usage"
}

# Initialize total usage
total_usage=0

# Iterate over all CPU threads and calculate total usage
for (( i=0; i<NUM_CPUs; i++ )); do
  usage=$(get_cpu_usage $i)
  # Check if the usage is a valid number
  if [[ $usage =~ ^[0-9]+$ ]] && [ "$usage" -ge 0 ] && [ "$usage" -le 100 ]; then
    total_usage=$(( total_usage + usage ))
  fi
done

# Calculate average CPU usage
average_usage=$(( total_usage / NUM_CPUs ))

# Output overall CPU usage percentage
echo "CPU: $average_usage%"

