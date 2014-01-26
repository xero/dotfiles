#!/bin/bash
RAINS=("|" "│" "┃" "┆" "┇" "┊" "┋" "╽" "╿")
COLORS=("\e[37m" "\e[37;1m")
# More from 256 color mode
for i in {244..255}; do
  COLORS=("${COLORS[@]}" "\e[38;5;${i}m")
done
NRAINS=${#RAINS[@]}
NCOLORS=${#COLORS[@]}
NUM_RAIN_METADATA=5


sigwinch() {
  TERM_WIDTH=$(tput cols)
  TERM_HEIGHT=$(tput lines)
  STEP_DURATION=0.025
  ((MAX_RAINS = TERM_WIDTH * TERM_HEIGHT / 4))
  ((MAX_RAIN_LENGTH = TERM_HEIGHT < 10 ? 1 : TERM_HEIGHT / 10))
  # In percentage
  ((NEW_RAIN_ODD = TERM_HEIGHT > 50 ? 100 : TERM_HEIGHT * 2))
  ((NEW_RAIN_ODD = NEW_RAIN_ODD * 75 / 100))
  ((FALLING_ODD = TERM_HEIGHT > 25 ? 100 : TERM_HEIGHT * 4))
  ((FALLING_ODD = FALLING_ODD * 90 / 100))
  }

do_exit() {
  echo -ne "\e[${TERM_HEIGHT};1H\e[0K"

  # Show cursor and echo stdin
  echo -ne "\e[?25h"
  stty echo
  exit 0
  }

do_render() {
  # Clean screen first
  for ((idx = 0; idx < num_rains * NUM_RAIN_METADATA; idx += NUM_RAIN_METADATA)); do
    X=${rains[idx]}
    Y=${rains[idx + 1]}
    LENGTH=${rains[idx + 4]}
    for ((y = Y; y < Y + LENGTH; y++)); do
      (( y < 1 || y > TERM_HEIGHT )) && continue
      echo -ne "\e[${y};${X}H "
    done
  done

  for ((idx = 0; idx < num_rains * NUM_RAIN_METADATA; idx += NUM_RAIN_METADATA)); do
    if ((100 * RANDOM / 32768 < FALLING_ODD)); then
      # Falling
      if ((++rains[idx + 1] > TERM_HEIGHT)); then
        # Out of screen, bye sweet <3
        rains=("${rains[@]:0:idx}"
               "${rains[@]:idx+NUM_RAIN_METADATA:num_rains*NUM_RAIN_METADATA}")
        ((num_rains--))
        continue
      fi
    fi
    X=${rains[idx]}
    Y=${rains[idx + 1]}
    RAIN=${rains[idx + 2]}
    COLOR=${rains[idx + 3]}
    LENGTH=${rains[idx + 4]}
    for ((y = Y; y < Y + LENGTH; y++)); do
      (( y < 1 || y > TERM_HEIGHT )) && continue
      echo -ne "\e[${y};${X}H${COLOR}${RAIN}"
    done
  done
  }

trap do_exit TERM INT
trap sigwinch WINCH
# No echo stdin and hide the cursor
stty -echo
echo -ne "\e[?25l"

echo -ne "\e[2J"
rains=()
sigwinch
while :; do
  read -n 1 -t $STEP_DURATION ch
  case "$ch" in
    q|Q)
      do_exit
      ;;
  esac

  if ((num_rains < MAX_RAINS)) && ((100 * RANDOM / 32768 < NEW_RAIN_ODD)); then
    # Need new |, 1-based
    RAIN="${RAINS[NRAINS * RANDOM / 32768]}"
    COLOR="${COLORS[NCOLORS * RANDOM / 32768]}"
    LENGTH=$((MAX_RAIN_LENGTH * RANDOM / 32768 + 1))
    X=$((TERM_WIDTH * RANDOM / 32768 + 1))
    Y=$((1 - LENGTH))
    rains=("${rains[@]}" "$X" "$Y" "$RAIN" "$COLOR" "$LENGTH")
    ((num_rains++))
  fi

  # Let rain fall!
  do_render
done