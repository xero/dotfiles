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

# made the magic happen
sudo insmod /home/x0/src/Linux-Magic-Trackpad-2-Driver/linux/drivers/hid/hid-magicmouse.ko

# display
if [ $(xrandr | grep ' connected' | wc -l) -gt 1 ]; then
	~/.screenlayout/multi.sh &
else
	~/.screenlayout/solo.sh &
	# keyboard backlight
	kbd on &
fi

# merge custom x resources
xrdb -merge ~/.Xdefaults &

# fix + autohide cursor
xsetroot -cursor_name left_ptr &
unclutter &

# 2bwm
~/bin/wm &
exec xwait
