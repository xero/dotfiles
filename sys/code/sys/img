#!/bin/bash
#
# z3bra -- 2014-01-21
# requires `w3m` package

test -z "$1" && exit

W3MIMGDISPLAY="/usr/lib/w3m/w3mimgdisplay"
FILENAME=$1
FONTH=14 # Size of one terminal row
FONTW=8  # Size of one terminal column
COLUMNS=`tput cols`
LINES=`tput lines`

read width height <<< `echo -e "5;$FILENAME" | $W3MIMGDISPLAY`

max_width=$(($FONTW * $COLUMNS))
max_height=$(($FONTH * $(($LINES - 2)))) # substract one line for prompt

if test $width -gt $max_width; then
height=$(($height * $max_width / $width))
width=$max_width
fi
if test $height -gt $max_height; then
width=$(($width * $max_height / $height))
height=$max_height
fi

w3m_command="0;1;0;0;$width;$height;;;;;$FILENAME\n4;\n3;"

tput cup $(($height/$FONTH)) 0
echo -e $w3m_command|$W3MIMGDISPLAY