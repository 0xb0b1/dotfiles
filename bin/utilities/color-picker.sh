#!/bin/sh

color=$(gpick -pso --no-newline)
image=$(xdg-user-dir CACHE)/$color.png

if [ "$color" ]; then
  echo "$color" | tr -d "\n" | xclip -selection clipboard
  convert -size 48x48 xc:"$color" "$image"
  notify-send -a "Color Picker" -u low -i "$image" "$color" "Copied to clipboard"
fi