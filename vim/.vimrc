"           ██
"          ░░
"  ██    ██ ██ ██████████  ██████  █████
" ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
" ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"   ░░██   ░██ ███ ░██ ░██░███   ░░█████
"    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
"
"  ▓▓▓▓▓▓▓▓▓▓
" ░▓ author ▓ xero <x@xero.style>
" ░▓ code   ▓ https://code.x-e.ro/dotfiles
" ░▓ mirror ▓ https://git.io/.files
" ░▓▓▓▓▓▓▓▓▓▓
" ░░░░░░░░░░

let configs = [
\  "01-general",
\  "02-ui",
\  "03-commands",
\  "04-install-plugins",
\  "05-plugin-settings",
\]
for file in configs
  let x = expand("~/.config/nvim/".file.".vim")
  if filereadable(x)
    execute 'source' x
  endif
endfor
