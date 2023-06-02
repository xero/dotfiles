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
(&>/dev/null ~/.local/bin/exorg &)

#█▓▒░ ssh & gpg keychain init
eval $(keychain --dir "$XDG_RUNTIME_DIR"/keychain --absolute -q --agents ssh,gpg --eval ~/.ssh/id_ed25519 0x0DA7AB45AC1D0000)

#█▓▒░ 1password
if [ ! -z "$(op account list)" ]; then
	echo "unlock your keychain 🔐"
	read -rs _pw
	if [ ! -z "$_pw" ]; then
		printf "logging in: "
		accounts=("${(f)$(op account list | tail -n +2 | sed 's/ .*//')}")
		for acct in "${accounts[@]}" ;do
			printf "%s " "$acct"
			eval $(echo "$_pw" | op signin --account "$acct")
		done
		echo
	fi
fi
