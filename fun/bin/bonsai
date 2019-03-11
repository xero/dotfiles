#!/usr/bin/env bash

# I'm a bonsai-making machine!

#################################################
##
# author: John Allbritten
# my website: theSynAck.com
#
# repo: https://gitlab.com/jallbrit
#  script can be found in the bin/bin/fun folder.
#
# license: this script is published under GPLv3.
#  I don't care what you do with it, but I do ask
#  that you leave this message please!
#
# inspiration: http://andai.tv/bonsai/
#  andai's version was written in JS and served
#  as the basis for this script. Originally, this
#  was just a port.
##
#################################################

# ------ vars ------
# CLI options

flag_h=false
live=false
infinite=false

termCols=$(tput cols)
termRows=$(tput lines)
geometry="$((termCols - 1)),$termRows"

leafchar='&'
termColors=false

message=""
flag_m=false
basetype=1
multiplier=5

lifeStart=28
steptime=0.01	# time between steps 

# non-CLI options
lineWidth=4	# words per line

# ------ parse options ------

OPTS="hlt:ig:c:Tm:b:M:L:"	# the colon means it requires a value
LONGOPTS="help,live,time:,infinite,geo:,leaf:,termcolors,message:,base:,multiplier:,life:"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
	case "$1" in
		-h|--help)
			flag_h=true
			shift
			;;

		-l|--live)
			live=true
			shift
			;;

		-t|--time)
			steptime="$2"
			shift 2
			;;

		-i|--infinite)
			infinite=true
			shift
			;;

		-g|--geo)
			geo=$2
			shift 2
			;;

		-c|--leaf)
			leafchar="$2"
			shift 2
			;;

		-T|--termcolors)
			termColors=true
			shift
			;;

		-m|--message)
			flag_m=true
			message="$2"
			shift 2
			;;

		-b|--basetype)
			basetype="$2"
			shift 2
			;;

		-M|--multiplier)
			multiplier="$2"
			shift 2
			;;

		-L|--life)
			lifeStart="$2"
			shift 2
			;;

		--) # end of arguments
			shift
			break
			;;

		*)
			echo "error while parsing CLI options"
			flag_h=true
			;;
	esac
done

HELP="Usage: bonsai [-h] [-i] [-l] [-T] [-m message] [-t time] 
              [-g x,y] [ -c char] [-M 0-9]

bonsai.sh is a static and live bonsai tree generator, written in bash.

optional args:
  -l, --live             enable live generation
  -t, --time time        time between each step of growth [default: 0.01]
  -m, --message text     attach a message to the tree
  -b, --basetype 0-2     which ascii-art plant base to use (0 for none) [default: 1]
  -i, --infinite         keep generating trees until quit (2s between each)
  -T, --termcolors       use terminal colors
  -g, --geo geo          set custom geometry [default: fit to terminal]
  -c, --leaf char        character used for leaves [default: &]
  -M, --multiplier 0-9   branch multiplier; higher equals more branching [default: 5]
  -L, --life int         life of tree; higher equals more overall growth [default: 28]
  -h, --help             show help"

# check for help
$flag_h && echo -e "$HELP" && exit 0

# geometry processing
cols=$(echo "$geometry" | cut -d ',' -f1)	# width; X
rows=$(echo "$geometry" | cut -d ',' -f2)	# height; Y

IFS=$'\n'	# delimit strings by newline
tabs 4 		# set tabs to 4 spaces

declare -A gridMessage

# message processing
if [ $flag_m = true ]; then

	messageWidth=20

	# make room for the message to go on the right side
	cols=$((cols - messageWidth - 8 ))

	# wordwrap message, delimiting by spaces
	message="$(echo "$message" | fold -sw $messageWidth)"
	
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

# define colors
if [ $termColors = true ]; then
	LightBrown='\e[1;33m'
	DarkBrown='\e[0;33m'
	BrownGreen='\e[1;32m'
	Green='\e[0;32m'
else
	LightBrown='\e[38;5;172m'
	DarkBrown='\e[38;5;130m'
	BrownGreen='\e[38;5;142m'
	Green='\e[38;5;106m'
fi
Grey='\e[1;30m'
R='\e[0m'

# create ascii base in lines
base=""
case $basetype in
	0)
		base="" ;;
	
	1)
		width=15
		art="\
${Grey}:${Green}___________${DarkBrown}./~~\\.${Green}___________${Grey}:
 \\                          /
  \\________________________/
  (_)                    (_)"
		;;

	2)
		width=7
		art="\
${Grey}(${Green}---${DarkBrown}./~~\\.${Green}---${Grey})
 (          )
  (________)"
		;;
esac

# get base height
baseHeight=0
for line in $art; do
	baseHeight=$(( baseHeight + 1 ))
done

# add spaces before base so that it's in the middle of the terminal
iter=1
for line in $art; do
	filler=''
	for (( i=0; i < $(( (cols / 2) - width )); i++)); do
		filler+=" "
	done
	base+="${filler}${line}"
	[ $iter -ne $baseHeight ] && base+='\n'
	iter=$((iter+1))
done	
unset IFS	# reset delimiter

rows=$((rows - baseHeight))

declare -A grid	# must be done outside function for unknown reason

trap 'echo "press q to quit"' SIGINT	# disable CTRL+C

init() {
	branches=0
	shoots=0

	branchesMax=$((multiplier * 110))
	shootsMax=$multiplier

	# fill grid full of spaces
	for (( row=0; row < $rows; row++ )); do
		for (( col=0; col < $cols; col++ )); do
			grid[$row,$col]=' '
		done
	done

	# No echo stdin and hide the cursor
	if [ $live = true ]; then
		stty -echo
		echo -ne "\e[?25l"

	 	echo -ne "\e[2J"
	fi
}

grow() {
	local start=$((cols / 2))

	local x=$((cols / 2))		# start halfway across the screen
	local y=$rows	# start just above the base

	branch $x $y trunk $lifeStart
}

branch() {
	# argument declarations
	local x=$1
	local y=$2
	local type=$3
	local life=$4
	local dx=0
	local dy=0

	# check if the user is hitting q
	timeout=0.001
	[ $live = "false" ] && timeout=.0001
	read -n 1 -t $timeout input
	[ "$input" = "q" ] && clean "quit"

	branches=$((branches + 1))

	# as long as we're alive...
	while [ $life -gt 0 ]; do
		
		life=$((life - 1))	# ensure life ends

		# case $life in
		# 	[0]) type=dead ;;
		# 	[1-4]) type=dying ;;
		# esac

		# set dy based on type
		case $type in
			shoot*)	# if this is a shoot, trend horizontal/downward growth
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
				
			*)	# otherwise, let it grow up/not at all
				dy=0
				[ $life -ne $lifeStart ] && [ $((RANDOM % 10)) -gt 2 ] && dy=-1
				;;
		esac
		# if we're about to hit the ground, cut it off
		[ $dy -gt 0 ] && [ $y -gt $(( rows - 1 )) ] && dy=0
		[ $type = "trunk" ] && [ $life -lt 4 ] && dy=0

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
				branch $x $y dead $life

			# branch is dying and needs to branch into leaves
			elif [ $type = trunk ] && [ $life -lt $((multiplier + 2)) ]; then
				branch $x $y dying $life

			elif [[ $type = "shoot"* ]] && [ $life -lt $((multiplier + 2)) ]; then
				branch $x $y dying $life

			# re-branch if: not close to the base AND (pass a chance test OR be a trunk, not have too man shoots already, and not be about to die)
			elif [[ $type = trunk && $life -lt $((lifeStart - 8)) \
			&& ( $(( RANDOM % (16 - multiplier) )) -eq 0 \
			|| ($type = trunk && $(( life % 5 )) -eq 0 && $life -gt 5) ) ]]; then

				# if a trunk is splitting and not about to die, chance to create another trunk
				if [ $((RANDOM % 3)) -eq 0 ] && [ $life -gt 7 ]; then
					branch $x $y trunk $life

				elif [ $shoots -lt $shootsMax ]; then

					# give the shoot some life
					tmpLife=$(( life + multiplier - 2 ))
					[ $tmpLife -lt 0 ] && tmpLife=0

					# first shoot is randomly directed	
					if [ $shoots -eq 0 ]; then 
						tmpType=shootLeft
						[ $((RANDOM % 2)) -eq 0 ] && tmpType=shootRight


					# secondary shoots alternate from the first
					else
						case $tmpType in
							shootLeft) # last shoot was left, shoot right
								tmpType=shootRight ;;
							shootRight) # last shoot was right, shoot left
								tmpType=shootLeft ;;
						esac
					fi
					branch $x $y $tmpType $tmpLife
					shoots=$((shoots + 1))
				fi
			fi
		else # if we're past max branches but want to branch...
			char='<>'
		fi

		# implement dx,dy
		x=$((x + dx))
		y=$((y + dy))
		
		# choose color
		case $type in
			trunk|shoot*)
				color=${DarkBrown} 
				[ $(( RANDOM % 4 )) -eq 0 ] && color=${LightBrown}
				;;

			dying) color=${BrownGreen} ;;

			dead) color=${Green} ;;
		esac

		# choose branch character
		case $type in
			trunk)
				if [ $dx -lt 0 ]; then
					char='\\'
				elif [ $dx -eq 0 ]; then
					char='/|'
				elif [ $dx -gt 0 ]; then
					char='/'
				fi
				[ $dy -eq 0 ] && char='/~'	# not growing
				#[ $dy -lt 0 ] && char='/~'	# growing
				;;

			# shoots tend to look horizontal
			shootLeft)
				case $dx in
					[-3,-1]) 	char='\\|' ;;
					[0]) 		char='/|' ;;
					[1,3]) 		char='/' ;;
				esac
				#[ $dy -lt 0 ] && char='/~'	# growing up
				[ $dy -gt 0 ] && char='/'	# growing down
				[ $dy -eq 0 ] && char='\\_'	# not growing
				;;

			shootRight)
				case $dx in
					[-3,-1]) 	char='\\|' ;;
					[0]) 		char='/|' ;;
					[1,3]) 		char='/' ;;
				esac
				#[ $dy -lt 0 ] && char=''	# growing up
				[ $dy -gt 0 ] && char='\\'	# growing down
				[ $dy -eq 0 ] && char='_/'	# not growing
				;;

			#dead)
			#	#life=$((life + 1))
			#	char="${leafchar}"	
			#	[ $dx -lt -2 ] || [ $dx -gt 2 ] && char="${leafchar}${leafchar}"
			#	;;

			esac

		# set leaf if needed
		[ $life -lt 4 ] && char="${leafchar}"

		# uncomment for help debugging
		#echo -e "$life:\t$x, $y: $char"
		
		# put character in grid
		grid[$y,$x]="${color}${char}${R}"

		# if live, print what we have so far and let the user see it
		if [ $live = true ]; then
			print
			sleep $steptime
		fi
	done	
}

print() {
	# parse grid for output
	output=""
	for (( row=0; row < $rows; row++)); do

		line=""

		for (( col=0; col < $cols; col++ )); do

			# this prints a space at 0,0 and is necessary at the moment
			[ $live = true ] && echo -ne "\e[0;0H "

			# grab the character from our grid
			line+="${grid[$row,$col]}"
		done

		# add our message
		if [ $flag_m = true ]; then
			# remove trailing whitespace before we add our message
			line=$(sed -r 's/[ \t]*$//' <(printf "$line"))
			line+="   \t${gridMessage[$row]}"
		fi

		line="${line}\n"

		# end 'er with the ol' newline
		output+="$line"
	done

	# add the ascii-art base we generated earlier
	output+="$base"
	
	# output, removing trailing whitespace
	sed -r 's/[ \t]*$//' <(printf "$output")
}

clean() {
	# Show cursor and echo stdin
	if [ $live = true ]; then
		echo -ne "\e[?25h"
		stty echo
	fi

	echo ""	# ensure the cursor resets to the next line

	# if we wanna quit
	if [ "$1" = "quit" ]; then
		trap SIGINT	
		exit 0
	fi
}

bonsai() {
	init
	grow
	print
	clean
}

bonsai

while [ $infinite = true ]; do
	sleep 2
	bonsai
done
