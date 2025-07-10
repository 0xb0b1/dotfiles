#!/bin/bash

# Polybar Layout Updater
# Monitors XMonad layout changes and updates polybar

POLYBAR_PID=$(pgrep -f "polybar.*main" | head -1)

if [ -z "$POLYBAR_PID" ]; then
    echo "Polybar not found, starting it..."
    ~/.config/bspwm/themes/onedark/polybar/launch.sh &
    exit 0
fi

# Function to refresh polybar layout module
refresh_layout_module() {
    # Send USR1 signal to polybar to refresh modules
    polybar-msg cmd restart > /dev/null 2>&1 || {
        # Fallback: restart polybar if msg command fails
        ~/.config/bspwm/themes/onedark/polybar/launch.sh &
    }
}

# Monitor for layout changes using inotify or polling
monitor_changes() {
    local last_layout=""
    local last_workspace=""
    
    while true; do
        current_workspace=$(xprop -root _NET_CURRENT_DESKTOP 2>/dev/null | grep -oP '\d+' || echo "0")
        current_windows=$(xdotool search --onlyvisible --class "" 2>/dev/null | wc -l)
        
        # Create a simple "layout signature"
        layout_signature="${current_workspace}_${current_windows}"
        
        if [ "$layout_signature" != "$last_layout" ] || [ "$current_workspace" != "$last_workspace" ]; then
            refresh_layout_module
            last_layout="$layout_signature"
            last_workspace="$current_workspace"
        fi
        
        sleep 2
    done
}

# Check if already running
if pgrep -f "polybar-updater.sh" | grep -v $$ > /dev/null; then
    echo "Polybar updater already running"
    exit 0
fi

# Start monitoring in background
monitor_changes &

echo "Polybar layout updater started (PID: $!)"