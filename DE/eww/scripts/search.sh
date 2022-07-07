#!/bin/sh
list=$(find /usr/share/applications -name '*.desktop' | grep -m 20 -i "$1")

if ["$1" == ""]; then
  result="(label :text \"test\")"
else
  buf=""
  for name in $list ; do
    text=$(cat $name)
    name=$(echo "$text" | awk -F "=" '/Name=/ {print $2}' | head -n 1)
    exec=$(echo "$text" | awk -F "=" '/Exec=/ {print $2}' | head -n 1)
    buf="(button :hexpand true :halign \"fill\" :valign \"fill\" :class \"btn list-item\" :onclick \"eww close menu & $exec &\" \"$name\" ) $buf"
  done
  result="(box :orientation \"v\" :class \"apps\" :halign \"fill\" :valign \"fill\" :hexpand true :space-evenly false $buf)"
fi

eww update search_listen="$result"
