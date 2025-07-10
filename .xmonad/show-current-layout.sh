#!/bin/bash

# Show current layout information
# Displays current layout name and description

declare -A layout_info=(
    ["ResizableTall"]="📐 Classic tiling layout - Master window on left, stack on right"
    ["ThreeCol"]="🔲 Three columns - Perfect for editor + terminal + browser"
    ["TwoPane"]="⚌ Side-by-side split - Great for comparing files or dual view"
    ["Grid"]="⊞ Auto grid layout - Ideal for multiple terminals or monitoring"
    ["Spiral"]="🌀 Fibonacci spiral - Aesthetic layout with focus on main window"
    ["Dwindle"]="🌿 Organic flow - Similar to spiral but with different proportions"
    ["Accordion"]="📋 Vertical stack - Perfect for file comparison or logs"
    ["Tabbed"]="📑 Browser-style tabs - Efficient for many windows on small screens"
    ["Cross"]="✚ Four-way split - Quad view layout"
    ["FixedColumn"]="📏 Fixed width columns - Consistent terminal sizing"
    ["Circle"]="⭕ Circular arrangement - Unique circular window placement"
    ["Float"]="🎈 Floating windows - Manual window positioning"
    ["Full"]="🖥️ Fullscreen mode - Single window covers entire screen"
)

# Try to get current layout (this is a simplified approach)
# In practice, you might want to integrate this with xmonad's logging
current_layout="ResizableTall"  # Default fallback

# Get window information to try to determine layout
window_count=$(xdotool search --onlyvisible --class "" 2>/dev/null | wc -l)

# Show layout info
layout_desc="${layout_info[$current_layout]}"
if [ -z "$layout_desc" ]; then
    layout_desc="🔄 Current Layout - $current_layout"
fi

notify-send "Current Layout" "$layout_desc\nWindows: $window_count" \
    -i preferences-desktop-theme \
    -t 4000 \
    -u low