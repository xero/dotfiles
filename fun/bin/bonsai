#!/usr/bin/env bash

# I'm a bonsai-making machine!

#################################################
##
# author:  John Allbritten
# license: GPLv3
# repo:    https://gitlab.com/jallbrit/bonsai.sh
#
#  this script is constantly being updated, so
#  check repo for most up-to-date version.
##
#################################################

# ------ vars ------
# CLI options

live=0
infinite=0
nfetch=0

termSize=1
termColors=0
leafStrs='&'
baseType=1
message=""

multiplier=5
lifeStart=28

timeStep=0.03
timeWait=4

flag_m=0
flag_h=0

# non-CLI options
messageWidth=20
verbose=0
seed="$RANDOM"

# ensure locale is correct
LC_ALL="en_US.UTF-8"

# ensure Bash version >= 4.0
if ((BASH_VERSINFO[0] < 4)); then
	printf '%s\n' "Error: bonsai.sh requires Bash v4.0 or higher. You have version $BASH_VERSION."
fi

# ensure MacOS compatibility with GNU getopt
if [[ "$OSTYPE" == 'darwin'* ]]; then
    GGETOPT=/usr/local/Cellar/gnu-getopt/*/bin/getopt # should find gnu-getopt
    if [ ! -x $GGETOPT ]; then # file is not executable
        printf '%s\n' 'Error: Running on MacOS requires an executable gnu getopt.'
        exit 2
    fi
    shopt -s expand_aliases
    alias getopt='$GGETOPT' # replace getopt with gnu getopt
fi

# ------ parse options ------

OPTS="hlt:w:ig:c:Tm:b:M:L:s:vn"	# the colon means it requires a value
LONGOPTS="help,live,time:,wait:,infinite,geometry:,leaf:,termcolors,message:,base:,multiplier:,life:,seed:,verbose,neofetch"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
	case "$1" in
		-h|--help)
			flag_h=1
			shift
			;;

		-l|--live)
			live=1
			shift
			;;

		-t|--time)
			timeStep="$2"
			shift 2
			;;

		-w|--wait)
			timeWait="$2"
			shift 2
			;;

		-g|--geometry)
			termSize=0
			geometry="$2"
			shift 2
			;;

		-c|--leaf)
			leafStrs="$2"
			shift 2
			;;

		-T|--termcolors)
			termColors=1
			shift
			;;

		-m|--message)
			flag_m=1
			message="$2"
			shift 2
			;;

		-b|--base)
			baseType="$2"
			shift 2
			;;

		-i|--infinite)
			infinite=1
			shift 1
			;;

		-M|--multiplier)
			multiplier="$2"
			shift 2
			;;

		-L|--life)
			lifeStart="$2"
			shift 2
			;;

		-s|--seed)
			RANDOM="$2"
			shift 2
			;;

		-v|--verbose)
			verbose=1
			shift 1
			;;

		-n|--neofetch)
			nfetch=1
			shift 1
			;;

		--) # end of arguments
			shift
			break
			;;

		*)
			printf '%s\n' "error while parsing CLI options"
			flag_h=1
			;;
	esac
done

# ------ check input ------

# ensure integer values
if ! [ "$lifeStart" -eq "$lifeStart" 2> /dev/null ]; then
	printf '%s\n' "--life ($lifeStart) invalid: must be an integer"; exit 1

elif ! [ "$multiplier" -eq "$multiplier" 2> /dev/null ]; then
	printf '%s\n' "--multiplier ($multiplier) invalid: must be an integer"; exit 1

elif ! [ "$baseType" -eq "$baseType" 2> /dev/null ]; then
	printf '%s\n' "--base ($baseType) invalid: must be an integer"; exit 1

# ensure ranges
elif [ "$baseType" -lt 0 ]; then
	printf '%s\n' "--base ($baseType) invalid: out of range"; exit 1

elif [ "$lifeStart" -lt 1 ] || [ "$lifeStart" -gt 200 ]; then
	printf '%s\n' "--life ($lifeStart) invalid: out of range"; exit 1

elif [ "$multiplier" -lt 0 ] || [ "$multiplier" -gt 20 ]; then
	printf '%s\n' "--multiplier ($multiplier) invalid: out of range"; exit 1

elif [ "$seed" -lt 0 ] || [ "$seed" -gt 32767 ]; then
	printf '%s\n' "--seed ($seed) invalid: out of range"; exit 1

# ensure floats are less than 0
elif [ "$(printf '%s\n' "$timeStep < 0" | bc -l)" -eq 1 ]; then
	printf '%s\n' "--timestep ($timeStep) invalid: out of range"; exit 1

elif [ "$(printf '%s\n' "$timeWait < 0" | bc -l)" -eq 1 ]; then
	printf '%s\n' "--wait ($timeWait) invalid: out of range"; exit 1
fi

HELP="\
Usage: bonsai [OPTIONS]

bonsai.sh is a beautifully random bonsai tree generator.

optional args:
  -l, --live             live mode
  -t, --time TIME        in live mode, minimum time in secs between
                           steps of growth [default: 0.03]
  -i, --infinite         infinite mode
  -w, --wait TIME        in infinite mode, time in secs between
                           tree generation [default: 4]
  -n, --neofetch         neofetch mode
  -m, --message STR      attach message next to the tree
  -T, --termcolors       use terminal colors
  -g, --geometry X,Y     set custom geometry
  -b, --base INT         ascii-art plant base to use, 0 is none
  -c, --leaf STR1,STR2,STR3...   list of strings randomly chosen for leaves
  -M, --multiplier INT   branch multiplier; higher -> more
                           branching (0-20) [default: 5]
  -L, --life INT         life; higher -> more growth (0-200) [default: 28]
  -s, --seed INT         seed random number generator (0-32767)
  -v, --verbose          print information each step of generation
  -h, --help             show help"

if ((flag_h)); then
	printf '%s\n' "$HELP"
	exit 0
fi

shopt -s checkwinsize 	# allows variables $COLUMNS/$LINES to be used

trap 'quit' SIGINT	# respond to CTRL+C
trap 'setGeometry' WINCH	# respond to window resize

IFS=$'\n'	# delimit by newline
((! nfetch)) && tabs 4

# define colors
if ((termColors)); then
	LightBrown='\e[1;33m'
	DarkBrown='\e[0;33m'
	BrownGreen='\e[1;32m'
	Green='\e[0;32m'
	Gray='\e[1;30m'
elif ((nfetch)); then
	LightBrown='${c1}'
	DarkBrown='${c2}'
	BrownGreen='${c3}'
	Green='${c4}'
	Gray='${c5}'
else
	LightBrown='\e[38;5;172m'
	DarkBrown='\e[38;5;130m'
	BrownGreen='\e[38;5;142m'
	Green='\e[38;5;106m'
	Gray='\e[38;5;243m'
fi
R='\e[0m'

# create ascii base in lines
case "$baseType" in
	1)
		width=15
		art="\
${Gray}:${Green}___________${DarkBrown}./~~\\.${Green}___________${Gray}:
 \\                          /
  \\________________________/
  (_)                    (_)"
		;;

	2)
		width=7
		art="\
${Gray}(${Green}---${DarkBrown}./~~\\.${Green}---${Gray})
 (          )
  (________)"
		;;

	3)
		width=15
		art="\
${Gray}╓${Green}───────────${DarkBrown}╭╱⎨⏆╲╮${Green}───────────${Gray}╖
║                            ║
╟────────────────────────────╢
╟────────────────────────────╢
╚════════════════════════════╝"
		;;

	*)  art="" ;;
esac

# get base height
baseHeight=0
for line in $art; do
	baseHeight=$(( baseHeight + 1 ))
done

# create leafArray
declare -A leafArray
leafArrayLen=0
# parse each string in comma-separated $leafStrs
for str in ${leafStrs//,/$'\n'}; do

	leafArray[$leafArrayLen,0]=${#str} 	# first item in sub-array is length

	# for character in string, add to the sub-array
	for (( i=0; i < ${#str}; i++ )); do
		leafArray[$leafArrayLen,$((i+1))]="${str:$i:1}"
	done
	leafArrayLen=$((leafArrayLen+1))
done

setGeometry() {
	if ((nfetch)) && ((termSize)); then
		geometry="$(tput cols),$(tput lines)"	# geometry must use tput in this mode
	elif ((termSize)); then
		geometry="$COLUMNS,$LINES"	# these vars automatically update
	fi
	cols="$(printf '%s' "$geometry" | cut -d ',' -f1)"	# width; X
	rows="$(printf '%s' "$geometry" | cut -d ',' -f2)"	# height; Y

	rows=$((rows - baseHeight)) 	# so we don't grow a tree on top of the base
}

init() {
	IFS=$'\n'	# delimit strings by newline

	# message processing
	if ((flag_m)); then
		declare -Ag gridMessage

		cols=$((cols - messageWidth - 8 )) 	# make room for the message to go on the right side
		message="$(printf '%s\n' "$message" | fold -sw $messageWidth)" 	# wordwrap message, delimiting by spaces

		# get number of lines in the message
		messageLineCount=0
		for line in $message; do
			messageLineCount=$((messageLineCount + 1))
		done

		messageOffset=$((rows - messageLineCount - 7))

		# put lines of message into a grid
		index=$messageOffset
		for line in $message; do
			gridMessage[$index]="$line"
			index=$((index + 1))
		done
	fi

	# add spaces before base so that it's in the middle of the terminal
	base=""
	iter=1
	for line in $art; do
		filler=""
		for (( i=0; i <= (cols / 2 - width); i++)); do
			filler+=" "
		done
		base+="${filler}${line}"
		[ $iter -ne $baseHeight ] && base+='\n'
		iter=$((iter+1))
	done	
	unset IFS	# reset delimiter

	# declare vars
	branches=0
	shoots=0

	branchesMax=$((multiplier * 110))
	shootsMax=$multiplier

	# fill grid full of spaces
	declare -Ag grid
	for (( row=0; row <= rows; row++ )); do
		listChanged[$row]=0
		for (( col=0; col < cols; col++ )); do
			grid[$row,$col]=' '
		done
	done

	if ((! nfetch)); then
		stty -echo 		# don't echo stdin
		printf '%b' '\e[?25l\e[?7l\e[2J' 	# hide cursor, disable line wrapping, clear screen and move to 0,0
	fi

	# setup temp file for caching times of each growth
	mkdir -p /tmp/bonsai.sh
	tmpFile="$(mktemp -p /tmp/bonsai.sh bonsai.sh.XXXXXXXX)"
}

grow() {
	local x=$((cols / 2))	# start halfway across the screen
	local y="$rows"		# start just above the base
	branch "$x" "$y" trunk "$lifeStart"
}

branch() {
	# declarations
	local x=$1
	local y=$2
	local type=$3
	local life=$4
	local dx=0
	local dy=0
	local chars=()


	branches=$((branches + 1))

	# as long as we're alive...
	while [ "$life" -gt 0 ]; do
		
		life=$((life - 1))	# ensure life ends

		# set dy based on type
		case $type in
			shoot*)	# trend horizontal/downward growth
				case "$((RANDOM % 10))" in
					[0-1]) dy=-1 ;;
					[2-7]) dy=0 ;;
					[8-9]) dy=1 ;;
				esac
				;;

			dying) # discourage vertical growth
				case "$((RANDOM % 10))" in
					[0-1]) dy=-1 ;;
					[2-8]) dy=0 ;;
					[9-10]) dy=1 ;;
				esac
				;;
				
			*)	# grow up/not at all
				dy=0
				[ "$life" -ne "$lifeStart" ] && [ $((RANDOM % 10)) -gt 2 ] && dy=-1
				;;
		esac
		# if we're about to hit the ground, cut it off
		[ "$dy" -gt 0 ] && [ "$y" -gt $(( rows - 1 )) ] && dy=0
		[ "$type" = "trunk" ] && [ "$life" -lt 4 ] && dy=0

		# set dx based on type
		case $type in
			shootLeft)	# tend left: dx=[-2,1]
				case $(( RANDOM % 10 )) in
					[0-1]) dx=-2 ;;
					[2-5]) dx=-1 ;;
					[6-8]) dx=0 ;;
					[9]) dx=1 ;;
				esac ;;

			shootRight)	# tend right: dx=[-1,2]
				case $(( RANDOM % 10 )) in
					[0-1]) dx=2 ;;
					[2-5]) dx=1 ;;
					[6-8]) dx=0 ;;
					[9]) dx=-1 ;;
				esac ;;

			dying)	# tend left/right: dx=[-3,3]
				dx=$(( (RANDOM % 7) - 3)) ;;

			*)	# tend equal: dx=[-1,1]
				dx=$(( (RANDOM % 3) - 1)) ;;

		esac

		# re-branch upon conditions
		if [ $branches -lt $branchesMax ]; then
			
			# branch is dead
			if [ $life -lt 3 ]; then
				branch "$x" "$y" dead "$life"

			# branch is dying and needs to branch into leaves
			elif [ "$type" = trunk ] && [ "$life" -lt $((multiplier + 2)) ]; then
				branch "$x" "$y" dying "$life"

			elif [[ $type = "shoot"* ]] && [ "$life" -lt $((multiplier + 2)) ]; then
				branch "$x" "$y" dying "$life"

			# re-branch if: not close to the base AND (pass a chance test OR be a trunk, not have too many shoots already, and not be about to die)
			elif [[ $type = trunk && $life -lt $((lifeStart - 8)) \
			&& ( $(( RANDOM % (16 - multiplier) )) -eq 0 \
			|| ($type = trunk && $(( life % 5 )) -eq 0 && $life -gt 5) ) ]]; then

				# if a trunk is splitting and not about to die, chance to create another trunk
				if [ $((RANDOM % 3)) -eq 0 ] && [ $life -gt 7 ]; then
					branch "$x" "$y" trunk "$life"

				elif [ "$shoots" -lt "$shootsMax" ]; then

					# give the shoot some life
					tmpLife=$(( life + multiplier - 2 ))
					[ $tmpLife -lt 0 ] && tmpLife=0

					# first shoot is randomly directed	
					if [ $shoots -eq 0 ]; then
						tmpType="shootLeft"
						[ $((RANDOM % 2)) -eq 0 ] && tmpType="shootRight"

					# secondary shoots alternate from the first
					else
						case "$tmpType" in
							shootLeft) # last shoot was left, shoot right
								tmpType="shootRight" ;;
							shootRight) # last shoot was right, shoot left
								tmpType="shootLeft" ;;
						esac
					fi
					branch "$x" "$y" "$tmpType" "$tmpLife"
					shoots=$((shoots + 1))
				fi
			fi
		else # we're past max branches but want to branch
			chars=('<->')
		fi

		# implement dx,dy
		x=$((x + dx))
		y=$((y + dy))
		
		# choose color
		case $type in
			trunk|shoot*)
				color=$DarkBrown
				[ $(( RANDOM % 4 )) -eq 0 ] && color=$LightBrown
				;;

			dying) color=$BrownGreen ;;

			dead) color=$Green ;;
		esac

		# choose branch character
		case $type in
			trunk)
				if [ $dx -lt 0 ]; then
					chars=('\\')
				elif [ $dx -eq 0 ]; then
					chars=('/' '|')
				elif [ $dx -gt 0 ]; then
					chars=('/')
				fi
				[ $dy -eq 0 ] && chars=('/' '~')	# not growing
				#[ $dy -lt 0 ] && chars=('/' '~')	# growing
				;;

			# shoots tend to look horizontal
			shootLeft)
				case $dx in
					[-3,-1]) 	chars=('\\' '|') ;;
					[0]) 		chars=('/' '|') ;;
					[1,3]) 		chars=('/') ;;
				esac
				#[ $dy -lt 0 ] && chars=('/' '~')	# growing up
				[ $dy -gt 0 ] && chars=('/')	# growing down
				[ $dy -eq 0 ] && chars=('\\' '_')	# not growing
				;;

			shootRight)
				case $dx in
					[-3,-1]) 	chars=('\\' '|') ;;
					[0]) 		chars=('/' '|') ;;
					[1,3]) 		chars=('/') ;;
				esac
				#[ $dy -lt 0 ] && chars=('')	# growing up
				[ $dy -gt 0 ] && chars=('\\')	# growing down
				[ $dy -eq 0 ] && chars=('_' '/')	# not growing
				;;
		esac

		# randomly choose leaf character
		if [ $life -lt 4 ]; then
			chars=()
			randIndex=$((RANDOM % leafArrayLen))

			# add each char in our randomly chosen list to our chars
			for (( i=0; i < ${leafArray[$randIndex,0]}; i++)); do
				chars+=("${leafArray[$randIndex,$((i+1))]}")
			done
		fi
		# [ $life -eq 0 ] && chars=('&' '&') 	# eh, maybe

		((verbose)) && printf '%b\n' "$life:\\t$x, $y: $char"
		
		# add this/these character(s) to our grid
		index=0
		for char in "${chars[@]}"; do
			newX=$((x+index))
			grid[$y,$newX]="${color}${char}"

			# ensure we keep track of last column
			[ ${y:-0} -gt 0 ] && [ -n "${listChanged[$y]}" ] && [ ${newX:-0} -gt ${listChanged[$y]} ] && listChanged[$y]=$newX
			index=$((index+1))
		done

		# print what we have so far
		if ((live)); then
			( time -p display ) 2>"$tmpFile"
			elapsed="$(head "$tmpFile" -n 1 | awk '{print $2}' )"
			# if this step took less than $stepTime, sleep until $stepTime is met
			timeLeft="$(printf '%s\n' "$timeStep - $elapsed" | bc -l)"
			[ "$(printf '%s\n' "($timeLeft) > 0" | bc -l)" -eq 1 ] && sleep "$timeLeft"
		fi
	done	
}

display() {
	# parse grid for output
	output=""
	for (( row=0; row < rows; row++)); do
		lineArray=()

		# only parse to the last known column with a char in it
		for (( col=0; col <= listChanged[row]; col++ )); do

			((live)) && printf '%b' '\e[0;0H' 	# move cursor to 00

			# grab the character from our grid
			lineArray["$col"]="${grid[$row,$col]}"
		done
		line="${lineArray[*]}" 	# combine array elements into a string

		if ((flag_m)) || ((nfetch)); then
			line="${line%${line##*[^[:space:]]}}" 	# remove trailing whitespace and reset color
		fi

		# add our message unless line is blank
		((flag_m)) && [ ! "$line" = "" ] && line+='   \t'"${R}${gridMessage[$row]}"

		IFS=''
		output+="$line\\n"
	done

	output+="$base" 	# add the ascii-art base we generated earlier	
	printf '%b' "$output"
}

quit() {
	if ((! nfetch)); then
		stty echo 	# echo stdin
		printf '%b\n' '\e[?25h\e[?7h'"${R}" 	# show cursor, enable line wrapping, reset colors
		tabs 8
	else
		printf '\n' 	# reset formatting, put cursor on next line
	fi
	exit 0
}

bonsai() {
	setGeometry
	init
	grow
	display
}

main() {
	bonsai
	while ((infinite)); do
		sleep "$timeWait"
		bonsai
	done
}

main
quit
