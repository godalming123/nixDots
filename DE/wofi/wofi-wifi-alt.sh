#!/usr/bin/env bash

notify-send -t 5000 "Getting networksa" "Getting list of available Wi-Fi networks..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

enableWIFI="🔓 Enable Wi-Fi"
disableWIFI="🔒 Disable Wi-Fi"

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="$disableWIFI"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="$enableWIFI"
fi

# Use wofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | wofi --show dmenu --style ~/.config/wofi/styles.css -p "Wi-Fi SSID: " )
# Get name of connection
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "$enableWIFI" ]; then
	nmcli radio wifi on
	notify-send -t 5000 "Enabled wifi"
elif [ "$chosen_network" = "$disableWIFI" ]; then
	nmcli radio wifi off
	notify-send -t 5000 "Disabled wifi"
else
	# Message to show when connection is activated successfully
	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(wofi --show dmenu --style ~/.config/wofi/styles.css -p "Password: " )
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
	fi
fi
