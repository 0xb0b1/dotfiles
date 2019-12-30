#!/bin/sh

xset s off
xset -dpms
xset r rate 400 50
xsetroot -def &
xbacklight -set 20
xrdb -load .Xresources_green &
setxkbmap -model abnt2 -layout br
xsetroot -cursor_name left_ptr &
redshift -l 0.01:-99.0 -g 0.6 -t 3500:3500 -r randr &
synclient TapButton1=1 TapButton2=2 TapButton3=3

exec xmonad

