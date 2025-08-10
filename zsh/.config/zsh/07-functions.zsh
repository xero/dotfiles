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
#█▓▒░ shorter octal list
function l() {
		ls -gGAhF --color=always "$@" \
		| sed -e 's/--x/1/g;s/-w-/2/g;s/-wx/3/g;s/r--/4/g;s/r-x/5/g;s/rw-/6/g;s/rwx/7/g;s/---/0/g;s/rwt/7/g' \
		| sed -e 's/^\(....\) [[:digit:]] /\1 /'
}

#█▓▒░ tmux
function t() {
	X=$#
	[[ $X -eq 0 ]] || X=X
	tmux new-session -A -s "$X"
	tmux set-environment LC_ALL 'en_US.UTF-8'
	tmux set-environment LANG 'en_US.UTF-8'
}

#█▓▒░ {de,}compression
uz() {
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2)  tar xvjf "$1" ;;
      *.tar.gz)   tar xvzf "$1" ;;
      *.bz2)       bunzip2 "$1" ;;
      *.rar)       unrar x "$1" ;;
      *.gz)         gunzip "$1" ;;
      *.tar)       tar xvf "$1" ;;
      *.tbz2)     tar xvjf "$1" ;;
      *.tgz)      tar xvzf "$1" ;;
      *.zip)         unzip "$1" ;;
      *.Z)      uncompress "$1" ;;
      *.7z)           7z x "$1" ;;
      *.xz)           unxz "$1" ;;
			*)             echo "'$1' unknown compression" ;;
    esac
  else
    echo "'$1' not a valid file"
  fi
}
z() {
	if [[ -f "$1" ||  -d "$1" ]]; then
		tar zcvf "${1}_$(date '+%Y-%m-%d').tar.gz" "$1";
	else
		echo "not a valid file or dir"
	fi
}

#█▓▒░ disk info
function disks() {
	# echo
	function _e() {
		title=$(echo "$1" | sed 's/./& /g')
		echo "
\033[0;31m╓─────\033[0;35m ${title}
\033[0;31m╙────────────────────────────────────── ─ ─"
	}
	# loops
	function _l() {
		X=$(printf '\033[0m')
		G=$(printf '\033[0;32m')
		R=$(printf '\033[0;35m')
		C=$(printf '\033[0;36m')
		W=$(printf '\033[0;37m')
		i=0;
		while IFS= read -r line || [[ -n $line ]]; do
			if [[ $i == 0 ]]; then
				echo "${G}${line}${X}"
			else
				if [[ "$line" == *"%"* ]]; then
					percent=$(echo "$line" | awk '{ print $5 }' | sed 's!%!!')
					color=$W
					((percent >= 75)) && color=$C
					((percent >= 90)) && color=$R
					line=$(echo "$line" | sed "s/${percent}%/${color}${percent}%${W}/")
				fi
				echo "${W}${line}${X}" | sed "s/\([─└├┌┐└┘├┤┬┴┼]\)/${R}\1${W}/g; s! \(/.*\)! ${C}\1${W}!g;"
			fi
			i=$((i+1))
		done < <(printf '%s' "$1")
	}
	# outputs
	m=$(lsblk -a | grep -v loop)
	_e "mount.points"
	_l "$m"
	d=$(df -h)
	_e "disk.usage"
	_l "$d"
	s=$(swapon --show)
	_e "swaps"
	_l "$s"
}

#█▓▒░ silver searcher replace
function agr() {
	[[ -n "$3" ]] && l=$3 || l="."
	\ag -l "$1" "$l" | xargs sed -i "s/$1/$2/g"
}

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
	echo "unlock your keychain 󱕵"
	read -rs _pw
	if [[ -n "$_pw" ]]; then
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
	[[ -z "$(op vault user list private --account $1 2>/dev/null)" ]] && 1pwsignin || return true
}
function 1pw() {
	f="${3:-notesPlain}"
	[[ "$2" =~ "^http" ]] && i=$(1pwurl "$2") || i="$2"
	1pwcheck "$1" && op item get "$i" --account "$1" --fields "$f" --format json | jq -rM '.value'
}
function 1pwedit() {
	[[ -z "$4" ]] && { read val; } || { val=$4; }
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
	[[ ! -d .git ]] && echo "not a git repo" && return
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
	[[ ! "$1" ]] && git commit || git commit -S$1
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

#█▓▒░ nmap
function nmap() {
	if [[ -z "$*" ]]; then
		scan=$(printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s" \
			"'-sS' TCP SYN scan (best option)" \
			"'-sT' full TCP connect scan" \
			"'-sU' scan UDP ports" \
			"'-sn' ping scan" \
			"'-sP' ping scan only" \
			"'-Pn' do not ping the hosts, assume they are up" \
			"'-PE' ICMP Echo Request" \
			"'-sV' version detection scan of open ports / services" \
			"'-0'  identify Operating System version" \
			"'-A'  this combines OS detection, service version detection, script scanning and traceroute" \
			"'-sn' probe only (host discovery, not port scan)" \
				| fzf --height=50% --border --color=label:italic:#87FFAF --border-label='[ nmap scan type ]' | sed "s/' .*$//;s/'//g")
		[[ "$scan" == "" ]] && return 1
		output=$(printf "%s\n%s\n%s\n%s\n%s" \
			"raw" \
			"'-oN' normal text format" \
			"'-oG' grepable file" \
			"'-oX' XML file" \
			"'-oA' output in all 3 formats supported" \
				| fzf --height=50% --border --color=label:italic:#87FFAF --border-label='[ nmap output ]' | sed "s/' .*$//;s/'//g")
		[[ "$output" == "" ]] && return 1
		if [[ "$output" != "raw" ]]; then
			vared -p 'filename: ' -c file
		else
			output=""
		fi
		probe=$(printf "%s\n%s\n%s\n%s\n%s" \
			"'-Pn' do not probe (assume all hosts are up)" \
			"'-PB' default probe (TCP 80, 445 & ICMP)" \
			"'-PS' discrete TCP ports" \
			"'-PP' ICMP Timestamp Request" \
			"'-PM' ICMP Netmask Request" \
				| fzf --height=50% --border --color=label:italic:#87FFAF --border-label='[ nmap probing ]' | sed "s/' .*$//;s/'//g")
		[[ "$probe" == "" ]] && return 1
		if [[ "$probe" == "-PS" ]]; then
			vared -p 'ports to scan: ' -c ports
			[[ "$ports" == *" "* && ! "$ports" == *","* ]] && \
				ports=${ports// /,}
		fi
		speed=$(printf "%s\n%s\n%s\n%s\n%s\n%s" \
			"'-T0' Paranoid: Very slow, used for IDS evasion" \
			"'-T1' Sneaky: Quite slow, used for IDS evasion" \
			"'-T2' Polite: Slows down to consume less bandwidth, runs ~10 times slower than default" \
			"'-T3' Normal: Default, a dynamic timing model based on target responsiveness" \
			"'-T4' Aggressive: Assumes a fast and reliable network and may overwhelm targets" \
			"'-T5' Insane: Very aggressive; will likely overwhelm targets or miss open ports" \
				| fzf --height=50% --border --color=label:italic:#87FFAF --border-label='[ nmap speed ]' | sed "s/' .*$//;s/'//g")

		if [[ -z "$ports" ]]; then
			p=$(printf "%s\n%s\n%s\n%s" \
				"single" "range" "list" "all" \
				| fzf --height=50% --border --color=label:italic:#87FFAF --border-label='[ nmap port ]' | sed "s/' .*$//;s/'//g")
			case "$p" in
				single) m="80" ;;
				range) m="23-25" ;;
				list) m="80,443" ;;
			esac
			if [[ "$p" == "all" ]]; then
				ports=" -p-"
			else
				vared -p "ports to scan [e.g. $m]: " -c ports
				ports=" -p$ports"
			fi
		fi
		echo "nmap $speed $scan $probe $ports $output $file $targets"
	else
		nmap "$@"
	fi
}
