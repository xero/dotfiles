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
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#█▓▒░ source the plugin https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#█▓▒░ color overrides
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=red'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='none'
