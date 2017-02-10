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
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

#ICO_DIRTY="⚡"
#ICO_DIRTY="↯"
ICO_DIRTY="*"
#ICO_AHEAD="↑"
ICO_AHEAD="🠙"
#ICO_AHEAD="▲"
#ICO_BEHIND="↓"
ICO_BEHIND="🠛"
#ICO_BEHIND="▼"
ICO_DIVERGED="⥮"
COLOR_ROOT="%F{red}"
COLOR_USER="%F{cyan}"
COLOR_NORMAL="%F{white}"
PROMPT_STYLE="classic"


#█▓▒░ allow functions in the prompt
setopt PROMPT_SUBST
autoload -Uz colors && colors

#█▓▒░ colors for permissions
if [[ "$EUID" -ne "0" ]]
then  # if user is not root
	USER_LEVEL="${COLOR_USER}"
else # root!
	USER_LEVEL="${COLOR_ROOT}"
fi

#█▓▒░ git prompt
GIT_PROMPT() {
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
  ref=$(git name-rev --name-only HEAD | sed 's!remotes/!!' 2> /dev/null)
  dirty="" && [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && dirty=$ICO_DIRTY
  stat=$(git status | sed -n 2p)
  case "$stat" in
    *ahead*)
      stat=$ICO_AHEAD
    ;;
    *behind*)
      stat=$ICO_BEHIND
    ;;
    *diverged*)
      stat=$ICO_DIVERGED
    ;;
    *)
      stat=""
    ;;
  esac
  case "$PROMPT_STYLE" in
    ninja)
      echo "${COLOR_NORMAL}${ref}${dirty}${stat}"
    ;;
    ascii)
      echo "%{$bg[magenta]%}%F{cyan}▓▒░ %F{black}${ref}${dirty}${stat} $reset_color%F{magenta}▒░"
    ;;
    arrows)
      echo "%{$bg[magenta]%}%F{cyan} %F{black}${ref}${dirty}${stat} $reset_color%F{magenta}"
    ;;
    *)
    echo "${USER_LEVEL}─[${COLOR_NORMAL}"${ref}${dirty}${stat}"${USER_LEVEL}]"
    ;;
  esac
}
case "$PROMPT_STYLE" in
#█▓▒░ ascii
ascii)
PROMPT='%{$bg[cyan]%} %F{black}%~ $(GIT_PROMPT)$reset_color 
%f'
;;
#█▓▒░ arrows
arrows)
PROMPT='%{$bg[cyan]%}%F{black} %~ $(GIT_PROMPT)$reset_color 
%f'
;;
#█▓▒░ ninja
ninja)
PROMPT='%F{white}
        ▟▙  ${USER_LEVEL}%~   %F{white}$(GIT_PROMPT) %F{white}
▟▒${USER_LEVEL}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒${USER_LEVEL}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛  
            %f'
;;
#█▓▒░ dual line
dual)
PROMPT='${USER_LEVEL}┌[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)
${USER_LEVEL}└─ - %f'
;;
#█▓▒░ classic
*)
PROMPT='${USER_LEVEL}[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)── - %f'
;;
esac
