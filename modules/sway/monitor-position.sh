#!/usr/bin/env bash

# Set displays, from GUI wdisplays (which can also use)

# get external monitor if exists
laptop_w=1920
read -r ext_w ext_h < <(swaymsg -t get_outputs | jq -r '.[] | select(.active == true and .name != "eDP-1") | "\(.rect.width) \(.rect.height)" ')

# Move all to (0, 0), then move laptop screen down
swaymsg "output * position 0 0; output eDP-1 position $(( (${ext_w:-laptop_w} - laptop_w) / 2 )) ${ext_h:-0}"
