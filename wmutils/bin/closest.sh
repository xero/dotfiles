#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# find and focus the closest window in a specific direction
# depends on: focus.sh

# get current window id
CUR=$(pfw)

usage() {
    echo "usage: $(basename $0) <direction>" >&2
    exit 1
}

next_east() {
    lsw | xargs wattr xi | sort -nr | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_west() {
    lsw | xargs wattr xi | sort -n | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_north() {
    lsw | xargs wattr yi | sort -nr | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

next_south() {
    lsw | xargs wattr yi | sort -n | sed "0,/$CUR/d" | sed "1s/^[0-9]* //p;d"
}

# Use the specification of your choice: WASD, HJKL, ←↑↓→, west/north/south/east
case $1 in
    h|a|east|left)  focus.sh $(next_east)  2>/dev/null ;;
    j|s|south|down) focus.sh $(next_south) 2>/dev/null ;;
    k|w|north|up)   focus.sh $(next_north) 2>/dev/null ;;
    l|d|west|right) focus.sh $(next_west)  2>/dev/null ;;
    *) usage
esac
