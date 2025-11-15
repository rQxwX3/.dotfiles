#!/bin/sh

LANG="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | egrep -w 'KeyboardLayout Name' |sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/')"

if [ "$LANG" = "" ]; then
  exit 0
fi

if [[ "$LANG" = "U.S." ]]; then
  ICON="􁎢"
elif [[ "$LANG" = "RussianWin" ]]; then
  ICON="􁑆"
fi

sketchybar --set "$NAME" icon="$ICON" label.drawing=0
