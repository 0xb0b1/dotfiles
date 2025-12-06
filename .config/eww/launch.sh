#!/usr/bin/env bash

# EWW Bar Launcher for XMonad
# Usage: launch.sh [start|stop|toggle|reload]

EWW_BIN="eww"
CONFIG_DIR="$HOME/.config/eww"

start() {
    # Kill any existing eww daemon
    $EWW_BIN kill 2>/dev/null

    # Start eww daemon (handles SNI tray apps like Steam)
    $EWW_BIN daemon --config "$CONFIG_DIR" &
    sleep 0.5

    # Open the bar
    $EWW_BIN --config "$CONFIG_DIR" open bar

    # Initialize layout file if not exists
    if [[ ! -f /tmp/xmonad-current-layout ]]; then
        echo "tall" > /tmp/xmonad-current-layout
    fi

}

stop() {
    $EWW_BIN --config "$CONFIG_DIR" close-all
    $EWW_BIN kill 2>/dev/null
}

toggle() {
    if pgrep -x eww > /dev/null; then
        stop
    else
        start
    fi
}

reload() {
    stop
    sleep 0.3
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    toggle)
        toggle
        ;;
    reload)
        reload
        ;;
    *)
        echo "Usage: $0 [start|stop|toggle|reload]"
        echo ""
        echo "Commands:"
        echo "  start   - Start the eww bar"
        echo "  stop    - Stop the eww bar"
        echo "  toggle  - Toggle the eww bar"
        echo "  reload  - Reload the eww bar"
        exit 1
        ;;
esac
