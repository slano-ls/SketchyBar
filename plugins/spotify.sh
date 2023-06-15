#!/bin/sh

forward()
{
  osascript -e 'tell application "Spotify" to play next track'
}

back() 
{
  osascript -e 'tell application "Spotify" to play previous track'
}

play() 
{
  osascript -e 'tell application "Spotify" to playpause'
}

mouse_clicked() {
  case "$NAME" in
    "spotify.forward") forward
    ;;
    "spotify.back") back
    ;;
    "spotify.playpause") play
    ;;
    *) exit
    ;;
  esac
}

set_spotify() {
  export SPOTIFY="$(osascript -e 'tell application "Spotify" to get name of current track') - $(osascript -e 'tell application "Spotify" to get album of current track')"
  if (( ${#SPOTIFY} < 31 )); then
    sketchybar --set spotify icon=􀑪 \
                     label="${SPOTIFY}" \
               --set spotify.playpause icon=􀊘
  else
    sketchybar --set spotify icon=􀑪 \
                     label="$(osascript -e 'tell application "Spotify" to get name of current track')" \
               --set spotify.playpause icon=􀊘
  fi
}

case $(osascript -e 'tell application "Spotify" to get player state') in
  "playing") set_spotify
  ;;
  *) sketchybar --set spotify icon="" \
                 label=""
  ;;
esac

case $(osascript -e 'tell application "Spotify" to get player state') in
  "playing") export ENABLED=1
  ;;
  *) export ENABLED=0
  ;;
esac

if [ $ENABLED == 1 ]; then
  case $SENDER in
    "mouse.entered.global") sketchybar --set spotify.back drawing=on \
                                     --set spotify.playpause drawing=on \
                                     --set spotify.forward drawing=on 
    ;;
    "mouse.exited.global") sketchybar --set spotify.back drawing=off \
                                    --set spotify.playpause drawing=off \
                                    --set spotify.forward drawing=off 
    ;;
    "mouse.clicked") mouse_clicked
    ;;
  esac
  if [ $NAME == "spotify.playpause" ]; then
    sketchybar --set spotify.back drawing=off \
               --set spotify.playpause drawing=off \
               --set spotify.forward drawing=off
  else
    exit 
  fi
fi