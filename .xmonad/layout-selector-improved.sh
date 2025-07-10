#!/bin/bash

# XMonad Layout Selector with Visual Preview
# More intuitive layout selection with descriptions

# Layout descriptions with emojis and use cases
declare -a layout_options=(
    "📐 ResizableTall - Classic tiling (good for coding + terminal)"
    "🔲 ThreeCol - Three columns (editor + terminal + browser)"
    "⚌ TwoPane - Side-by-side split (compare files/dual view)"
    "⊞ Grid - Auto grid layout (multiple terminals/monitoring)"
    "🌀 Spiral - Fibonacci spiral (aesthetic + focus on main)"
    "🌿 Dwindle - Organic flow (similar to spiral but different)"
    "📋 Accordion - Vertical stack (file comparison/logs)"
    "📑 Tabbed - Browser tabs (many windows, small screen)"
    "✚ Cross - Four-way split (quad view)"
    "📏 FixedColumn - Fixed width (consistent terminal size)"
    "⭕ Circle - Circular layout (unique arrangement)"
    "🎈 Float - Floating windows (manual positioning)"
    "🖥️ Full - Fullscreen (presentations/focus mode)"
)

# Current layout detection
get_current_layout() {
    xprop -root | grep "_NET_DESKTOP_LAYOUT" | cut -d'"' -f2 2>/dev/null || echo "Unknown"
}

current_layout=$(get_current_layout)

# Rofi configuration with better styling
rofi_config="
configuration {
    show-icons: false;
    font: \"Vanilla Caramel 11\";
    display-drun: \"󰕮 Layout Selector\";
}

window {
    width: 65%;
    height: 60%;
    background-color: #24283B;
    border: 2px solid #5294E2;
    border-radius: 10px;
    padding: 10px;
}

listview {
    columns: 1;
    lines: 10;
    spacing: 8px;
    scrollbar: true;
    background-color: transparent;
    border: 0px;
}

scrollbar {
    width: 8px;
    background-color: #292d37;
    handle-color: #5294E2;
    border-radius: 4px;
}

element {
    padding: 15px 20px;
    border-radius: 6px;
    background-color: #292d37;
    text-color: #ABB2BF;
    border: 1px solid transparent;
}

element selected {
    background-color: #5294E2;
    text-color: #24283B;
    border: 1px solid #ABB2BF;
}

element-text {
    font: \"Vanilla Caramel 11\";
    vertical-align: 0.5;
}

inputbar {
    children: [ prompt, entry ];
    background-color: #292d37;
    border-radius: 6px;
    padding: 12px 15px;
    margin: 0px 0px 15px 0px;
    border: 1px solid #5294E2;
}

prompt {
    text-color: #5294E2;
    font: \"Vanilla Caramel Bold 12\";
    margin: 0px 10px 0px 0px;
}

entry {
    text-color: #ABB2BF;
    font: \"Vanilla Caramel 11\";
    placeholder: \"Type to filter layouts...\";
    placeholder-color: #5a6477;
}

textbox-prompt-colon {
    text-color: #5294E2;
    font: \"Vanilla Caramel Bold 12\";
}
"

# Create temporary config file
config_file="/tmp/rofi-layout-config"
echo "$rofi_config" > "$config_file"

# Show the menu
selected=$(printf '%s\n' "${layout_options[@]}" | rofi -dmenu -i -p "󰕮 Choose Layout" -theme "$config_file" -no-custom)

# Clean up
rm -f "$config_file"

# Process selection
if [ -n "$selected" ]; then
    # Extract layout number (position in array)
    for i in "${!layout_options[@]}"; do
        if [[ "${layout_options[$i]}" == "$selected" ]]; then
            layout_index=$i
            break
        fi
    done
    
    if [ -n "$layout_index" ]; then
        # Reset to first layout, then cycle to desired layout
        xdotool key "super+shift+space"
        sleep 0.1
        
        # Cycle to the selected layout
        for ((j=0; j<layout_index; j++)); do
            xdotool key "super+space"
            sleep 0.05
        done
        
        # Extract layout name for notification
        layout_name=$(echo "$selected" | cut -d' ' -f2)
        layout_desc=$(echo "$selected" | cut -d'-' -f2- | sed 's/^ *//')
        
        # Show notification with layout info
        notify-send "Layout Switched" "Active: $layout_name\n$layout_desc" \
            -i preferences-desktop-theme \
            -t 3000 \
            -u normal
    fi
fi