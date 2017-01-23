#!/bin/sh
#
# z3bra - 2015 (c) wtfpl
# make the current window "rainbowish"... Awesome idea from xero@nixers.net !

FREQ=${FREQ:-0.1}
COLORS="888888 8064cc 6480cc 64cccc 80cc64 cccc64 cc6464"
CUR=$(pfw)

while :; do
    for c in $COLORS; do
        chwb -c $c $(pfw) 
        sleep $FREQ
    done
done
