#!/bin/bash

# Workspace Preview and Quick Switcher
# Shows visual workspace overview with window counts

declare -A workspace_info=(
    ["ONE"]="🔧 Development - Code, terminals, git"
    ["TWO"]="🌐 Web & Research - Browsers, docs"
    ["THREE"]="💬 Communication - Chat, email, calls"
    ["FOUR"]="🎵 Media & Files - Music, videos, files"
    ["FIVE"]="📚 Learning - Books, courses, notes"
    ["SIX"]="🎯 Focus - Single task workspace"
)

declare -A workspace_colors=(
    ["ONE"]="#98C379"
    ["TWO"]="#61AFEF"
    ["THREE"]="#E06C75"
    ["FOUR"]="#D19A66"
    ["FIVE"]="#C678DD"
    ["SIX"]="#56B6C2"
)

# Get current workspace
current_workspace=$(xprop -root _NET_CURRENT_DESKTOP | cut -d' ' -f3)

# Build workspace list
workspace_list=""
for ws in "ONE" "TWO" "THREE" "FOUR" "FIVE" "SIX"; do
    info="${workspace_info[$ws]}"
    color="${workspace_colors[$ws]}"
    
    # Get window count (simplified)
    window_count=$(xdotool search --desktop $(($(echo $ws | tr -d '[:alpha:]'))) --onlyvisible "" 2>/dev/null | wc -l)
    
    # Mark current workspace
    if [ "$current_workspace" = "$(echo $ws | tr '[:upper:]' '[:lower:]')" ]; then
        workspace_list+="● $ws - $info (${window_count} windows)\n"
    else
        workspace_list+="○ $ws - $info (${window_count} windows)\n"
    fi
done

# Rofi theme for workspace preview
rofi_theme="
window {
    width: 70%;
    height: 40%;
    background-color: #24283B;
    border: 2px solid #5294E2;
    border-radius: 12px;
    padding: 15px;
}

listview {
    columns: 1;
    lines: 6;
    spacing: 10px;
    scrollbar: false;
    background-color: transparent;
}

element {
    padding: 15px 20px;
    border-radius: 8px;
    background-color: #292d37;
    text-color: #ABB2BF;
    border: 2px solid transparent;
}

element selected {
    background-color: #5294E2;
    text-color: #24283B;
    border: 2px solid #ABB2BF;
}

element-text {
    font: \"Vanilla Caramel 11\";
    vertical-align: 0.5;
}

inputbar {
    children: [ prompt, entry ];
    background-color: #292d37;
    border-radius: 8px;
    padding: 12px 20px;
    margin: 0px 0px 20px 0px;
    border: 2px solid #5294E2;
}

prompt {
    text-color: #5294E2;
    font: \"Vanilla Caramel Bold 12\";
    margin: 0px 15px 0px 0px;
}

entry {
    text-color: #ABB2BF;
    font: \"Vanilla Caramel 11\";
}
"

# Show workspace selector
selected=$(echo -e "$workspace_list" | rofi -dmenu -i -p "🚀 Workspace Navigator" -theme-str "$rofi_theme")

if [ -n "$selected" ]; then
    # Extract workspace name
    workspace=$(echo "$selected" | cut -d' ' -f2)
    
    if [ -n "$workspace" ]; then
        # Switch to workspace using xdotool
        case "$workspace" in
            "ONE") xdotool key "super+1" ;;
            "TWO") xdotool key "super+2" ;;
            "THREE") xdotool key "super+3" ;;
            "FOUR") xdotool key "super+4" ;;
            "FIVE") xdotool key "super+5" ;;
            "SIX") xdotool key "super+6" ;;
        esac
        
        # Show notification
        notify-send "Workspace Switched" "Now on: $workspace\n${workspace_info[$workspace]}" \
            -i preferences-desktop-workspace \
            -t 2000
    fi
fi