#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.style>
# ░▓ code   ▓ https://code.x-e.ro/dotfiles
# ░▓ mirror ▓ https://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

if [[ $(command -v starship) ]]; then
  eval "$(starship init zsh)"
else

#█▓▒░ allow functions in the prompt
setopt PROMPT_SUBST
autoload -Uz colors && colors

#█▓▒░ icons and colors
I_CMD="❯"
I_VI="❮"
P_CMD="─"
P_VI="┈"
I_DIRTY="󱐋"
I_AHEAD="⇡"
I_BEHIND="⇣"
I_DIVERGED="↕"
I_CONFLICTED=""
MODE="$I_CMD"
P="$P_CMD$P_CMD $P_CMD"
COLOR_ROOT="%F{red}"
COLOR_USER="%F{cyan}"
COLOR_NORMAL="%F{white}"
PROMPT_STYLE="minimal" # ascii|arrows|classic|dual|minimal|ninja

#█▓▒░ permission colors
[[ "$EUID" -ne "0" ]] && LVL="$COLOR_USER" || LVL="$COLOR_ROOT"

#█▓▒░ mode display
function zle-keymap-select {
  MODE="${${KEYMAP/vicmd/${I_VI}}/(main|viins)/${I_CMD}}"
  P_S="${${KEYMAP/vicmd/${P_VI}}/(main|viins)/${P_CMD}}"
	P="$P_S$P_S $P_S"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  MODE=$I_CMD
}
zle -N zle-line-finish

#█▓▒░ git prompt
GIT() {
  test=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ ! "$test" ]
  then
    case "$PROMPT_STYLE" in
      ascii)
        echo "$reset_color%F{cyan}▒░"
      ;;
      arrows)
        echo "$reset_color%F{cyan}"
      ;;
    esac
    return
  fi
  ref=$(git name-rev --name-only HEAD | sed 's!remotes/!!;s!undefined!merging!' 2> /dev/null)
  dirty="" && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && dirty=$I_DIRTY
  stat=$(git status | sed -n 2p)
  case "$stat" in
    *ahead*) : "$I_AHEAD" ;;
    *behind*) : "$I_BEHIND" ;;
    *diverged*) : "$I_DIVERGED" ;;
		*conflicted*) : "$I_CONFLICTED" ;;
  esac
	stat="$_"
  case "$PROMPT_STYLE" in
    ninja)
      echo "$COLOR_NORMAL$ref$dirty$stat"
    ;;
    minimal)
      echo "%F{green}$ref$dirty$stat "
    ;;
    ascii)
      echo "%{$bg[magenta]%}%F{cyan}▓▒░ %F{black}${ref}${dirty}${stat} $reset_color%F{magenta}▒░"
    ;;
    arrows)
      echo "%{$bg[magenta]%}%F{cyan} %F{black}${ref}${dirty}${stat} $reset_color%F{magenta}"
    ;;
    *)
    echo "${LVL}${P_S}[${COLOR_NORMAL}"${ref}${dirty}${stat}"${LVL}]"
    ;;
  esac
}
case "$PROMPT_STYLE" in
#█▓▒░ ascii
ascii)
PROMPT='%{$bg[cyan]%} %F{black}%~ $(GIT)$reset_color
%f'
;;
#█▓▒░ arrows
arrows)
PROMPT='%{$bg[cyan]%}%F{black} %~ $(GIT)$reset_color
%f'
;;
#█▓▒░ ninja
ninja)
PROMPT='%F{white}
        ▟▙  ${LVL}%25<..<%~%<<  %F{white}$(GIT) %F{white}
▟▒${LVL}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒${LVL}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛
            ${MODE} %f'
;;
#█▓▒░ dual line
dual)
PROMPT='${LVL}┌[${COLOR_NORMAL}%~${LVL}]$(GIT)
${LVL}└${P} %f'
;;
#█▓▒░ minimal
minimal)
PROMPT='${COLOR_NORMAL}
$(GIT)${LVL}${MODE} $f'
;;
#█▓▒░ classic
*)
PROMPT='${LVL}
[${COLOR_NORMAL}%~${LVL}]$(GIT)${P} %f'
;;
esac
fi
