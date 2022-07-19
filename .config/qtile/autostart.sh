#!/usr/bin/env bash 

autorandr --change &
sleep .10 &
picom -b &
nitrogen --restore &

