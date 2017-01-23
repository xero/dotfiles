#!/bin/sh
#
# wmutils/contrib>: snap.sh, 9/12/15 kekler 
# snaps focued window to the left, right, top, or bottom edge

usage() {
    echo "usage: $(basename $0) <direction>" >&2
    exit 1
}

# default values for gaps and master area
TOP_PANEL=${PANEL:-20}
GAP=${GAP:-5}

# get current window id and its borderwidth
PFW=$(pfw)
BW=$(wattr b $PFW)

# get root window's size
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

# calculate usable screen size (without borders and gaps)
SH=$((SH - TOP_PANEL))

snap_up() 
{
    wtp $GAP $((GAP + TOP_PANEL)) $((SW - 2*GAP - 2*BW)) $((SH/2 - 2*BW - GAP - GAP/2)) $PFW
}

snap_right() 
{
    wtp $((SW - SW/2 + GAP/2)) $((GAP + TOP_PANEL)) $((SW/2 - 2*BW - GAP - GAP/2)) $((SH - 2*BW - 2*GAP)) $PFW
}

snap_down() 
{
    wtp $GAP $((SH - SH/2 + GAP/2 + TOP_PANEL)) $((SW - 2*GAP - 2*BW)) $((SH/2 - 2*BW - GAP - GAP/2)) $PFW
}

snap_left()
{
    wtp $GAP $((GAP + TOP_PANEL)) $((SW/2 - 2*BW - GAP - GAP/2)) $((SH - 2*BW - 2*GAP)) $PFW
}

HSW=$((SW/2 - 2*BW - GAP - GAP/2))
HSH=$((SH/2 - 2*BW - GAP - GAP/2))

snap_tr()
{
    wtp $((SW - SW/2 + GAP/2)) $((GAP + TOP_PANEL)) $HSW $HSH $PFW
}

snap_br()
{
    wtp $((SW - SW/2 + GAP/2)) $((SH - SH/2 + GAP/2 + TOP_PANEL)) $HSW $HSH $PFW
}

snap_tl()
{
    wtp $GAP $((GAP + TOP_PANEL)) $HSW $HSH $PFW
}

snap_bl()
{
    wtp $GAP $((SH - SH/2 + GAP/2 + TOP_PANEL)) $HSW $HSH $PFW
}

case $1 in
    h|a|east|left)  snap_left ;;
    j|s|south|down) snap_down ;;
    k|w|north|up)   snap_up ;;
    l|d|west|right) snap_right ;;
    tr|northeast)   snap_tr ;;
    br|southeast)   snap_br ;;
    tl|northwest)   snap_tl ;;
    bl|southwest)   snap_bl ;;
esac

