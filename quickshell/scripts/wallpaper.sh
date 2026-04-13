#!/bin/bash
THEME=$1
WALLPAPER=$2
MONITOR=$3

if [[ -n "$MONITOR" ]]; then 
    awww img "$WALLPAPER" -o "$MONITOR" --transition-duration 0.3
else awww img "$WALLPAPER" --transition-step 10 --transition-fps 60 
fi

matugen image -m "$THEME" "$WALLPAPER" --source-color-index 0