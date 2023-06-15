#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

WIFI=${INFO:-"Disconnected"}
if [ $WIFI == "Disconnected" ]; then
   ICON=􀙈
else
   ICON=􀙇
fi

sketchybar --set $NAME label="${WIFI}" icon="${ICON}"
