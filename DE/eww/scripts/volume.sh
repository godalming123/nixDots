#!/bin/sh

help_text="Volume - manage volume
================================================
[g]get           get volume
[s]set           set volume
[i]increase      increase volume
[d]decreas       decrease volume
[u]update        update the volume variable from eww
================================================
if argument mathces none of the above this help text will be shown
"

case $1 in

g | "get")
    amixer get Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%' | head -1
    ;;

s | "set")
    amixer set Master $2%
    # ~/.config/eww/scripts/volume.sh update
    ;;

i | "increase")
    amixer set Master 5%+
    ~/.config/eww/scripts/volume.sh update
    ;;


d | "decrease")
    amixer set Master 5%-
    ~/.config/eww/scripts/volume.sh update
    ;;


u | "update")
    # killlall "eww update"
    eww update volume="$(~/.config/eww/scripts/volume.sh get)"
    ;;

*)
    echo -e "$help_text"
    ;;
esac
