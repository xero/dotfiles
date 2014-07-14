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
	export EDITOR='vi'
else
	export EDITOR='vim'
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
alias invert="xcalib -i -a"
alias mixer="alsamixer"
alias xdefaults="xrdb -merge ~/.Xdefaults"
alias sublime="subl"
alias tempwatch="while :; do sensors|while read x; do printf '% .23s\n' "$x"; done; sleep 1 && clear; done;"
alias term='urxvtc -hold -e ' #used for awesomewm run menu
alias fixcursor='xsetroot -cursor_name left_ptr'
alias hashcompare='bash ~/code/sys/hash-compare.sh '
alias apachereload='sudo /etc/init.d/apache2 restart'
alias checkrootkits='sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check'

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
 
#█▓▒░ load configs
for config_file (~/.zsh/*.zsh) source $config_file

#█▓▒░ history
HISTFILE=~/.zhistory
setopt APPEND_HISTORY
HISTSIZE=1200
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

#█▓▒░ keybindings
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

#█▓▒░ custom prompts

#█▓▒░dual line
PROMPT="%F{cyan}┌[%F{white}%n@%M%F{cyan}]─[%F{red}%~%F{cyan}]
%F{cyan}└─ %F{white}"

#█▓▒░ ninja
PROMPT="%F{white}        ▟▙    %F{red}%~%F $(prompt_git_info) {white}
▟▒%F{blue}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒%F{blue}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛  
            %F{white}"

#█▓▒░ minial
grey="%{^[[01;30m%}"
PROMPT='%F{cyan}[%F{white}%~%F{cyan}]$(prompt_git_info)── -%f '
