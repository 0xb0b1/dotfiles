#!/bin/bash

# XMonad Layout Selector with Rofi
# Visual layout picker with descriptions and icons

declare -A layouts=(
    ["📐 ResizableTall - Traditional master/stack"]="ResizableTall"
    ["🔲 ThreeCol - Editor + Terminal + Browser"]="ThreeCol"
    ["⚌ TwoPane - Side-by-side split"]="TwoPane"
    ["⊞ Grid - Auto grid arrangement"]="Grid"
    ["🌀 Spiral - Fibonacci spiral layout"]="Spiral"
    ["🌿 Dwindle - Organic window flow"]="Dwindle"
    ["📋 Accordion - Stacked windows"]="Accordion"
    ["📑 Tabbed - Browser-like tabs"]="Tabbed"
    ["✚ Cross - Four-way split"]="Cross"
    ["📏 FixedColumn - Fixed terminal width"]="FixedColumn"
    ["⭕ Circle - Circular arrangement"]="Circle"
    ["🎈 Float - Floating windows"]="Float"
    ["🖥️ Full - Fullscreen layout"]="Full"
)

# Rofi theme configuration
ROFI_THEME="
window {
    width: 60%;
    height: 50%;
    background-color: #24283B;
    border: 2px solid #5294E2;
    border-radius: 8px;
}

listview {
    columns: 1;
    lines: 8;
    spacing: 5px;
    scrollbar: false;
    background-color: transparent;
}

element {
    padding: 12px;
    border-radius: 4px;
    background-color: transparent;
    text-color: #ABB2BF;
}

element selected {
    background-color: #5294E2;
    text-color: #24283B;
}

element-text {
    font: \"Vanilla Caramel 12\";
}

inputbar {
    children: [ prompt, entry ];
    background-color: #292d37;
    border-radius: 4px;
    padding: 8px;
    margin: 0px 0px 20px 0px;
}

prompt {
    text-color: #5294E2;
    font: \"Vanilla Caramel Bold 12\";
}

entry {
    text-color: #ABB2BF;
    font: \"Vanilla Caramel 12\";
}
"

# Create menu options
menu_options=""
for description in "${!layouts[@]}"; do
    menu_options+="$description\n"
done

# Show rofi menu
selected=$(echo -e "$menu_options" | rofi -dmenu -i -p "󰕮 Select Layout:" -theme-str "$ROFI_THEME")

# Handle selection
if [ -n "$selected" ]; then
    layout_name="${layouts[$selected]}"
    if [ -n "$layout_name" ]; then
        # Send message to xmonad to switch layout
        xmonad --restart-layout "$layout_name" 2>/dev/null || {
            # Fallback: use xdotool to send layout cycling keys
            case "$layout_name" in
                "ResizableTall") xdotool key super+shift+space super+space ;;
                "ThreeCol") xdotool key super+shift+space $(for i in {1..1}; do echo super+space; done) ;;
                "TwoPane") xdotool key super+shift+space $(for i in {1..2}; do echo super+space; done) ;;
                "Grid") xdotool key super+shift+space $(for i in {1..3}; do echo super+space; done) ;;
                "Spiral") xdotool key super+shift+space $(for i in {1..4}; do echo super+space; done) ;;
                "Dwindle") xdotool key super+shift+space $(for i in {1..5}; do echo super+space; done) ;;
                "Accordion") xdotool key super+shift+space $(for i in {1..6}; do echo super+space; done) ;;
                "Tabbed") xdotool key super+shift+space $(for i in {1..7}; do echo super+space; done) ;;
                "Cross") xdotool key super+shift+space $(for i in {1..8}; do echo super+space; done) ;;
                "FixedColumn") xdotool key super+shift+space $(for i in {1..9}; do echo super+space; done) ;;
                "Circle") xdotool key super+shift+space $(for i in {1..10}; do echo super+space; done) ;;
                "Float") xdotool key super+shift+space $(for i in {1..11}; do echo super+space; done) ;;
                "Full") xdotool key super+shift+space $(for i in {1..12}; do echo super+space; done) ;;
            esac
        }
        
        # Show notification
        notify-send "Layout Changed" "Switched to: $layout_name" -i window-layout -t 2000
    fi
fi