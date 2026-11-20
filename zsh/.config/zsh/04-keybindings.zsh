# █▀▀██ ▄█▀█ ▄█ █ ▄█▀█ ▄█   ▄█
#   ▄█▀ ▓█▄▄ ▓█ █ ▓█▄  ▓█   ▓█
# ▄█▀   ▄ ██ ▓█▀█ ▓█ ▄ ▓█ ▄ ▓█ ▄
# ▓█▄▄█ ▓▄█▀ ▓█ █ ▓█▄█ ▓█▄█ ▓█▄█
#
# ░ config from xero's dotfiles
# ▒ author: xero (x@xero.style)
# ▓ https://git.io/.files
# █ https://code.x-e.ro/dotfiles

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

FZF_D=(
	"/usr/share/doc/fzf/examples"
	"/usr/local/opt/fzf/shell"
)
for D in "${FZF_D[@]}"; do
  [[ -d "$D" ]] && source "$D/key-bindings.zsh"
done
unset FZF_D D

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

# 0dwi alias
function replace-first-word() {
  zle beginning-of-line
  zle kill-word
  zle vi-insert
}
zle -N replace-first-word
bindkey -M vicmd 'r' replace-first-word

# copy the command line to every clipboard yank knows
function yank-buffer() {
	print -rn -- "$BUFFER" | yank
	zle -M "yanked"
}
zle -N yank-buffer
bindkey '^Xy' yank-buffer
bindkey -M vicmd '^Xy' yank-buffer

# share_history mixes other shells into history, so remember this shell's own last line
autoload -Uz add-zsh-hook
function _remember-last-line() { _last_line=$1 }
add-zsh-hook preexec _remember-last-line

# drop the last command and its flags but keep its paths, then park the cursor in
# front of them to type a replacement: `git add ./src/x.ts` leaves ` ./src/x.ts`
# with the cursor on the leading space
function reuse-paths() {
	setopt localoptions extendedglob
	local w p
	local -a keep words=(${(z)${_last_line:-$(fc -ln -1)}})
	while [[ $words[1] == [[:IDENT:]]##=* ]]; do shift words; done
	(( $#words )) && shift words
	for w in $words; do
		[[ $w == ('|'|'|&'|'||'|'&&'|';'|'&') ]] && break
		[[ $w == -* ]] && continue
		p=${(Q)w}
		# /dev paths only come from redirects like 2>/dev/null
		[[ $p == /dev/* ]] && continue
		# ./ ../ and ~ are typed as paths on purpose, so they count before anything exists there
		[[ $p == (./|../|'~')* ]] && { keep+=$w; continue }
		# a missing file still counts when its directory exists, so deleted and new files survive
		[[ -e $p || ( $p == */* && -d $p:h ) ]] && keep+=$w
	done
	(( $#keep )) || { zle -M "no paths in: $_last_line"; return 1 }
	RBUFFER=" ${(j: :)keep}$RBUFFER"
}
zle -N reuse-paths
bindkey '^Xp' reuse-paths
bindkey -M vicmd '^Xp' reuse-paths
