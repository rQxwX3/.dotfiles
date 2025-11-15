#!/bin/sh

CONNECTION="$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')"

if [ "$CONNECTION" = "" ]; then
	ICON="􁣡"
else 
	ICON="􀤆"
fi

sketchybar --set "$NAME" icon="$ICON" label.drawing=0
