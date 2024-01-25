#!/bin/bash
# betterlockscreen -l & sleep 5 && xset dpms force standby

# dunstctl set-paused true
# sleep 0.1
# betterlockscreen -l
#
# sleep 5
# notify-send "Title" "NOW"

pkill -xu $EUID -USR1 dunst
i3lock --color 000000 &
wait
pkill -xu $EUID -USR2 dunst

sleep 5 && xset dpms force standby
