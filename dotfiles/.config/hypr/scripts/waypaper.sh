#!/usr/bin/env bash
# Source library.sh
source "$HOME"/.config/ml4w/library.sh

ml4w_cache_folder="$HOME/.cache/ml4w/hyprland-dotfiles"
_writeLog ":: Cache folder: $ml4w_cache_folder"

killall waypaper 2>/dev/null
# Will be set when waypaper is running
waypaperrunning=$ml4w_cache_folder/waypaper-running
killall waypaper
rm "$waypaperrunning"

echo "================================"
echo "$@"
echo "================================"
if [ -f /usr/bin/waypaper ]; then
    _writeLog ":: Launching waypaper in /usr/bin"
    waypaper $@ &
    touch "$waypaperrunning"
elif [ -f "$HOME"/.local/bin/waypaper ]; then
    _writeLog ":: Launching waypaper in $HOME/.local/bin"
    "$HOME"/.local/bin/waypaper $@ &
    touch "$waypaperrunning"
else
    _writeLog ":: waypaper not found"
fi

if [ -f "$waypaperrunning" ]; then
    _writeLog "Waypaper started successfully"
else
    _writeLog "Waypaper failed to start"
fi
