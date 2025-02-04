#!/bin/bash

# Network Monitor Script
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default thresholds
DROPPED_THRESHOLD=100
ERROR_THRESHOLD=50
INTERVAL=5

# Function to print usage
print_usage() {
    echo "Usage: $0 [-i interval] [-d dropped_threshold] [-e error_threshold]"
    echo "  -i: Check interval in seconds (default: 5)"
    echo "  -d: Dropped packets threshold (default: 100)"
    echo "  -e: Error threshold (default: 50)"
}

# Parse command line arguments
while getopts "i:d:e:h" opt; do
    case $opt in
        i) INTERVAL="$OPTARG";;
        d) DROPPED_THRESHOLD="$OPTARG";;
        e) ERROR_THRESHOLD="$OPTARG";;
        h) print_usage; exit 0;;
        ?) print_usage; exit 1;;
    esac
done

# Function to check if a number is integer
is_integer() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Validate inputs
if ! is_integer "$INTERVAL" || ! is_integer "$DROPPED_THRESHOLD" || ! is_integer "$ERROR_THRESHOLD"; then
    echo "Error: All parameters must be positive integers"
    exit 1
fi

# Function to store previous values
declare -A prev_rx_dropped
declare -A prev_tx_dropped
declare -A prev_rx_errors
declare -A prev_tx_errors

# Function to get network statistics
get_network_stats() {
    local interface=$1
    if command -v ip >/dev/null 2>&1; then
        ip -s link show "$interface"
    else
        ifconfig "$interface"
    fi
}

# Main monitoring loop
monitor_network() {
    while true; do
        clear
        echo -e "${GREEN}Network Interface Monitor${NC}"
        echo "Time: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "----------------------------------------"

        # Get all active interfaces
        interfaces=$(ip link show | grep -E "^[0-9]+" | cut -d: -f2 | tr -d ' ' | grep -v "lo")

        for interface in $interfaces; do
            echo -e "${YELLOW}Interface: $interface${NC}"
            
            # Get current statistics
            stats=$(ip -s link show "$interface")
            
            # Extract values
            rx_bytes=$(echo "$stats" | grep -A 1 "RX:" | tail -n 1 | awk '{print $1}')
            rx_dropped=$(echo "$stats" | grep -A 1 "RX:" | tail -n 1 | awk '{print $4}')
            rx_errors=$(echo "$stats" | grep -A 1 "RX:" | tail -n 1 | awk '{print $3}')
            rx_overrun=$(echo "$stats" | grep -A 1 "RX:" | tail -n 1 | awk '{print $5}')
            
            tx_bytes=$(echo "$stats" | grep -A 1 "TX:" | tail -n 1 | awk '{print $1}')
            tx_dropped=$(echo "$stats" | grep -A 1 "TX:" | tail -n 1 | awk '{print $4}')
            tx_errors=$(echo "$stats" | grep -A 1 "TX:" | tail -n 1 | awk '{print $3}')
            tx_overrun=$(echo "$stats" | grep -A 1 "TX:" | tail -n 1 | awk '{print $5}')

            # Calculate differences if previous values exist
            if [[ -n "${prev_rx_dropped[$interface]}" ]]; then
                rx_dropped_diff=$((rx_dropped - prev_rx_dropped[$interface]))
                tx_dropped_diff=$((tx_dropped - prev_tx_dropped[$interface]))
                rx_errors_diff=$((rx_errors - prev_rx_errors[$interface]))
                tx_errors_diff=$((tx_errors - prev_tx_errors[$interface]))

                # Alert on high values
                if [ "$rx_dropped_diff" -gt "$DROPPED_THRESHOLD" ] || [ "$tx_dropped_diff" -gt "$DROPPED_THRESHOLD" ]; then
                    echo -e "${RED}WARNING: High dropped packets detected!${NC}"
                fi
                if [ "$rx_errors_diff" -gt "$ERROR_THRESHOLD" ] || [ "$tx_errors_diff" -gt "$ERROR_THRESHOLD" ]; then
                    echo -e "${RED}WARNING: High error rate detected!${NC}"
                fi
            fi

            # Store current values for next iteration
            prev_rx_dropped[$interface]=$rx_dropped
            prev_tx_dropped[$interface]=$tx_dropped
            prev_rx_errors[$interface]=$rx_errors
            prev_tx_errors[$interface]=$tx_errors

            # Print current statistics
            echo "RX Bytes: $rx_bytes"
            echo "RX Dropped: $rx_dropped"
            echo "RX Errors: $rx_errors"
            echo "RX Overrun: $rx_overrun"
            echo
            echo "TX Bytes: $tx_bytes"
            echo "TX Dropped: $tx_dropped"
            echo "TX Errors: $tx_errors"
            echo "TX Overrun: $tx_overrun"
            echo "----------------------------------------"
        done

        sleep "$INTERVAL"
    done
}

# Trap Ctrl+C and exit gracefully
trap 'echo -e "\n${GREEN}Monitoring stopped${NC}"; exit 0' INT

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# Start monitoring
monitor_network