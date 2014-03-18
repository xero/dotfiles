#                 ██                    
#                ░██                    
#  ██████  ██████░██      ██████  █████ 
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░ 
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████ 
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
# █▓▒░ timestamps
# HIST_STAMPS="mm/dd/yyyy"

#█▓▒░ exports
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#█▓▒░ preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nano'
else
	export EDITOR='sublime_text'
fi

#█▓▒░ aliases
alias workscreen='xrandr --output HDMI1 --left-of LVDS1 --mode 1366x768'
alias ls='ls --color=auto'
alias lsla="ls -la --color=auto"
alias "cd.."="cd ../"
alias rock="ncmpcpp"
alias genplaylist="cd ~/music;find . -name '*.mp3' -o -name '*.flac'|sed -e 's%^./%%g' > ~/.mpd/playlists/all.m3u;mpd ~/.mpd/mpd.conf;mpc clear;mpc load all.m3u;mpc update"
alias matrix="cmatrix -b -s"
alias pipes="bash ~/code/fun/pipes"
alias pipesx="bash ~/code/fun/pipesx"
alias rain="bash ~/code/fun/rain.sh"
alias sai="sudo apt-get install"
alias screenfetch="~/code/fun/screenfetch"
alias invert="xcalib -i -a"
alias mixer="alsamixer"
alias disks="palimpsest"
alias photoshop="playonlinux --run photoshop_portable"
alias tempwatch="while :; do sensors|while read x; do printf '% .23s\n' "$x"; done; sleep 1 && clear; done;"
alias term='urxvtc -hold -e '
alias fixcursor='xsetroot -cursor_name left_ptr'
alias hashcompare='bash ~/code/sys/hash-compare.sh '
alias apachereload='sudo /etc/init.d/apache2 restart'

#█▓▒░ ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

#█▓▒░ autocompletion systems
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#█▓▒░ allow functions in the prompt
setopt PROMPT_SUBST

#█▓▒░ autoload zsh functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
 
#█▓▒░ enable auto-execution of functions
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
#█▓▒░ append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
 
#█▓▒░ custom prompts

#█▓▒░dual line
PROMPT="%F{cyan}┌[%F{white}%n@%M%F{cyan}]─[%F{red}%~%F{cyan}]
%F{cyan}└─ %F{white}"
#RPROMPT="%F{cyan}[%F{white}%n@%M%F{cyan}]"

#█▓▒░ ninja
PROMPT="%F{white}        ▟▙    %F{red}%~%F{white}
▟▒%F{blue}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒%F{blue}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛  
            %F{white}"

#█▓▒░ minial
grey="%{^[[01;30m%}"
PROMPT='%F{cyan}[%F{white}%~%F{cyan}]$(prompt_git_info)── -%f '
