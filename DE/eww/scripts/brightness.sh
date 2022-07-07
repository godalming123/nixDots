#!/bin/sh

help_text="Brightness - manage brightness
================================================
[g]get           get brightness
[s]set           set brightness
[i]increase      increase brightness
[d]decreas       decrease brightness
[u]update        update the brightness variable from eww
================================================
if argument mathces none of the above this help text will be shown
"

case $1 in

g | "get")
    light -G
    ;;

s | "set")
    light -S $2
    ;;

i | "increase")
    light -A 10
    ~/.config/eww/scripts/brightness.sh update
    ;;


d | "decrease")
    light -U 10
    ~/.config/eww/scripts/brightness.sh update
    ;;


u | "update")
    eww update brightness="$(~/.config/eww/scripts/brightness.sh get)"
    ;;

*)
    echo -e "$help_text"
    ;;
esac
