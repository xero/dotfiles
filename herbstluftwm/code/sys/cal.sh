#!/bin/bash
# popup calendar for dzen
font="-Gohu-GohuFont-Medium-R-Normal--11-80-100-100-C-60-ISO10646-1"
TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`
LINES=$(cal -m | wc -l)
LINES=$((LINES + 2))

(
date +'^bg(#666666) '
date +''
# current month, highlight header and today
cal -m | sed -r -e "1,2 s/.*/^fg(#737373)&^fg()/"  -e "s/(^| )($TODAY)($| )/\1^bg(#6A8C8C)^fg(#000000)\2^fg()^bg()\3/") | dzen2 -x 1290 -y 4 -w 146 -h 12 -l $LINES -sa c -p -e 'onstart=uncollapse,hide;button1=exit;' -fg "#909090" -tw 6 -fn "$font"
)
