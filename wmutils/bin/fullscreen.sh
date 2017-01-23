#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# toggle the fullscreen state of a window
# depends on: focus.sh

# this file is used to store the previous geometry of a window
FSFILE=${FSFILE:-~/.fwin}

# it's pretty simple, but anyway...
usage() {
    echo "usage: $(basename $0) <wid>"
    exit 1
}

# exit if no argument given
test -z "$1" && usage

# this will unset the fullscreen state of any fullscreen window if there is one.
# this way, there will only be one window in fullscreen at a time, and no window
# will loose their previous geometry info
test -f $FSFILE && wtp $(cat $FSFILE)

# if file exist and contain our window id, it means that out window is in
# fullscreen mode
if test -f $FSFILE && grep -q $1 $FSFILE; then
    # if the window we removed was our window, delete the file, so we can
    # fullscreen it again later 
    rm -f $FSFILE

else
    # if not, then put the current window in fullscreen mode, after saving its
    # geometry and id to $FSFILE we also remove any border from this window.
    wattr xywhi $1 > $FSFILE
    wtp $(wattr xywh `lsw -r`) $1
    chwb -s 0 $1
fi

# now focus the window, and put it in front, no matter which state we're in, and
# put the cursor on its bottom-right corner (for consistency)
focus.sh $1
