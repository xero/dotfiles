#!/bin/sh

exec 1>&2 2>/dev/null

BOOTSTRAP=$(dirname `readlink -f $0`)
XRESOURCES=$BOOTSTRAP/xresources
PATH="$PATH:$BOOTSTRAP/bin"

export XRESOURCES PATH BOOTSTRAP

# merge custom x resources
xrdb -merge "${HOME}/.Xdefaults" &

# custom keymappings
xmodmap ~/.xmodmap

# terminal emulator
urxvtd -q -f -o &

# compositing manager
compton -b --config ~/.config/compton.conf &

# configure touchpad
syndaemon -i 0.8 -d &
if egrep -iq 'touchpad' /proc/bus/input/devices; then
	synclient VertEdgeScroll=0 &
	synclient TapButton1=1 &
	synclient TapButton2=1 &
	synclient TapButton3=2 &
	synclient VertTwoFingerScroll=1 &
	synclient HorizTwoFingerScroll=1 &
fi

# keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
xset r rate 250 25 &

# disable system beep
xset b off &

# start the rock
mpd &

# wallpaper
hsetroot -full ~/images/wallpaper/cyberpunk-5.png

# default cursor
xsetroot -cursor_name left_ptr

# hotkey daemon
sxhkd -c ~/.sxhkdrc &

# ░▒▓█ wmutis █▓▒░
~/bin/wm &
exec ~/bin/xwait
