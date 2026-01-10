#!/usr/bin/env bash
# ML4W Theme Kenose

# Set waybar
echo "/kenose;/kenose" > $HOME/.config/ml4w/settings/waybar-theme.sh
$HOME/.config/waybar/launch.sh &

# Set nwg-dock-hyprland
echo "kenose" > $HOME/.config/ml4w/settings/dock-theme
$HOME/.config/nwg-dock-hyprland/launch.sh &

# Set swaync
echo '@import "themes/kenose/style.css";' > $HOME/.config/swaync/style.css
swaync-client -rs

# Set wlogout
echo '@import "themes/kenose/style.css";' > $HOME/.config/wlogout/style.css

# Set launcher
echo 'rofi' > $HOME/.config/ml4w/settings/launcher

# Set walker theme
echo 'kenose' > $HOME/.config/ml4w/settings/walker-theme

# Set Window Border
echo 'source = ~/.config/hypr/conf/windows/border-2.conf' > $HOME/.config/hypr/conf/window.conf

# Set rofi
echo '* { border-width: 2px; }' > $HOME/.config/ml4w/settings/rofi-border.rasi

echo ":: Theme set to Kenose"