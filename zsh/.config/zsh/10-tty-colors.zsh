# █▀▀██ ▄█▀█ ▄█ █ ▄█▀█ ▄█   ▄█
#   ▄█▀ ▓█▄▄ ▓█ █ ▓█▄  ▓█   ▓█
# ▄█▀   ▄ ██ ▓█▀█ ▓█ ▄ ▓█ ▄ ▓█ ▄
# ▓█▄▄█ ▓▄█▀ ▓█ █ ▓█▄█ ▓█▄█ ▓█▄█
#
# ░ config from xero's dotfiles
# ▒ author: xero (x@xero.style)
# ▓ https://git.io/.files
# █ https://code.x-e.ro/dotfiles

#█▓▒░ load colorscheme
case "$UI_THEME" in
	EVANGELION) : "evangelion-colors" ;;
	MIASMA) : "miasma-colors" ;;
	SOURCERER) : "sourcerer-colors" ;;
esac
source ~/.config/zsh/"$_"
