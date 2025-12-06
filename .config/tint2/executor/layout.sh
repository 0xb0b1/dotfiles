#!/usr/bin/env bash

LAYOUT_FILE="/tmp/xmonad-current-layout"

# Read current layout from file
if [[ -f "$LAYOUT_FILE" ]]; then
    LAYOUT=$(cat "$LAYOUT_FILE")
else
    LAYOUT="tall"
fi

# Layout icons (Nerd Font)
declare -A ICONS=(
    ["tall"]="󰯋"
    ["wide"]="󰯌"
    ["three"]="󰕴"
    ["center"]="󰘸"
    ["grid"]="󰕰"
    ["spiral"]="󱗼"
    ["tabbed"]="󰓩"
    ["float"]="󰖲"
    ["full"]="󰊓"
)

# Get icon for layout (default to tall icon)
ICON="${ICONS[$LAYOUT]:-󰯋}"

echo "$ICON"
