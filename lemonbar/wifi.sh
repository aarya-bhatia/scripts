#!/bin/sh
# echo $label $(hostname -i | cut -d" " -f2)
label_connected=
label_disconnected=󰤮

# Check if NetworkManager is installed
if ! command -v nmcli &> /dev/null; then
    echo "Error: NetworkManager is not installed"
    exit 1
fi

# Get a list of all network interfaces
interfaces=$(nmcli -t -f DEVICE dev status | cut -d ':' -f 2)

# Loop through each interface
wifi_found=false
for interface in $interfaces; do
    # Check if the interface is a WiFi interface
    if nmcli -t -f DEVICE,TYPE dev | grep -q "^$interface:wifi$"; then
        wifi_found=true
        # Check if WiFi is connected
        if nmcli -t -f DEVICE,STATE dev | grep -q "^$interface:connected$"; then
            # Get the SSID of the connected WiFi network
            SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d ':' -f 2)
            echo "WiFi is UP on interface $interface: $SSID" >&2
			echo $label_connected $SSID $(hostname -i | cut -d" " -f1)
        else
            echo "WiFi is DOWN on interface $interface" >&2
			echo $label_disconnected none
        fi
    fi
done

if [ "$wifi_found" = false ]; then
    echo "No WiFi interface found"
fi
