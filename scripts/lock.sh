#!/bin/bash
playerctl play-pause --player=spotify

pkill -xu $EUID -USR1 dunst
i3lock --color 000000 &
wait
pkill -xu $EUID -USR2 dunst

sleep 5 && xset dpms force standby
