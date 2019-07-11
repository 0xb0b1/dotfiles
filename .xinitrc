#!/bin/sh

xset s off
xset -dpms
xset r rate 400 50
xsetroot -def &
xbacklight -set 20
setxkbmap -model abnt2 -layout br
redshift -l 0.01:-99.0 -g 0.5 -r randr &
synclient TapButton1=1 TapButton2=2 TapButton3=3

exec xmonad

