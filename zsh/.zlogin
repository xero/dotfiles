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
eval `keychain -q --agents ssh,gpg --eval ~/.ssh/id_ed25519 0x0DA7AB45AC1D0000`

#█▓▒░ 1password
echo "unlock your keychain 🔐"
read -rs _pw
if [ ! -z "$_pw" ]; then
	echo "logging in"
	eval `echo "$_pw" | op signin --account x0`
	eval `echo "$_pw" | op signin --account bb`
fi
