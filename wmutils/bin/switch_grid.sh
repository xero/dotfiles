#!/bin/sh
#
# Copyright (c) 2015 Greduan <me@greduan.com>, licensed under the WTFPL license
# Credit where credit is due, the grid algorithm was written by z3bra
#
# When used puts all the windows in a grid and when you focus one of the windows
# it puts all the windows back to their original location and focuses the window
# you switched to.
# depends on: wew focus.sh

TEMP=$(mktemp) && wattr xywhi $(lsw) > $TEMP
NB=$(wc -l < $TEMP) # NB as in NumBer of windows

# just safety
if [ $NB -eq 1 ]; then
    exit
fi

# user defined
BW=${BW:-4} # width of your borders
GAP=${GAP:-20} # gap between windows

# get monitor dimensions
ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)
# reduce screen useable screen area to improve later expressions
SW=$(( SW - GAP - 2*BW ))
SH=$(( SH - GAP - 2*BW ))

# calculate the size of the grid using the square root of the number of windows
ROWS=$(echo "sqrt($NB)" | bc)
COLS=$ROWS

# FOLLOWING WAS WRITTEN BY Z3BRA, don't give me credit for this awesome logic
# for each row...
for r in `seq 1 $ROWS`; do

    # .. if we're on the last row, display all the remaining windows
    # eg: if we have 12 windows, the square root would be 3 (truncated).
    # so the script would draw a 3x3 grid. This would leave 3 windows apart. To
    # avoid this, we set the number of columns of the last row as
    #
    #    12 - 3 * (3-1)
    # => 12 - 3 * 2
    # => 12 - 6
    # == 6
    # so we will have 6 windows on the last row, instead of 3.
    # This do not lead to the best looking grid, I know (the best one would be
    # 3x4), but it's the simplest algo I've found. Don't forget we're playing
    # with shell scripts here, not matlab..
    test $r -eq $ROWS && COLS=$(( NB - ROWS * (ROWS-1) ))

    # for each column of each row..
    for c in `seq 1 $COLS`; do

        # exit if we don't have other windows to display
        test $(( (r-1)*r + c )) -gt $NB && break

        # heigh of windows (total heigh minus gaps and borders)
        H=$(( SH/ROWS - GAP - BW ))
        # same for width
        W=$(( SW/COLS - GAP - BW ))

        # and the tricky part..
        # The X offset is the width * the actual column (starting from 0) + the
        # gaps/borders multiplied by the column number (draw it on a sheet of
        # paper like me, it will make much more sense!
        X=$(( W * (c-1) + c*(GAP + BW) ))
        # same for the Y offset
        Y=$(( H * (r-1) + r*(GAP + BW) ))

        # finally, teleport the window to the place we just calculated.
        # the sed trick is used to get the corresponding line number in the file
        # holding the window infos.
        wtp $X $Y $W $H $(sed "$(( (r-1)*r + c ))p;d" $TEMP | cut -d\  -f5)
    done
done
# END Z3BRA

# listen to wew for our desired event
wew -m 4 | while IFS=: read ev wid; do
    if [ $ev -eq 4 ]; then
        while read line; do
            wtp $line
        done < $TEMP
        focus.sh $wid
        killall wew
    fi
done

# cleanup
rm $TEMP
