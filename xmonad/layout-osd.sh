#!/usr/bin/env bash

# Layout OSD - Catppuccin styled notification
# Usage: layout-osd.sh "Layout Name"

LAYOUT_NAME="${1:-unknown}"
LAYOUT_FILE="/tmp/xmonad-current-layout"

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

# Get icon for layout
ICON="${ICONS[$LAYOUT_NAME]:-󰕰}"

# Clean layout name (remove "Spacing " prefix if present)
CLEAN_NAME="${LAYOUT_NAME#Spacing }"

# Save current layout for tint2 executor
echo "$CLEAN_NAME" > "$LAYOUT_FILE"

# Show notification
dunstify \
    -a "xmonad" \
    -h string:x-canonical-private-synchronous:xmonad-layout \
    -h string:x-dunst-stack-tag:layout \
    -u normal \
    -t 1000 \
    "$ICON  $CLEAN_NAME"
