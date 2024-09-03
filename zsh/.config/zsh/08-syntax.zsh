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
#█▓▒░ source the plugin
loc=${ZDOTDIR:-"$HOME/.config/zsh"}
L="$loc/syntaxhighlighting/zsh-syntax-highlighting.zsh"
S="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ ! -f "$S" ] && [ ! -f "$L" ]; then
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$loc/syntaxhighlighting"
	source "$L"
else
	[ -f "$S" ] && source "$S"
	[ -f "$L" ] && source "$L"
fi

#█▓▒░ color overrides
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=10'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=3'
ZSH_HIGHLIGHT_STYLES[alias]='fg=4'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=4'
ZSH_HIGHLIGHT_STYLES[function]='fg=4'
ZSH_HIGHLIGHT_STYLES[command]='fg=4'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=12'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=3'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=10'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=10'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=12'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=13'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=6'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=6'
ZSH_HIGHLIGHT_STYLES[assign]='none'
