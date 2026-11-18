#!/usr/bin/bash
files=(/home/pjs/pics/backgrounds/*)
WALLPAPER=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
WALLPAPER2=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
WALLPAPER3=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
/usr/bin/feh -B white --bg-fill $WALLPAPER --bg-fill $WALLPAPER2 --bg-fill $WALLPAPER3
