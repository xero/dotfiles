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
#█▓▒░ fake x hax
export DISPLAY=:0
[ -x ~/.local/bin/exorg ] && (&>/dev/null ~/.local/bin/exorg &)

█▓▒░ ssh & gpg keychain init
eval "$(keychain --dir "$XDG_RUNTIME_DIR"\
	--absolute -q --agents ssh,gpg \
	--eval ~/.ssh/id_ed25519 0x0DA7AB45AC1D0000)"
