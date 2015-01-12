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
export PATH=$HOME/bin:/usr/local/bin:/home/xero/.gem/ruby/2.2.0/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

#█▓▒░ preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='vim'
fi

#█▓▒░ aliases
alias ls='ls --color=auto'
alias lsla="ls -la --color=auto"
alias lsls="ls -la --color=auto"
alias lsl="ls -l --color=auto"
alias "cd.."="cd ../"
alias rock="ncmpcpp"
alias mixer="alsamixer"
alias checkrootkits='sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check'
alias checkvirus='clamscan --recursive=yes --infected /home'
alias updateantivirus='sudo freshclam'
alias genplaylist="cd ~/music;find . -name '*.mp3' -o -name '*.flac'|sed -e 's%^./%%g' > ~/.config/mpd/playlists/all.m3u;mpd ~/.config/mpd/mpd.conf;mpc clear;mpc load all.m3u;mpc update"
alias matrix="cmatrix -b"
alias pipes="bash ~/code/fun/pipes"
alias pipesx="bash ~/code/fun/pipesx"
alias rain="bash ~/code/fun/rain"
alias screenfetch="~/code/sys/info"
alias hashcompare='bash ~/code/sys/hash-compare '
alias tempwatch="while :; do sensors; sleep 1 && clear; done;"
alias term='urxvtc -hold -e ' #used for awesomewm run menu
alias tmx='bash ~/code/sys/tmx'
alias fixcursor='xsetroot -cursor_name left_ptr'
alias img='bash ~/code/sys/img'
alias monokai='viewnior ~/images/monokai.png'
alias gitio='bash ~/code/sys/gitio'
alias ix='bash ~/code/sys/ix'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias clbin="curl -F 'clbin=<-' https://clbin.com"
dirlist() {
	ls -la "$1" && echo -e '' &&  tree -a "$1"
}
#█▓▒░ arch aliases
alias pacman="sudo pacman"
alias apachereload='sudo systemctl restart httpd.service'
alias disks="lsblk -a && echo '' && df -h" #ncdu
#█▓▒░ work aliases
alias dev0="ssh andrew.harrison@dev.brandingbrand.com"
alias ascii="figlet -w `tput cols` -f 3d "
alias chromeproxy='/usr/bin/env http_proxy="http://127.0.0.1:8888" /usr/bin/chromium'
alias front="node app --url http://localhost:4000 --w 0"
alias frontfake="sudo node app --url http://localhost:4000 --p 80 --w 0"
alias frontprod="NODE_ENV=production node app --url http://localhost:4000 -w 1 --p 3000"
alias frontdebug="sudo node --debug app --url http://localhost:4000 --cluster:workers 0"
alias frontend="sudo frontend"
alias frontsecure="sudo NODE_ENV=production node app --url http://localhost:4000 --p 80 -w 0"
alias gencert="openssl genrsa -out ssl-key.pem 1024 && openssl req -new -key ssl-key.pem -out certrequest.csr && openssl x509 -req -in certrequest.csr -signkey ssl-key.pem -out ssl-cert.pem"
alias inspect="node-inspector --debug-port=5858"
alias back="node app"
alias backprod="NODE_ENV=production node app -w 1 --p 4000"
alias backdebug="sudo node --debug app.js --cluster:workers 0"
alias compassfix="echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
alias npminstall="sudo rm -rf node_modules && npm cache clear && sudo PYTHON=/usr/bin/python2 npm install"

#█▓▒░ ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

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

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi


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

#█▓▒░ colors for permissions
if [[ "$EUID" -ne "0" ]] ; then  # if user is not root
	USER_LEVEL="%F{cyan}"
else # root!
	USER_LEVEL="%F{red}"
fi

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

#█▓▒░ setup node version manager
source ~/.nvm/nvm.sh

#█▓▒░ custom prompts

#█▓▒░dual line
PROMPT="${USER_LEVEL}┌[%F{white}%n@%M${USER_LEVEL}]─[%F{white}%~${USER_LEVEL}]
${USER_LEVEL}└─ %F{white}"
#RPROMPT="${USER_LEVEL}[%F{white}%n@%M${USER_LEVEL}]"

#█▓▒░ ninja
PROMPT="%F{white}        ▟▙    ${USER_LEVEL}%~%F{white}
▟▒${USER_LEVEL}░░░░░░░%F{white}▜▙▜████████████████████████████████▛
▜▒${USER_LEVEL}░░░░░░░%F{white}▟▛▟▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▛
        ▜▛  
            %F{white}"

#█▓▒░ minial
PROMPT='${USER_LEVEL}[%F{white}%~${USER_LEVEL}]$(prompt_git_info)── -%f '