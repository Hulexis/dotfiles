#!/usr/bin/env bash

start() {
	pgrep -x "$1" >/dev/null || "$@" &
}

start hyprpaper
start waybar
start swaync
start hypridle

# "$HOME/.config/hypr/scripts/random_wallpaper.sh" &
