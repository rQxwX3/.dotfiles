#!/bin/sh

CONNECTION="$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')"

if [ "$CONNECTION" = "" ]; then
	sketchybar --set "$NAME" drawing=off
else 
	sketchybar --set "$NAME" icon="􀤆" label.drawing=0 drawing=on
fi

