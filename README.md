![evangeion](https://raw.githubusercontent.com/xero/dotfiles/main/preview.png)
```
      ██            ██     ████ ██  ██
     ░██           ░██    ░██░ ░░  ░██
     ░██  ██████  ██████ ██████ ██ ░██  █████   ██████
  ██████ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░
 ██░░░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████
░██  ░██░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██
░░██████░░██████   ░░██   ░██  ░██ ███░░██████ ██████
 ░░░░░░  ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░

  ▓▓▓▓▓▓▓▓▓▓
 ░▓ about  ▓ custom linux config files
 ░▓ author ▓ xero <x@xero.style>
 ░▓ code   ▓ http://code.x-e.ro/dotfiles
 ░▓ mirror ▓ https://git.io/.files
 ░▓▓▓▓▓▓▓▓▓▓
 ░░░░░░░░░░

```

> __NOTE:__ if you are looking for my linux wm configs like [2bwm](https://github.com/xero/dotfiles/tree/classic/2bwm), [windowchef](https://github.com/xero/dotfiles/tree/classic/windowchef), etc. they now live in the [classic](https://github.com/xero/dotfiles/tree/classic) branch and are not actively maintained since i live in the tty, xorg free, these days.

## table of contents

 - [introduction](#dotfiles)
 - [managing](#managing)
 - [installing](#installing)
 - [how it works](#how-it-works)
 - [tl;dr](#tldr)
 - [terminal emulator](#terminal-emulator)
 - [vps & local clipboard](#vps--local-clipboard)
 - [shell](#shell)
 - [clean home](#clean-home)
 - [neovim](#neovim)
 - [license](#license)

# dotfiles

in the unix world programs are commonly configured in two different ways, via shell arguments or text based configuration files. programs with many options like text editors are configured on a per-user basis with files in your home directory `~`. in unix like operating systems any file or directory name that starts with a period or full stop character is considered hidden, and in a default view will not be displayed. thus the name dotfiles.

it's been said of every console user:
> _"you are your dotfiles"_.

since they dictate how your system will look and function. to many users (see [ricers](https://reddit.com/r/unixporn/) and [beaners](https://reddit.com/r/unixart/)) these files are very important, and need to be backed up and shared. people who create custom themes have the added challenge of managing multiple versions of them. i have tried many organization techniques. and just take my word for it when i say, keeping a git repo in the root of your home directory is a bad idea. i've written custom shell scripts for moving or symlinking files into place. there are even a few [dotfile managers](https://dotfiles.github.io/utilities/), but they all seem to have lots of dependencies. i knew there had to be a simple tool to help me.

# managing

i manage mine with [gnu stow](http://www.gnu.org/software/stow/), a free, portable, lightweight symlink farm manager. this allows me to keep a versioned directory of all my config files that are virtually linked into place via a single command. this makes sharing these files among many users (root) and computers super simple. and does not clutter your home directory with version control files.

# installing

stow is available for all linux and most other unix like distributions via your package manager.

- `apt install stow`
- `brew install stow`
- `dnf install stow`
- `pacman -S stow`
- `yum install stow`

or clone it [from source](https://savannah.gnu.org/git/?group=stow) and [build it](http://git.savannah.gnu.org/cgit/stow.git/tree/INSTALL) yourself.

# how it works

by default the stow command will create symlinks for files in the parent directory of where you execute the command. since i keep my dots in: `~/.local/src/dotfiles` and all stow commands should be executed in that directory and suffixed with `-t ~` to target the home directory. otherwise they will end up in `~/.local/`. if you wanna make things easier on yourself you can clone the repo to `~/dotfiles` then run commands with no flags. but who likes things easy in the unix world ;P

to install configs execute the stow command with the folder name as the first argument, then target your home directory (or wherever you like).

to install my **zsh** configs use the command:

`stow zsh -t ~`
this will symlink files like `.zshrc` to `~/.config/zsh`

to install the **fun scripts** to `/usr/local/bin` execute the command:

`stow fun -t /usr/local/`

this will symlink the fun scripts like `food` to `/usr/local/bin`. notice that the location of the scripts has appended a bin folder? that's b/c stow creates or uses the exact folder structure of the repo. and the food script is located at `/fun/bin/food` in this repo.

**note:** stow can only create a symlink if a config file does not already exist. if a default file was created upon program installation you must delete it first before you can install a new one with stow. this does not apply to directories, only files.

more notes on using/understanding stow in [this github issue](https://github.com/xero/dotfiles/issues/14).

# my dotfiles setup

to fully "install" and setup this repo run the [setup script](https://github.com/xero/dotfiles/blob/main/setup) or something like this:
```
# clone and stow
git clone git@github.com:xero/dotfiles.git ~/.local/src/dotfiles &&
	cd ~/.local/src/dotfiles &&
	stow bin fun git gpg ssh tmux neovim zsh -t ~

# tmux
mkdir ~/.config/tmux/plugins &&
	git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm &&
	~/.config/tmux/plugins/tpm/scripts/install_plugins.sh &&
	cd ~/.config/tmux/plugins/tmux-thumbs &&
		expect -c "spawn ./tmux-thumbs-install.sh; send \"\r2\r\"; expect complete" 1>/dev/null

# nvim
mkdir ~/.local/nvim &&
  git clone --filter=blob:none --single-branch https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonUpdate" +qa

# creating ~src and ~dotfiles aliases"
sudo useradd -g src -d ~/.local/src src
sudo useradd -d ~/.local/src/dotfiles dotfiles
```

# tl;dr

navigate to your home directory

`cd ~`

clone the repo:

`git clone git@github.com:xero/dotfiles.git`

enter the dotfiles directory

`cd dotfiles`

install the zsh settings

`stow zsh`

install zsh settings for the root user

`sudo stow zsh -t /root`

uninstall zsh

`stow -D zsh`

etc, etc, etc...

# terminal emulator

recently i've been using an 11" m1 ipad pro and a bluetooth 68% mechanical keyboard, usually on my lap, as my main computer. i use the [community edition of the blink shell](https://community.blink.sh) connected to a vps.

when it comes to fonts i've been using [hack](https://sourcefoundry.org/hack/) (i use a [mod](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/readme.md) w/ extra icons for extended unicode and emoji support.) it's included in base64 encoded css form, along with color schemes, in the `blink` directory.

run blink `config` under appearance, set the screen mode set to `cover` then setup your server identity and keys. beyond that the only command i ever run in blink is `mosh x`. x being my server alias.

# vps & local clipboard

idk why, but i chose debian 11 on aws for some reason. there's a [setup script](https://github.com/xero/dotfiles/blob/main/setup) for a fresh vps to install all the packages, tools, & services, create my user, setup keys, etc... that i use, my way. but you the reader don't need them all to run my dots, this is for me. beware there be dragons here.

it builds [mosh-server from this pr](https://github.com/mobile-shell/mosh/pull/1104#issuecomment-710754740) for osc 52 clipboard support.

i use [xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) to create a headless xorg enviroment for the clipboard. you can then use tools like [xsel](https://linux.die.net/man/1/xsel) and [xclip](https://linux.die.net/man/1/xclip) to pipe `{in/out}` of it in the tty. i have a personal fork on clipmenu that uses [fzf](https://github.com/junegunn/fzf) and a an osc52 [yank script](https://github.com/xero/dotfiles/blob/main/bin/.local/bin/yank) to syncromize the x and ipad clipboards. there are other osc52 plugins for neovim and tmux included in these dotfiles to bring the whole thing together.

here's an abbreviated aws ec2 launch template for my arm64 graviton instance:
```
{
	"LaunchTemplateName": "debian11_dev_box",
	"LaunchTemplateData": {
		"ImageId": "ami-038e5cbebf3138c24",
		"InstanceType": "c6g.medium",
		"EbsOptimized": true,
		"BlockDeviceMappings": [{
			"DeviceName": "/dev/xvda",
			"Ebs": {
				"Encrypted": true,
				"Iops": 8000,
				"VolumeSize": 80,
				"VolumeType": "gp3",
				"Throughput": 125
			}
		}],
		"NetworkInterfaces": [{
			"SecuityGroups": {
				"IpPermissions": [
					{ "protocol": "tcp", "port": 0 },
					{ "protocol": "tcp", "port": 1723 },
					{ "protocol": "tcp", "port": 22 },
					{ "protocol": "tcp", "port": 443 },
					{ "protocol": "tcp", "port": 60806 },
					{ "protocol": "tcp", "port": 80 },
					{ "protocol": "udp", "port": 1701 },
					{ "protocol": "udp", "port": 4500 },
					{ "protocol": "udp", "port": 500 },
					{ "protocol": "udp", "port": 61000 }
				]
			}
		}]
	}
}
```

# shell

i prefer a minimal setup, and choose to interact with my operating system via the so-called "terminal" or "command line", (read that quoting sarcastically). with the web browser and video player among the noted outliers. in my opinion, using your computer should be a very personal experience. your colors, aliases, key-bindings, etc meticulously crafted to your exacting specifications. so for me, the unix shell is the most important part of my environment.

i use [zsh](http://linux.die.net/man/1/zsh) as my interactive shell. it's an extensible, bash like shell with awesome completion and correction engines. i manage multiple shell sessions with [tmux](http://linux.die.net/man/1/tmux). it's a feature packed terminal multiplexer with support for buffers, split windows, detached local and remote sessions, etc. i use [neovim](https://neovim.io) and a member of the [cult of vi](https://en.wikipedia.org/wiki/Editor_war). sing phrases to the third reincarnation of the glorious ed! **lel.**

# clean home

i'm all about living a *comfy* and clean digital life, so that means a tidy and organized home directory. my `~` and this repo, follow the [XDG spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).  here's a generalized breakdown:

```
.
├── .config/ $XDG_CONFIG_HOME --> app specific configs
│   ├── nvim
│   ├── tmux
│   ├── zsh       --> each app has a folder
│   │   └── zshrc --> config files
│   └── etc...
├── .local/
│   ├── bin/   $PATH            --> my scripts
│   ├── cache/ $XDG_CACHE_HOME  --> runtime files
│   ├── docs/  ~docs            --> my documents
│   ├── lib/   $pkgManger_HOME  --> app libraries
│   ├── share/ $XDG_DATA_HOME   --> shared app files
│   ├── src/
│   │   ├── dotfiles/   --> this repo
│   │   └── other_code/
│   └── state/ $XDG_STATE_HOME  --> app state files
│       └── zsh/
│           └── history --> app created files
├── .ssh/
│   ├── authorized_keys
│   ├── config
│   └── known_hosts
└── ▄█▀ █▬█ █ ▀█▀
```
to make this all work, (esp `~/.local/lib`) i have a ton of XDG directives in my [zsh environment file](https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/01-environment.zsh#L16). the one tricky bit it getting your zshrc outta home. you need to export the ZDOTDIR globally somewhere like `/etc/zsh/zshenv` or `/etc/zlogin`  that is globally sourced. other options like using systemd discussed [here](https://www.reddit.com/r/zsh/comments/3ubrdr/comment/iqd901v/). i suggest running these two commands from my [setup script](https://github.com/xero/dotfiles/blob/main/setup) to get things ready:

```
# create directory skeleton
mkdir -p ~/.local/{bin,docs,cache,lib,share,src,state} ~/.local/state/zsh

# export ZDOTDIR globally
echo 'export ZDOTDIR="$HOME"/.config/zsh' >>/etc/zsh/zshenv
```

i like to run these __before__ cloning my dotfiles and using stow, to prevent these dirs from being symlinks.

# neovim

with it's tight integration to the unix shell, [vim](http://www.vim.org) has been my editor of choice for years. once you start to grok movements and operators you quickly begin manipulating, not just editing text files. and in the shell, everything is just text ;D these days i'm a full time [neovim](https://neovim.io) user. it's just better than normal vim at this point imho. using a community built embedded language like lua5 makes way more sense than a custom/proprietary one.

with [my asliases](https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh#L35) `e` is `$EDITOR` and `se` is `sudo $EDITOR`

`e ~dotfiles/README.md` is `nvim ~/.local/src/dotfiles/README.md`

`se /etc/hosts` is `sudo nvim /etc/hosts`

you can also start neovim using `ec` or editor clean, to run `nvim --cmd ":lua vim.g.noplugins=1"`. which is kinda like `nvim --clean` with the added bonus of still loading some sane defaults. i use this as my [MANPAGER](https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/01-environment.zsh#L40) with `+MAN!` as well.

my neovim setup is written in [lua](https://neovim.io/doc/user/lua-guide.html), uses [lazy.vim](https://github.com/folke/lazy.nvim), and a bunch of plugins. you can enable/disable them selectivly from [plugins.lua](https://github.com/xero/dotfiles/blob/main/neovim/.config/nvim/lua/plugins.lua). here's the structure of configs:
```
~/.config/nvim
├── lua/
│   ├── utils/i            --> shared helper functions
│   ├── plugins/
│   │   ├── alpha.lua      --> each plugin has it's own config
│   │   ├── cmp.lua
│   │   ├── lsp/
│   │   │   ├── init.lua   --> main lsp setup logic
│   │   │   ├── remaps.lua --> lsp key-bindings
│   │   │   └── servers/
│   │   │       ├── bashls.lua --> language server specific configs
│   │   │       ├── luals.lua
│   │   │       └── etc...
│   │   ├── mason.lua
│   │   └── etc...
│   ├── ui.lua            --> ui related options
│   ├── commands.lua      --> custom commands and key-bindings
│   ├── general.lua       --> general settings
│   └── lazy-plugins.lua  --> lazy.nvim entrypoint
├── nvim-logo*            --> k-rad ansi art
├── eva-logo*             --> evangeion ansi art
└── init.lua              --> calls other files
```

as of writing this, i use ~50 [plugins](https://github.com/xero/dotfiles/tree/main/neovim/.config/nvim/lua/plugins) and an average startup time of 80-125ms. plugin highlights include:

* [lazy](https://github.com/folke/lazy.nvim) - the chillest package manager
* [lspconfig](https://github.com/neovim/nvim-lspconfig) - native language server protocol
    * [conform](https://github.com/stevearc/conform.nvim) - lsp formatting
    * [neodev](https://github.com/folke/neodev.nvim) - vscode exported completions and snips
	* [mason_lsp](https://github.com/williamboman/mason-lspconfig.nvim) - mason linter backend
	* [lsp_lines](https://git.sr.ht/~whynothugo/lsp_lines.nvim) - visualize diagnostics
    * [trouble](https://github.com/folke/trouble.nvim) - pretty diagnostics navigation pane
* [gitsigns](https://github.com/lewis6991/gitsigns.nvim) - subtle git diffs in the gutter
* [cmp](https://github.com/hrsh7th/nvim-cmp) - completion engine
* [surround](https://github.com/kylechui/nvim-surround) - motions to surround objects w/ characters
* [comments](https://github.com/terrortylor/nvim-comment) - toggle comments with motion
* [flog](https://github.com/rbong/vim-flog) - visually explore your git history
* [lualine](https://github.com/nvim-lualine/lualine.nvim) - customized status bar for the rice factor
* [tint](https://github.com/levouh/tint.nvim) - desaturate inactive panes for visual cues
* [indent_blank_line](https://github.com/lukas-reineke/indent-blankline.nvim) - eyecandy for indentation whitespace
* [telescope](https://github.com/nvim-telescope/telescope.nvim) - extensible fuzzy finder with native  floating windows
    * [telescope-undo](https://github.com/debugloop/telescope-undo.nvim) - view your undo history as a tree of diffs
    * [telescope-live-grep-args](https://github.com/nvim-telescope/telescope-live-grep-args.nvim) - ripgrep powered fuzzy search
    * [telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim) - file browser, for when you need it
* [lush](https://github.com/rktjmp/lush.nvim) - interactive colorscheme development tool
    * [evangeion](https://github.com/xero/evangeion.nvim) - my own colorscheme
* [alpha](https://github.com/goolord/alpha-nvim) - hipster splashscreen with awesome text art
* [which-key](https://github.com/folke/which-key.nvim) - help define and display key-bindings

my leader key is set to `,` and you can checkout all my custom key-bindings by calling `:WhichKey`

# previews

[miasma](https://github.com/xero/dotfiles/releases/tag/miasma)
![miasma](https://raw.githubusercontent.com/xero/dotfiles/miasma/preview.png)

more at https://lab.x-e.ro/rice/

# license

![kopimi logo](https://gist.githubusercontent.com/xero/cbcd5c38b695004c848b73e5c1c0c779/raw/6b32899b0af238b17383d7a878a69a076139e72d/kopimi-sm.png)

all files and scripts in this repo are released [CC0](https://creativecommons.org/publicdomain/zero/1.0/) / [kopimi](https://kopimi.com)! in the spirit of _freedom of information_, i encourage you to fork, modify, change, share, or do whatever you like with this project! `^c^v`
