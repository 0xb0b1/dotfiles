#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

DEFAULT_SESSION='bspwm'

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# redshift -l 0.01:-99.0 -g 0.8 -t 5400:5400 -r randr &
#nitrogen --set-auto nordic-wallpapers/wallpapers/arctic-landscape.png
xrandr --output eDP-1 --off
# xrandr --output DP-1 --mode 1920x1080 --rate 120.00 --primary
#xrandr --output DP-1 --mode 2560x1080 --rate 74.99
setxkbmap -option caps:escape

get_session() {
  local dbus_args=(--sh-syntax --exit-with-session)
  case $1 in
  awesome) dbus_args+=(awesome) ;;
  bspwm) dbus_args+=(bspwm-session) ;;
  budgie) dbus_args+=(budgie-desktop) ;;
  cinnamon) dbus_args+=(cinnamon-session) ;;
  deepin) dbus_args+=(startdde) ;;
  enlightenment) dbus_args+=(enlightenment_start) ;;
  fluxbox) dbus_args+=(startfluxbox) ;;
  gnome) dbus_args+=(gnome-session) ;;
  i3 | i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
  jwm) dbus_args+=(jwm) ;;
  kde) dbus_args+=(startplasma-x11) ;;
  lxde) dbus_args+=(startlxde) ;;
  lxqt) dbus_args+=(lxqt-session) ;;
  mate) dbus_args+=(mate-session) ;;
  xfce) dbus_args+=(xfce4-session) ;;
  openbox) dbus_args+=(openbox-session) ;;
  *) dbus_args+=($DEFAULT_SESSION) ;;
  esac

  echo "dbus-launch ${dbus_args[*]}"
}
exec $(get_session "$1")
