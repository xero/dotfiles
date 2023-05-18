#!/bin/bash
# Animated pipes.sh terminal screensaver at an angle.
# Copyright (c) 2013-2015 Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Website: https://github.com/pipeseroni/pipesX.sh

VERSION=1.1.0

W=$(tput cols) H=$(tput lines)
# maximal random value + 1
M=32768

SETS=('╱╲' '/\' '..' 'oo' '\/')
COLORS=(31 32 33 34 35 36 37)

# default values
N=1
T=()
I=0.05
P=25
R=$((W * H / 4))

HELP="Usage: $(basename $0) [OPTIONS]
Animated pipes.sh terminal screensaver at an angle.

Options:

  -n [1-]     number of pipes. (Default: $N)
  -t [0-$((${#SETS[@]} - 1))]    types of pipes, can be used more than once. (Default: $T)
  -t c[2chs]  custom type of pipes.
  -i [float]  piping interval or maze generation interval. (Default: $I)
  -P [0-100]  probability of a turning pipe or of \\ in maze generation. (Default: $P)
  -r [LIMIT]  reset after x characters, 0 if no limit. (Default: $R)
  -R          random starting point.
  -C          no color.
  -X          maze generation.
  -h          this help message.
  -v          print version number.
"

while getopts "n:t:i:P:r:RCXhv" arg; do
  case $arg in
    n)
      ((N = OPTARG > 0 ? OPTARG : N))
      ;;
    t)
      if [[ "$OPTARG" = c?? ]]; then
        T+=(${#SETS[@]})
        SETS+=("${OPTARG:1}")
      else
        T+=($(((OPTARG >= 0 && OPTARG < ${#SETS[@]}) ? OPTARG : T)))
      fi
      ;;
    i)
      I=$OPTARG
      ;;
    P)
      ((P = (OPTARG >= 0 && OPTARG <= 100) ? OPTARG : P))
      ;;
    r)
      ((R = OPTARG >= 0 ? OPTARG : R))
      ;;
    R)
      RNDSTART=1
      ;;
    C)
      NOCOLOR=1
      ;;
    X)
      MAZE=1
      ;;
    h)
      echo -e "$HELP"
      exit 0
      ;;
    v)
      echo "$(basename -- "$0") $VERSION"
      exit 0
  esac
done

# set to default values if not by options
((${#T[@]})) || T=(0)

do_exit() {
  # clear up standard input
  read -t 0.001 && cat </dev/stdin>/dev/null

  # terminal has no smcup and rmcup capabilities
  ((FORCE_RESET)) && reset && exit 0

  tput rmcup
  tput cnorm
  stty echo
  ((NOCOLOR)) && echo -ne '\e[0m'
  exit 0
  }
trap do_exit HUP TERM
trap 'break 2' INT

# No echo stdin and hide the cursor
stty -echo
tput smcup || FORCE_RESET=1
tput civis
tput clear

# maze geneartion
while [[ $MAZE ]] && clear; do
  [[ $NOCOLOR ]] || echo -ne "\e[1;${COLORS[${#COLORS[@]} * RANDOM / M]}m"
  for ((i = 0; i < W * H; i++ )); do
    echo -ne ${SETS[T]:100 * RANDOM / M < P:1}
  done
  read -t $I -n 1 && [[ $REPLY =~ q|Q ]] && do_exit
done

# initialze values
for ((n = 0; n < N; n++)); do
  ((X[n] = RNDSTART ? (W + 2) * RANDOM / M : W / 2))
  ((Y[n] = RNDSTART ? (H + 2) * RANDOM / M : H / 2))
  D[n]=$((4 * RANDOM / M))
  C[n]=${COLORS[${#COLORS[@]} * RANDOM / M]}
  t[n]=${T[${#T[@]} * RANDOM / M]}
done

clear
while REPLY=; read -t $I -n 1; [[ -z $REPLY ]] ; do
  for ((n = 0; n < N; n++, CC = 0)); do
    x=${X[n]} y=${Y[n]}
    d=${D[n]} c=${C[n]}

    # calculate new direction `d`
    # 1  0
    #  \/  4 directions 0 to 3
    #  /\
    # 2  3
    # valid directions: d: dd', d' is the new direction
    # d
    # 0:  / 00 \  01          03
    #    /     /           /\
    # 1:  / 10 \  11    12
    #     \     \    /\
    # 2:       \/ 21  / 22  / 23
    #                /      \
    # 3: \/ 30       \  32 \  33
    #                /      \
    ((d = (100 * RANDOM / M) < P ? ((d + 1) + 2 * (RANDOM % 2)) % 4 : d))
    ((e = (d + 1) % 4))

    # calculate new position
    # d'  x'  y'
    # 0: x+1 y-1
    # 1: x-1 y-1
    # 2: x-1 y+1
    # 3: x+1 y+1
    ((xn = e < 2 ? x + 1 : x - 1))
    ((yn = d < 2 ? y - 1 : y + 1))
    
    # adjust position and change color?
    ((d < 2 && y == 0)) && ((yn--, CC=1))
    ((e > 1 && x == 0)) && ((xn--, CC=1))
    ((d > 1 && y == H)) && ((yn++, CC=1))
    ((e < 2 && x == W)) && ((xn++, CC=1))
    ((CC)) && c=${COLORS[${#COLORS[@]} * RANDOM / M]}
    ((CC)) && t[n]=${T[${#T[@]} * RANDOM / M]}

    # warp pipe
    ((xn = (xn + W + 1) % (W + 1)))
    ((yn = (yn + H + 1) % (H + 1)))

    # calculate position in terminal
    # d'  xt   yt
    # 0: x'   y'+1
    # 1: x'+1 y'+1
    # 2: x'+1 y'
    # 3: x'   y'
    ((xt = e < 2 ? xn : xn + 1))
    ((yt = d < 2 ? yn + 1 : yn))

    echo -ne "\e[${yt};${xt}H"
    [[ $NOCOLOR ]] || echo -ne "\e[1;${c}m"
    echo -n "${SETS[t[n]]:d%2:1}"

    X[n]=$xn Y[n]=$yn
    D[n]=$d C[n]=$c
  done
  ((R)) && ((r += N, r >= R)) && r=0 && clear
done

do_exit
