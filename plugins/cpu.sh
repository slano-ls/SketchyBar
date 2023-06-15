#!/bin/sh

sketchybar --set cpu label="$(top -l  2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5"%" }')"