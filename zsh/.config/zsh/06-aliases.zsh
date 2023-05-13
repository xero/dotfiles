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
#
#█▓▒░ aliases
alias c="clear"
alias l="ls -hF --color=auto"
alias ll="ls -lahF --color=auto"
alias e="$EDITOR"
alias se="sudo $EDITOR"
alias g="git"
alias u="node ~/src/unicoder/unicoder.js "

#lazy
alias "cd.."="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"

#git
alias ga="git add"
alias gc="git commit -m"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias gr="git rebase"
alias gp="git push"
alias gu="git unstage"
alias gg="git graph"
alias ggg="git graphgpg"
alias gco="git checkout"
alias gcs="git commit -S -m"
alias gpr="gh pr create"

#overrides
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias xsel="xsel -b"
alias vimdiff="nvim -d -u ~/.vimrc"
alias apt="sudo apt"
alias doc="sudo docker"
alias docker="sudo docker"
alias systemctl="sudo systemctl"
alias proxychains="proxychains -q"
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'

#curl
alias curlh="curl -sILX GET"
alias curld="curl -A \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36\""
alias curlm="curl -A \"Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/28.0.1500.12 Mobile/10B329 Safari/8536.25\""

#ascii
alias toiletlist='for i in ${TOILET_FONT_PATH:=/usr/share/figlet}/*.{t,f}lf; do j=${i##*/}; echo ""; echo "╓───── "$j; echo "╙────────────────────────────────────── ─ ─ "; echo ""; toilet -d "${i%/*}" -f "$j" "${j%.*}"; done'
alias tdlist='for i in ${TD_FONT_PATH:=/usr/local/share/tdfiglet/fonts}/*.tdf; do j=${i##*/}; echo ""; echo "╓───── "$j; echo "╙────────────────────────────────────── ─ ─ "; echo ""; tdfiglet -f "$j" "${j%.*}"; done'
alias ascii="toilet -t -f 3d"
alias future="toilet -t -f future"
alias rusto="toilet -t -f rusto"
alias rustofat="toilet -t -f rustofat"

#security
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias updateantivirus="sudo freshclam"

#silly
alias xyzzy="echo nothing happens"
alias up="cd ../"
alias fuck='sudo $(fc -ln -1)'
alias lol="base64 </dev/urandom | lolcat"
alias matrix="cmatrix -b"

alias k8s="kubectl"
alias ZZ="exit"
alias disks='echo "╓───── m o u n t . p o i n t s"; \
			 echo "╙────────────────────────────────────── ─ ─ "; \
			 lsblk -a; echo ""; \
			 echo "╓───── d i s k . u s a g e";\
			 echo "╙────────────────────────────────────── ─ ─ "; \
			 df -h;'
alias zen="while :; do bonsai -l -b 2 -c oO0 -t 0.5; sleep 10; done"

function docclean() {
	sudo docker rm $(sudo docker ps -a -q)
	sudo docker rmi $(sudo docker images -q)
}
#█▓▒░ tmux
function t() {
	X=$#
	[[ $X -eq 0 ]] || X=X
	tmux new-session -A -s $X
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
function greynoise() {
	IP="${1:-/dev/stdin}"
	[[ "$IP" =~ "stdin" ]] && read IP < "$IP"
	[[ "$IP" =~ "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ]] || IP=`dig +short ${IP}`
	curl -sX GET "https://api.greynoise.io/v2/noise/context/${IP}" -H "Accept: application/json" -H "key: ${GREY_TOKEN}"
}
function dnsdumpster() {
	TMP=`mktemp dnsdumpXXX`
	DNS="${1:-/dev/stdin}"
	cat << EOF > $TMP
#!env python
from dnsdumpster.DNSDumpsterAPI import DNSDumpsterAPI
domain = '$DNS'

res = DNSDumpsterAPI().search(domain)

print("\n╓───── domain: \n╙────────────────────────────────────── ─ ─")
print(res['domain'])

print("\n╓───── dns servers: \n╙────────────────────────────────────── ─ ─")
for entry in res['dns_records']['dns']:
    print(("{domain} ({ip})\n   {as} {provider} {country}".format(**entry)))

print("\n╓───── mx records: \n╙────────────────────────────────────── ─ ─")
for entry in res['dns_records']['mx']:
    print(("{domain} ({ip})\n   {as} {provider} {country}".format(**entry)))

print("\n╓───── host records: \n╙────────────────────────────────────── ─ ─")
for entry in res['dns_records']['host']:
    if entry['reverse_dns']:
        print(("{domain} ({reverse_dns}) ({ip})\n   {as} {provider} {country}".format(**entry)))
    else:
        print(("{domain} ({ip})\n   {as} {provider} {country}".format(**entry)))

print("\n╓───── txt records: \n╙────────────────────────────────────── ─ ─")
for entry in res['dns_records']['txt']:
    print(entry)
EOF
	chmod +x $TMP && python $TMP && rm $TMP
}
