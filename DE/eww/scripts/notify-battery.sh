#!/bin/sh

charge=$(cat /sys/class/power_supply/BAT0/capacity)
batStatus=$(cat /sys/class/power_supply/BAT0/status)

if [ "$charge" -lt 20 ] && [ "$batStatus" == "Discharging" ]; then
    notify-send -t 5000 -i "~/.config/eww/icons/dark/battery.png" "Running low on juice" "You have $charge% charge left"

elif [ "$charge" -lt 95 ] && [ "$batStatus" == "Discharging" ]; then
    notify-send -t 5000 -i "~/.config/eww/icons/dark/battery.png" "You might want to plug in" "You have $charge% charge left"

elif [ "$charge" -eq 100 ] && [ "$batStatus" == "Charging" ]; then
    notify-send -t 5000 -i "~/.config/eww/icons/dark/battery.png" "Fully charged" "You're fully charged"
fi
