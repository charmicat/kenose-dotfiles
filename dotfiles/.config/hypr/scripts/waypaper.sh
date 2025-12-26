#!/usr/bin/env bash
# Source library.sh
source "$HOME"/.config/ml4w/library.sh

ml4w_cache_folder="$HOME/.cache/ml4w/hyprland-dotfiles"
killall waypaper 2>/dev/null
# Will be set when waypaper is running
waypaperrunning=$ml4w_cache_folder/waypaper-running
if [ -f "$waypaperrunning" ]; then
    killall waypaper
    rm "$waypaperrunning"
fi

if [ -f /usr/bin/waypaper ]; then
    _writeLog ":: Launching waypaper in /usr/bin"
    waypaper "$1" &
    touch "$waypaperrunning"
elif [ -f "$HOME"/.local/bin/waypaper ]; then
    _writeLog ":: Launching waypaper in $HOME/.local/bin"
    "$HOME"/.local/bin/waypaper "$1" &
    touch "$waypaperrunning"
else
    _writeLog ":: waypaper not found"
fi
