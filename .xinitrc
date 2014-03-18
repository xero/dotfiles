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
xrdb -merge "${HOME}/.Xresources"
 
# start the terminal emulator daemon
urxvtd -q -f -o &
 
# gnome keyring
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &

# wifi
(sleep 1s && nm-applet) &

# power management
(sleep 2s && xfce4-power-manager) &

# sound mixer
(sleep 2s && pnmixer) &

# volume keys daemon
(sleep 2s && xfce4-volumed) &

# enable backlight
(sleep 2s && xbacklight -inc 100) &

# compositing manager
compton -b &

# start thunar daemon
thunar --daemon &

# automount drives
udisks-glue -c ~/.udisk-glue.conf --session &

# wallpaper
nitrogen --restore &&

# configure touchpad
syndaemon -i 0.8 -d &

# clipboard manager
(sleep 3s && clipit) &

# keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
xset r rate 250 25 &

# disable system beep
xset b off &

# fix cursors. for a minute :/
xsetroot -cursor_name left_ptr

# start the rock
mpd &

# setup fonts
xset +fp ~/.fonts
xset fp rehash

# ░▒▓█ get awesome! █▓▒░
exec awesome
