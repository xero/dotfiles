#!/usr/bin/env bash
#
#  ██                        ██
# ░██       ██████    ██████░██      ██████  █████
# ░██████  ░░░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
# ░██░░░██  ███████ ░░█████ ░██░░░██ ░██ ░ ░██  ░░
# ░██  ░██ ██░░░░██  ░░░░░██░██  ░██ ░██   ░██   ██
# ░██████ ░░████████ ██████ ░██  ░██░███   ░░█████
# ░░░░░    ░░░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.style>
# ░▓ code   ▓ https://code.x-e.ro/dotfiles
# ░▓ mirror ▓ https://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░

# interactive
case $- in
  *i*) ;;
  *) return;;
esac
# env vars
export PATH=/usr/sbin:/usr/local/sbin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$NPM_CONFIG_PREFIX/bin:$TFENV/bin:$XDG_DATA_HOME/nvim/mason/bin:$PATH
export MANPAGER='nvim --cmd ":lua vim.g.noplugins=1" +Man!'
export MANWIDTH=999
export EDITOR=nvim
export VISUAL=nvim
# options
PS1='\n\w\n\$ '
set -o noclobber
shopt -s checkwinsize
PROMPT_DIRTRIM=2
bind Space:magic-space
shopt -s globstar 2> /dev/null
shopt -s nocaseglob;
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
shopt -s autocd 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null
CDPATH="."
# aliases
function l() {
		ls -gGAhF --color=always "$@" \
		| sed -e 's/--x/1/g;s/-w-/2/g;s/-wx/3/g;s/r--/4/g;s/r-x/5/g;s/rw-/6/g;s/rwx/7/g;s/---/0/g;s/rwt/7/g' \
		| sed 's/^\(....\) [[:digit:]] /\1 /'
}
function t() {
	X=$#
	[[ $X -eq 0 ]] || X=X
	tmux new-session -A -s $X
	tmux set-environment LC_ALL 'en_US.UTF-8'
	tmux set-environment LANG 'en_US.UTF-8'
}
alias c="clear"
alias l="ls -hF --color=auto"
alias ll="ls -lahF --color=auto"
alias e='$EDITOR'
alias se='sudo $EDITOR'
alias g="git"
alias disks='echo "╓───── m o u n t . p o i n t s";echo "╙────────────────────────────────────── ─ ─ ";lsblk -a;echo "";echo "╓───── d i s k . u s a g e";echo "╙────────────────────────────────────── ─ ─ ";df -h;'
alias 'cd..'='cd ../'
alias rmrf="rm -rf"
alias psef="ps -ef"
alias ZZ="exit"
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
alias gu="git reset @ -- "
alias gx="git reset --hard @"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias vimdiff="nvim -d -u ~/.config/nvim/init.vim"
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias aga="ag --hidden --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias curlh="curl -sILX GET"
alias curld="curl -A \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36\""
alias curlm="curl -A \"Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/28.0.1500.12 Mobile/10B329 Safari/8536.25\""
alias fuck='sudo "$BASH" -c "$(history -p !!)"'
alias xyzzy="echo nothing happens"
# completionion hail mary
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
