#!/bin/bash
THEME=$1
RESIZE_MODE=${2:-"crop"}
MONITOR=$3
WALLPAPER=$4
FILL_COLOR=$5

ARGS="--resize $RESIZE_MODE --fill-color $FILL_COLOR  --transition-step 90 --transition-duration 1 --transition-fps 60 --transition-type center"

if [[ "$MONITOR" != "all" ]]; then 
    awww img "$WALLPAPER" --outputs "$MONITOR" $ARGS
else awww img "$WALLPAPER" $ARGS
fi
matugen image -m "$THEME" "$WALLPAPER" --source-color-index 0