#!/bin/zsh

getWindowId() {
	local appName="$1"

	local windows=$(aerospace list-windows --all --json)
	local windowId=$(echo -e "$windows" | jq -r --arg app "$appName" '.[] | select(.["app-name"] == $app) | .["window-id"]')

	if [ -z "$windowId" ]; then
		open -a "$appName"
		if [ $? -ne 0 ]; then
			echo "Failed to open $appName" >&2
            exit 1
		fi
		# while [ -z "$windowId" ]; do
		# 	windows=$(aerospace list-windows --all --json)
		# 	windowId=$(echo "$windows" | jq -r --arg app "$appName" '.[] | select(.["app-name"] == $app) | .["window-id"]')
		# 	sleep 0.1
		# done
	fi

	echo "$windowId"
}

aerospace workspace D

weztermId=$(getWindowId "Wezterm")
arcId=$(getWindowId "Arc")
sioyekId=$(getWindowId "sioyek")

aerospace move-node-to-workspace --window-id $sioyekId W
aerospace move-node-to-workspace --window-id $arcId W
aerospace move-node-to-workspace --window-id $weztermId W 

aerospace mode main
sketchybar --trigger aerospace_mode MODE=main
