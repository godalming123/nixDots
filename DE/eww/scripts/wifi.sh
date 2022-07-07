#!/bin/sh

help_text="WIFI-MAN V1.1 - a tool to connect to wifi networks
================================================
[e]SSID           print the currently connected network (blank string when unconnected)
[l]IST            list avialable wifi networks
[s]IMPLE-LIST     list only name of avialable wifi networks
[c]OMPLEX-LIST       list all properties of wifi networks
[L]IST-FORMAT     list all properties of wifi networks with an eww format
[t]OGGLE          toggle wifi on/off
[u]ONNECT-UNKNOWN connect to an unknown network where 2nd argument is name, 3rd argument is password (use 'queryPass' to use wofi to find the password) and 4th argument is security
[k]ONNECT-KNOWN   connect to a known network where 2nd argument is the network name
[C]ONNECT         an aliases to connect-unknown TODO: dynamically change between connect unknown and connect-known depending on if the network is known
[d]ISCONNECT      disconnect from connected network
[E]NABLED         returns true if wifi is enabled false otherwise
[i]NFO            show basic info on device hardware
================================================
if argument mathces none of the above this help text will be shown
"

case $1 in
e | "ESSID")
	echo "$(nmcli c | grep wlan0 | awk '{print ($1)}')"
    ;;

l | "LIST")
	echo "$(nmcli --fields "SSID,SECURITY,IN-USE" dev wifi list | awk '!a[$0]++')"
    ;;

s| "SIMPLE-LIST")
	echo "$(nmcli --fields "SSID" dev wifi list | awk '!a[$0]++')"
    ;;

c | "COMPLEX-LIST")
	echo "$(nmcli dev wifi list | awk '!a[$0]++')"
    ;;

L | "LIST-FORMAT")
    if [[ "$(~/.config/eww/scripts/wifi.sh ENABLED)" == "true" ]]; then
        IFS=$'\n'                                               # make newlines the only separator
        set -f                                                  # disable globbing
    	list=$(~/.config/eww/scripts/wifi.sh LIST | tail -n +2) # setup our list and remove the headers with tail

        buf=""
        for line in $list; do
            network_name=$(echo "$line" | awk '{print $1}')
            network_security=$(echo "$line" | awk '{print $2}')
            network_in_use=$(echo "$line" | awk '{print $3}')
            if [[ "$network_security" == "--" ]]; then
                locking_icon=""
            else
                locking_icon="(image :path \"./icons/dark/lock.png\" :image-height 20)"
            fi
            if [[ "$network_in_use" == "*" ]]; then
                wifi_in_use_icon="(image :path \"./icons/dark/wifi.png\" :image-height 20)"
            else
                wifi_in_use_icon=""
            fi
            text="\n        (box :space-evenly false :halign \"fill\" :orientation \"h\" \"$network_name\" $locking_icon $wifi_in_use_icon)\n    "
            buf="    (button :hexpand true :halign \"fill\" :class \"btn list-item\" :onclick \"eww close wifi; ~/.config/eww/scripts/wifi.sh CONNECT '$network_name' 'queryPass' '$network_security' \" $text)\n$buf"
        done
    else
        buf="(label :valign \"center\" :text \"WIFI disabled\")"
    fi    
    echo -e "(box :orientation \"v\" :class \"wifi-networks\" :hexpand true :halign \"fill\" :valign \"center\" :space-evenly false\n$buf)"
    ;;

t | "TOGGLE")
    if [[ "$(~/.config/eww/scripts/wifi.sh ENABLED)" == "true" ]]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
    ;;

E | "ENABLED")
    enabled=$(nmcli radio wifi)
    if [[ "$enabled" == "enabled" ]]; then
        echo "true"
    else
        echo "false"
    fi
    ;;

u | "CONNECT-UNKNOWN")
    ~/eww/scripts/wifi.sh DISCONNECT
    if [[ "$3" == "queryPass" ]] && [[ "$4" != "--" ]]; then # if the password is queryPass and the network has a password
        password=$(wofi -H 60 --style ~/.config/wofi/styles.css --show dmenu -p "Password for $2: ")
    else
        password=$3
    fi
    nmcli dev wifi connect "$2" password "$password"
    notify-send -t 5000 "Connection complete"
    ;;

k | "CONNECT-KNOWN")
    ~/eww/scripts/wifi.sh DISCONNECT
    nmcli con up $2
    ;;

C | "CONNECT")
    knownLine=$(nmcli con show | grep "$2 ")
    if [[ "$knownLine" == "" ]]; then # if we have not connected to the wifi before
        ~/.config/eww/scripts/wifi.sh CONNECT-UNKNOWN $2 $3 $4
    else # if we have connected to the wifi before
        ~/.config/eww/scripts/wifi.sh CONNECT-KNOWN $2
    fi
    ;;

D | "DISCONNECT")
    nmcli con down "$(~/eww/scripts/wifi.sh ESSID)"
    ;;

i | "INFO")
    echo "$(nmcli -o)"
    ;;
*)
    echo -e "$help_text"
    ;;
esac
