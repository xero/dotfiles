#!/bin/sh
#
#          ██   ██      ██
#   █████ ░░   ░██     ░░
#  ██░░░██ ██ ██████    ██  ██████
# ░██  ░██░██░░░██░    ░██ ██░░░░██
# ░░██████░██  ░██     ░██░██   ░██
#  ░░░░░██░██  ░██     ░██░██   ░██
#   █████ ░██  ░░██  ██░██░░██████
#  ░░░░░  ░░    ░░  ░░ ░░  ░░░░░░
#
# create short / vanity github urls
#         ▟▙
# ▟▒░░░░░░░▜▙▜████████████████████████████████▛
# ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
#         ▜▛
# xero / syntax-samurai <http://git.io/gitio.sh>

usage () {
    cat <<EOF

         ▟▙
 ▟▒░░░░░░░▜▙▜████████████████████████████████▛
 ▜▒░░░░░░░▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
         ▜▛

 create short / vanity github urls
 usage: $(basename $0) http://github.com/something [-v mini]
 
 options:
  -v   shortlink
  -h   display this screen
EOF
	exit 0
}

err() {
	echo $1
	usage	
}

optstest() {
	found=0
	for arg in "$@"
	do
		if echo $arg | cut -d/ -f3 | grep -q "github.com\|raw.githubusercontent.com"
		then
			GHURL=$arg
			found=1
		elif [ $arg = "-h" ]
		then
			usage
		elif [ $arg = "-v" ]
		then
			:
		else
			VANITY=$arg
		fi
	done
	if [ $found = 0 ]
	then
		err " must be a valid github.com url!"
	fi
}

case $# in
	1)
		optstest $1 ;;
	3)
		optstest $1 $2 $3 ;;
	*)
		err " invalid number of arguments!" ;;
esac

if [ -z "$VANITY" ]
then
	curl -i http://git.io -F "url=$GHURL"
else
	curl -i http://git.io -F "url=$GHURL" -F "code=$VANITY"
fi
