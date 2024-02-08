#!/bin/bash

# Get network interface name
interface="wlp1s0"  # Replace with your actual network interface name

# Get current RX (received) and TX (transmitted) bytes
rx_before=$(cat "/sys/class/net/$interface/statistics/rx_bytes")
tx_before=$(cat "/sys/class/net/$interface/statistics/tx_bytes")

# Wait for a second
sleep 1

# Get new RX and TX bytes
rx_after=$(cat "/sys/class/net/$interface/statistics/rx_bytes")
tx_after=$(cat "/sys/class/net/$interface/statistics/tx_bytes")

# Calculate the difference to get bytes received and transmitted in the last second
rx_bytes=$((rx_after - rx_before))
tx_bytes=$((tx_after - tx_before))

# Convert bytes to kilobytes
rx_kbps=$((rx_bytes / 1024))
tx_kbps=$((tx_bytes / 1024))

# Print the results
echo "↓ $rx_kbps KB/s ↑ $tx_kbps KB/s"

