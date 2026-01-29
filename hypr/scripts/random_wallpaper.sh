#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hypr/theme/walls"
random=$(fd --base-directory "$WALLPAPER_DIR" --type f -0 . | shuf -z -n 1 | tr -d '\0')
WALLPAPER="$WALLPAPER_DIR/$random"

if pgrep -x hyprpaper >/dev/null; then
	# set wallpaper on every monitor
	hyprctl monitors -j | jq -r '.[].name' | while read -r mon; do
		hyprctl hyprpaper wallpaper "$mon,$WALLPAPER"
	done

	notify-send "Wallpaper Changed" -i "$WALLPAPER" --app-name=Wallpaper

elif pgrep -x swww >/dev/null; then
	swww img "$WALLPAPER" \
		--transition-bezier 0.5,1.19,.8,.4 \
		--transition-type wipe \
		--transition-duration 2 \
		--transition-fps 75
	notify-send "Wallpaper Changed" -i "$WALLPAPER" --app-name=Wallpaper
fi
