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
    pkill rofi || rofi -show drun -run-command "uwsm-app -- {cmd}"
}

# Use Wofi+UWSM
_launch_wofi_uwsm() {
    pkill wofi || uwsm app -- "$(D=$(wofi --show drun --define=drun-print_desktop_file=true); case "$D" in *'.desktop '*) echo "${D%.desktop *}.desktop:${D#*.desktop }";; *) echo "$D";; esac)"
}

if [ "$launcher" == "walker" ]; then
    _launch_walker
elif [ "$launcher" == "wofi" ]; then
    _launch_wofi_uwsm
else
    _launch_rofi_uwsm
fi
