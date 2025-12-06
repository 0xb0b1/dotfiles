#!/usr/bin/env sh

# Desc:   Get hardware temperature for tint2 panel.
# Author: Harry Kurn <alternate-se7en@pm.me>
# URL:    https://github.com/owl4ce/dotfiles/tree/ng/.config/tint2/executor/temp.sh

# SPDX-License-Identifier: ISC

export LANG='POSIX'
exec 2>/dev/null
. "${HOME}/.joyfuld"

# Try hwmon first (for AMD/Intel CPUs), then fallback to thermal_zone
if [ -f "/sys/class/hwmon/${TEMP_DEV}/temp1_input" ]; then
    IFS= read -r TEMP <"/sys/class/hwmon/${TEMP_DEV}/temp1_input"
    echo "$((TEMP/1000))˚C"
elif [ -f "/sys/devices/virtual/thermal/${TEMP_DEV}/temp" ]; then
    IFS= read -r TEMP <"/sys/devices/virtual/thermal/${TEMP_DEV}/temp"
    echo "$((TEMP/1000))˚C"
else
    echo "N/A"
fi

exit ${?}
