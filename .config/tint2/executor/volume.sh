#!/usr/bin/env sh

# Desc:   Get status or control audio-volume via `pamixer` (supports >100%).
# SPDX-License-Identifier: ISC

. "${HOME}/.joyfuld" 2>/dev/null

STEPS="${AUDIO_VOLUME_STEPS:-5}"

case "${1}" in
    +) pamixer --allow-boost -i "$STEPS"; exit 0
    ;;
    -) pamixer --allow-boost -d "$STEPS"; exit 0
    ;;
    0) pamixer -t; exit 0
    ;;
esac

AUDIO_VOLUME="$(pamixer --get-volume 2>/dev/null || echo 0)"
AUDIO_MUTED="$(pamixer --get-mute 2>/dev/null)"

if [ "$AUDIO_MUTED" = "true" ]; then
    MUTED='Muted'
    ICON=''
elif [ "$AUDIO_VOLUME" -eq 0 ]; then
    ICON=''
elif [ "$AUDIO_VOLUME" -lt 30 ]; then
    ICON=''
elif [ "$AUDIO_VOLUME" -lt 70 ]; then
    ICON=''
elif [ "$AUDIO_VOLUME" -le 100 ]; then
    ICON=''
else
    ICON=''
fi

case "${1}" in
    icon) echo "$ICON"
    ;;
    per*) echo "${MUTED:-${AUDIO_VOLUME}%}"
    ;;
esac
