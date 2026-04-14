#!/bin/bash
THEME=$1
RESIZE_MODE=${2:-"crop"}
MONITOR=$3
WALLPAPER=$4

ARGS="--resize $RESIZE_MODE --transition-step 90 --transition-duration 1 --transition-fps 60 --transition-type center"

awww img "$WALLPAPER" --outputs "$MONITOR" $ARGS
matugen image -m "$THEME" "$WALLPAPER" --source-color-index 0