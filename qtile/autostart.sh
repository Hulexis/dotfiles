#!/usr/bin/env bash 

variety &
picom -b --config ~/.config/picom/picom-corners.conf &
nitrogen --restore &
dunst &
flameshot &
xmousepasteblock &

