#!/bin/sh
#
# wildefyr - 2015 (c) wtfpl
# toggle delete lock for current window

usage() {
    echo "usage: $(basename $0) <lock|unlock|toggle|status> <wid>"
    exit 1
}

wid=$(pfw)

case $2 in
    0x*)
        wid=$2
        ;;
    *)
        usage
        ;;
esac

case $1 in
    lock)
        xprop -id $wid -f _WMUTILS_DELETELOCK 8i -set _WMUTILS_DELETELOCK '1'
        ;;
    unlock)
        xprop -id $wid -remove _WMUTILS_DELETELOCK
        ;;
    toggle)
        lockStatus=$(xprop -id $wid _WMUTILS_DELETELOCK | cut -d\  -f 3)
        case $lockStatus in
            1)
                $(basename $0) unlock $wid 
                ;;
            *)
                $(basename $0) lock $wid 
                ;;
        esac
        ;;
    status)
        lockStatus=$(xprop -id $wid _WMUTILS_DELETELOCK | cut -d\  -f 3)
        case $lockStatus in
            1)
                echo "1"
                ;;
            *)
                echo "0"
                ;;
        esac
        ;;
    *)
        usage
        ;;
esac
