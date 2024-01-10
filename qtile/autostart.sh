#!/usr/bin/env bash 

autorandr -c &
sleep .10 &
picom -b --config ~/.config/picom/picom.conf &
nitrogen --restore &
dunst &
flameshot &
xmousepasteblock &

