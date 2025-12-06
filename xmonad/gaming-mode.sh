#!/bin/bash

# Gaming Mode Toggle for XMonad
# Toggles between gaming and normal desktop mode

GAMING_MODE_FILE="/tmp/xmonad-gaming-mode"

enable_gaming() {
	# Stop compositor for lower latency
	pkill picom

	# Set CPU to performance
	echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null

	# NVIDIA settings - max performance & vibrance
	nvidia-settings -a "[dpy:DP-2]/DigitalVibrance=1023" >/dev/null 2>&1
	nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" >/dev/null 2>&1

	# Disable mouse acceleration
	MOUSE_ID=$(xinput list | grep -i "mouse" | grep -vi "keyboard\|virtual" | head -1 | grep -oP 'id=\K\d+')
	if [ -n "$MOUSE_ID" ]; then
		xinput --set-prop "$MOUSE_ID" 'libinput Accel Profile Enabled' 0, 1 2>/dev/null
		xinput --set-prop "$MOUSE_ID" 'libinput Accel Speed' 0.0 2>/dev/null
	fi

	# Hide dock for immersion
	pkill plank

	touch "$GAMING_MODE_FILE"
	dunstify -a "xmonad" -h string:x-canonical-private-synchronous:gaming-mode \
		-u normal -t 2000 "🎮  Gaming Mode ON"
}

disable_gaming() {
	# Restart compositor
	picom --config ~/.config/picom/picom.conf &

	# Set CPU to powersave
	echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null

	# NVIDIA settings - normal
	nvidia-settings -a "[dpy:DP-2]/DigitalVibrance=500" >/dev/null 2>&1
	nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=0" >/dev/null 2>&1

	# Re-enable mouse acceleration (default)
	MOUSE_ID=$(xinput list | grep -i "mouse" | grep -vi "keyboard\|virtual" | head -1 | grep -oP 'id=\K\d+')
	if [ -n "$MOUSE_ID" ]; then
		xinput --set-prop "$MOUSE_ID" 'libinput Accel Profile Enabled' 1, 0 2>/dev/null
		xinput --set-prop "$MOUSE_ID" 'libinput Accel Speed' 0.0 2>/dev/null
	fi

	# Restart dock
	plank &

	rm -f "$GAMING_MODE_FILE"
	dunstify -a "xmonad" -h string:x-canonical-private-synchronous:gaming-mode \
		-u normal -t 2000 "🖥️  Desktop Mode ON"
}

# Toggle based on current state
if [ -f "$GAMING_MODE_FILE" ]; then
	disable_gaming
else
	enable_gaming
fi
