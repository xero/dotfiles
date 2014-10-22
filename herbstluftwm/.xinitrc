#!/bin/sh
#
#          ██          ██   ██                 
#         ░░          ░░   ░██                 
#  ██   ██ ██ ███████  ██ ██████ ██████  █████ 
# ░░██ ██ ░██░░██░░░██░██░░░██░ ░░██░░█ ██░░░██
#  ░░███  ░██ ░██  ░██░██  ░██   ░██ ░ ░██  ░░ 
#   ██░██ ░██ ░██  ░██░██  ░██   ░██   ░██   ██
#  ██ ░░██░██ ███  ░██░██  ░░██ ░███   ░░█████ 
# ░░   ░░ ░░ ░░░   ░░ ░░    ░░  ░░░     ░░░░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

# merge custom x resources
xrdb -merge "${HOME}/.Xdefaults" &
 
# terminal emulator
urxvtd -q -f -o &

# keyring
gnome-keyring-daemon &

# wifi
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
(sleep 2s && nm-applet --sm-disable) &

# power management
(sleep 2s && xfce4-power-manager) &

# sound mixer
(sleep 2s && pnmixer) &

# volume keys
(sleep 2s && xfce4-volumed) &

# compositing manager
compton -b --config ~/.config/compton.conf &

# file manager
thunar --daemon &

# automount drives
udisks-glue -c ~/.config/.udisk-glue.conf --session &

# wallpaper
nitrogen --restore &

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

# clipboard manager
(sleep 3s && clipit) &

# keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
xset r rate 250 25 &

# disable system beep
xset b off &

# start the rock
mpd &

# setup fonts
xset +fp ~/.fonts &
xset fp rehash &

# work setup
xscreensaver -no-splash &
bash ~/.screenlayout/work.sh &

# ░▒▓█ herbstluft █▓▒░
exec herbstluftwm --locked 
