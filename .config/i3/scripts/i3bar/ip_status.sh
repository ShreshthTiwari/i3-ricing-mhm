#!/bin/bash

# Function to get and display IPv4 and IPv6 addresses
get_ip_addresses() {
  local interface=$1

  # Get IPv4 and IPv6 addresses
  local ipv4=$(ip -4 addr show $interface | grep inet | awk '{print $2}' | cut -d/ -f1 | tr '\n' ' ')
  #local ipv6=$(ip -6 addr show $interface | grep inet6 | awk '{print $2}' | cut -d/ -f1 | tr '\n' ' ')
  
  # Output the IP addresses in one line
  echo "$ipv4"
}

# Network interface to check
INTERFACE=wlo1

# Output IP addresses
get_ip_addresses $INTERFACE
