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

#█▓▒░ clean home
export XDG_CONFIG_HOME="$HOME"/.config
export NAVE_DIR="$HOME"/.local/lib/nodejs
export CARGO_HOME="$HOME"/.local/lib/cargo
export RUSTUP_HOME="$HOME"/.local/lib/rustup
export GOPATH="$HOME"/.local/lib/go
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_STATE_HOME="$HOME"/.local/state
export ZDOTDIR="$HOME"/.config/zsh
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export GNUPGHOME="$XDG_DATA_HOME"/gpg

#█▓▒░ paths
export PATH=/usr/sbin:/usr/local/sbin:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$PATH

#█▓▒░ man
export MANPAGER="nvim +Man!"
export MANWIDTH=999

#█▓▒░ preferred text editor
export EDITOR=nvim
export VISUAL=nvim

#█▓▒░ fzf & clipboard menu
export CM_LAUNCHER="fzf"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#c1c1c1,bg:#2b2b2b,hl:#5f8787 --color=fg+:#ffffff,bg+:#1c1c1c,hl+:#3ea3a3 --color=info:#87875f,prompt:#87875f,pointer:#8787af --color=marker:#8787af,spinner:#8787af,header:#5f8787 --color=gutter:#2b2b2b,border:#222222 --padding=1 --prompt=❯ --marker=❯ --pointer=❯ --reverse'

#█▓▒░ language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

#█▓▒░ no mosh titles
export MOSH_TITLE_NOPREFIX=1

#█▓▒░ gpg cli in the tty
GPG_TTY=$(tty)
export GPG_TTY
