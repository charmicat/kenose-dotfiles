#!/usr/bin/env bash

# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
launcher=$(cat "$HOME"/.config/ml4w/settings/launcher)

# Use Walker
_launch_walker() {
    "$HOME"/.config/walker/launch.sh --height 500
}

# Use Rofi
_launch_rofi() {
    pkill rofi || rofi -show drun -replace -i
}

# Use Rofi+UWSM
_launch_rofi_uwsm() {
    pkill rofi || rofi -show drun -run-command "uwsm app -- {cmd}"
}

if [ "$launcher" == "walker" ]; then
    _launch_walker
else
    _launch_rofi_uwsm
fi
