#!/bin/sh

aerospace move-node-to-workspace $1
aerospace workspace $1
aerospace mode main 
sketchybar --trigger aerospace_mode MODE=main
