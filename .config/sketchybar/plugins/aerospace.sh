#!/bin/sh

current_ws=$(aerospace list-workspaces --focused)
current_mode=$(aerospace list-modes --current)

if [ "$current_mode" = "main" ]; then
	sketchybar --set "$NAME" label="${current_ws}" icon.drawing=0
else
	sketchybar --set "$NAME" label="${current_ws}:${current_mode}" icon.drawing=0
fi
