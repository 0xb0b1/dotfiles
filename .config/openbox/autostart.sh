#!/usr/bin/env sh
#
# These things are run when an Openbox X Session is started.
# You may place a similar script in "${HOME}/.config/openbox/autostart" to run user-specific things.
#
# https://github.com/owl4ce/dotfiles
#
# shellcheck disable=SC3044,SC2091,SC2086
# ---

exec >/dev/null 2>&1
. "${HOME}/.joyfuld"

# https://gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#:~:text=expand_aliases
[ -z "$BASH" ] || shopt -s expand_aliases

{ [ "$(joyd_launch_apps -g terminal)" = 'termite' ] && termite -f -q; } &

#{ pidof -s pulseaudio -q || pulseaudio --start --log-target=syslog; } &

joyd_toggle_mode apply
joyd_tray_programs exec

picom --experimental-backends -b

xset s off
xset -dpms
xset r rate 584 69
xrandr --output HDMI-A-0 --mode 2560x1080 --rate 74.99
redshift -l 0.0.1:-99.0 -g 0.8 -t 4000:4000 -r randr

if [ -x "$(command -v lxpolkit)" ]; then
    lxpolkit &
else
    $(find ${LIBS_PATH} -type f -iname 'polkit-gnome-authentication-agent-*' | sed 1q) &
fi

{ [ -x "$(command -v xss-lock)" ] && xss-lock -q -l "${JOYD_DIR}/xss-lock-tsl.sh"; } &

joyd_mpd_notifier

# Any additions should be added below.
