#                 ██                    
#                ░██                    
#  ██████  ██████░██      ██████  █████ 
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░ 
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████ 
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░  
!
!  ▓▓▓▓▓▓▓▓▓▓
! ░▓ author ▓ xero <x@xero.nu>
! ░▓ code   ▓ http://code.xero.nu/dotfiles
! ░▓ mirror ▓ http://github.com/xero/dotfiles
! ░▓▓▓▓▓▓▓▓▓▓
! ░░░░░░░░░░
!
! █▓▒░ timestamps
# HIST_STAMPS="mm/dd/yyyy"

#█▓▒░ exports
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#█▓▒░ preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nano'
else
	export EDITOR='sublime'
fi

#█▓▒░ ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

#█▓▒░ aliases
alias workscreen='xrandr --output HDMI1 --left-of LVDS1 --mode 1366x768'
alias ls='ls --color=auto'
alias lsla="ls -la --color=auto"
alias "cd.."="cd ../"
alias rock="ncmpcpp"
alias genplaylist="cd ~/music;find . -name '*.mp3' -o -name '*.flac'|sed -e 's%^./%%g' > ~/.mpd/playlists/all.m3u;mpd ~/.mpd/mpd.conf;mpc clear;mpc load all.m3u;mpc update"
alias matrix="cmatrix -b -s"
alias pipes="bash ~/fun/pipes.sh"
alias pipesx="bash ~/fun/pipesx.sh"
alias rain="bash ~/fun/rain.sh"
alias sai="sudo apt-get install"
alias screenfetch="~/fun/screenfetch"
alias invert="xcalib -i -a"
alias mixer="alsamixer"
alias disks="palimpsest"

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
PROMPT='%F{cyan}[%F{white}%~%F{cyan}]── -%f '
