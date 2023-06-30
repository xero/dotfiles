#                 ██
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
#
#█▓▒░ octal list
function l() {
		ls -lahF "$@" --color=always \
		| sed -e 's/--x/1/g;s/-w-/2/g;s/-wx/3/g;s/r--/4/g;s/r-x/5/g;s/rw-/6/g;s/rwx/7/g;s/---/0/g;s/^[d-]//g;'
}

#█▓▒░ tmux
function t() {
	X=$#
	[[ $X -eq 0 ]] || X=X
	tmux new-session -A -s $X
	tmux set-environment LC_ALL 'en_US.UTF-8'
	tmux set-environment LANG 'en_US.UTF-8'
}

#█▓▒░ aliases
alias c="clear"
alias ll="ls -lahF --color=always"
alias e="$EDITOR"
alias se="sudo $EDITOR"
alias ec='nvim --cmd ":lua vim.g.noplugins=1" ' #nvim --clean
alias g="git"
alias y="yank"
alias k="vpnns -- kubectl"
alias kx="kubectx"
alias k9s="vpnns -- k9s"
alias disks='echo "╓───── m o u n t . p o i n t s"; echo "╙────────────────────────────────────── ─ ─ "; lsblk -a; echo ""; echo "╓───── d i s k . u s a g e";echo "╙────────────────────────────────────── ─ ─ "; df -h;echo "╓───── s w a p s "; echo "╙────────────────────────────────────── ─ ─ "; swapon --show'

#lazy
alias "cd.."="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"
alias ZZ="exit"

#git
alias ga="git add"
alias gb="git branch"
alias gc="git clone"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcs="git commit -S -m"
alias gd="git difftool"
alias gdc="git difftool --cached"
alias gf="git fetch"
alias gg="git graph"
alias ggg="git graphgpg"
alias gm="git merge"
alias gp="git push"
alias gpr="gh pr create"
alias gr="git rebase -i"
alias gs="git status -sb"
alias gt="git tag"
alias gu="git reset @ --"
alias gx="git reset --hard @"

#overrides
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias vimdiff="nvim -d --cmd ':lua vim.g.noplugins=1'"
alias apt="sudo apt"
alias doc="sudo docker"
alias docker="sudo docker"
alias systemctl="sudo systemctl"
alias proxychains="proxychains -q"
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias aga="ag --hidden --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'

#curl
alias curlh="curl -sILX GET"
alias curld="curl -A \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36\""
alias curlm="curl -A \"Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/28.0.1500.12 Mobile/10B329 Safari/8536.25\""

#security
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias updateantivirus="sudo freshclam"

#silly
alias xyzzy="echo nothing happens"
alias fuck='sudo $(fc -ln -1)'
alias lol="base64 </dev/urandom | lolcat"
alias matrix="cmatrix -b"
alias zen="while :; do bonsai -l -b 2 -c oO0 -t 0.5; sleep 10; done"

#█▓▒░ 1password
function 1pwaccount() {
	domain="${3:-my}.1password.com"
	op account add \
		--address "$domain" \
		--email "$2" \
		--shorthand "$1"
}
function 1pwsignin() {
	# muliuser fun times
	echo "unlock your keychain 🔐"
	read -rs _pw
	if [ ! -z "$_pw" ]; then
		printf "logging in: "
		accounts=("${(f)$(op account list | tail -n +2 | cut -d' ' -f1)}")
		for acct in "${accounts[@]}" ;do
			printf "%s " "$acct"
			eval $(echo "$_pw" | op signin --account "$acct")
		done
		echo
	fi
}
function 1pwcheck() {
	[ -z "$(op vault user list private --account $1 2>/dev/null)" ] && 1pwsignin || return true
}
function 1pw() {
	f="${3:-notesPlain}"
	[[ "$2" =~ "^http" ]] && i=$(1pwurl "$2") || i="$2"
	1pwcheck "$1" && op item get "$i" --account "$1" --fields "$f" --format json | jq -rM '.value'
}
function 1pwedit() {
	[ -z "$4" ] && { read val; } || { val=$4; }
	1pwcheck "$1" && op item edit --account "$1" "$2" "${3}=${val}"
}
function 1pwfile() {
	f="${4:-notesPlain}"
	1pwcheck "$1" && op --account "$1" read "op://$2/$3/$f"
}
function 1pweditfile() {
	1pwcheck "$1" && op item edit --account "$1" "$2" "files.[file]=$3"
}
function 1pwurl() {
	echo "$1" | sed 's/^.*i=//;s/\&.*$//'
}

#█▓▒░ revive your drive
function docclean() {
	sudo docker rm $(sudo docker ps -a -q)
	sudo docker rmi $(sudo docker images -q)
}

#█▓▒░ ascii
alias ascii="toilet -t -f 3d"
alias future="toilet -t -f future"
alias rusto="toilet -t -f rusto"
alias rustofat="toilet -t -f rustofat"
alias u="node ~/.local/src/unicoder/unicoder.js "
function toiletlist() {
	TXT=$1
	[ -z "$TXT" ] && TXT="{}"
	ls ${TOILET_FONT_PATH:=/usr/share/figlet} | sed 's/\.[^.]*$//' | fzf --preview="toilet -f {} ${TXT}" --preview-window=right:80%:noborder --color preview-bg:#1c1c1c
}

#█▓▒░ ansi
function tdlist() {
	TXT=$1
	[ -z "$TXT" ] && TXT="{}"
	ls /home/x0/.config/tdfgo/fonts | sed 's/\.[^.]*$//' | fzf --preview="tdfgo print -f {} ${TXT}" --preview-window=right:80%:noborder --color preview-bg:#1c1c1c
}

#█▓▒░ read stuff like manpages
function md() {
	pandoc -s -f markdown -t man "$*" | man -l -
}
function manwww() {
	curl -skL "$*" | pandoc -s -f html -t man | man -l -
}

#█▓▒░ hack time
function gitforge() {
	[ ! -d .git ] && echo "not a git repo" && return
	gitauthor=`git config user.name`
	printf "author ($gitauthor): "
	read -r author
	author=${author:=$gitauthor}
	gitemail=`git config user.email`
	printf "email ($gitemail):"
	read -r email
	email=${email:=$gitemail}
	now=`date -Is`
	printf "date ($now):"
	read -r date
	date=${date:=$now}
	echo "\nhacking time as: $author <$email> $date\n"
	export GIT_AUTHOR_DATE=$date
	export GIT_AUTHOR_EMAIL=$email
	export GIT_AUTHOR_NAME=$author
	export GIT_COMMITTER_DATE=$date
	export GIT_COMMITTER_EMAIL=$email
	export GIT_COMMITTER_NAME=$author
	[ ! "$1" ] && git commit || git commit -S$1
	unset GIT_AUTHOR_DATE
	unset GIT_AUTHOR_EMAIL
	unset GIT_AUTHOR_NAME
	unset GIT_COMMITTER_DATE
	unset GIT_COMMITTER_EMAIL
	unset GIT_COMMITTER_NAME
}

#█▓▒░ osint
function greynoise() {
	IP="${1:-/dev/stdin}"
	[[ "$IP" =~ "stdin" ]] && read IP < "$IP"
	[[ "$IP" =~ "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ]] || IP=`dig +short ${IP}`
	curl -sX GET "https://api.greynoise.io/v3/community/${IP}" -H "Accept: application/json" -H "key: ${GREY_TOKEN}"
}

