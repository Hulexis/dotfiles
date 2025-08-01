#!/bin/bash

# Wallpaper engine
hyprpaper &

# Bar
waybar &

# Notification Daemon
# swaync &
dunst &

# Idle daemon to screen lock
hypridle &

# Random Wallpaper
"$HOME"/.config/hypr/scripts/random_wallpaper.sh &
