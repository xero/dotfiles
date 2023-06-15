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

## table of contents
 - [introduction](#dotfiles)
 - [managing](#managing)
 - [installing](#installing)
 - [how it works](#how-it-works)
 - [tl;dr](#tldr)
 - [my shell](#my-shell)
 - [vim](#vim)
 - [license](#license)

![](https://raw.githubusercontent.com/xero/dotfiles/vps/preview.jpg)

# dotfiles
in the unix world programs are commonly configured in two different ways, via shell arguments or text based configuration files. programs with many options like text editors are configured on a per-user basis with files in your home directory `~`. in unix like operating systems any file or directory name that starts with a period or full stop character is considered hidden, and in a default view will not be displayed. thus the name dotfiles.

it's been said of every console user:
> _"you are your dotfiles"_.

since they dictate how your system will look and function. to many users (see [ricers](http://unixporn.net) and [beaners](http://nixers.net)) these files are very important, and need to be backed up and shared. people who create custom themes have the added challenge of managing multiple versions of them. i have tried many organization techniques. and just take my word for it when i say, keeping a git repo in the root of your home directory is a bad idea. i've written custom shell scripts for moving or symlinking files into place. there are even a few dotfile managers, but they all seem to have lots of dependencies. i knew there had to be a simple tool to help me.

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
by default the stow command will create symlinks for files in the parent directory of where you execute the command. so my dotfiles setup assumes this repo is located in the root of your home directory `~/dotfiles`. and all stow commands should be executed in that directory. otherwise you'll need to use the `-d` flag with the repo directory location.

to install most of my configs you execute the stow command with the folder name as the only argument.

to install my **zsh** configs use the command:

`stow zsh`
this will symlink files like `.zshrc` to `~/.config/zsh`

but you can override the default behavior and symlink files to another location with the `-t` (target) argument flag.

to install the **fun scripts** to `/usr/local/bin` execute the command:

`stow fun -t /usr/local/`

this will symlink the fun scripts like `food` to `/usr/local/bin`. notice that the location of the scripts has appended a bin folder? that's b/c stow creates or uses the exact folder structure of the repo. and the food script is located at `/fun/bin/food` in this repo.

**note:** stow can only create a symlink if a config file does not already exist. if a default file was created upon program installation you must delete it first before you can install a new one with stow. this does not apply to directories, only files.

# tl;dr
navigate to your home directory

`cd ~`

clone the repo:

`git clone http://git.x-e.ro/dotfiles.git`

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
idk why, but i chose debian 11 on aws for some reason. there's a [setup script](https://github.com/xero/dotfiles/blob/vps/setup) for a fresh vps to install all the packages, tools, & services, create my user, setup keys, etc... that i use, my way. but you the reader don't need them all to run my dots, this is for me. beware there be dragons here.

it builds [mosh-server from this pr](https://github.com/mobile-shell/mosh/pull/1104#issuecomment-710754740) for osc 52 clipboard support.

i use [xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) to create a headless xorg enviroment for the clipboard. you can then use tools like [xsel](https://linux.die.net/man/1/xsel) and [xclip](https://linux.die.net/man/1/xclip) to pipe `{in/out}` of it in the tty. i have a personal fork on clipmenu that uses [fzf](https://github.com/junegunn/fzf) and a an osc52 [yank script](https://github.com/xero/dotfiles/blob/vps/bin/.local/bin/yank) to syncromize the x and ipad clipboards. there are other osc52 plugins for neovim and tmux included in these dotfiles to bring the whole thing together.

# shell
i prefer a minimal setup, and choose to interact with my operating system via the so-called "terminal" or "command line", (read that quoting sarcastically) over a gui interface 2 times out of 3. with the web browser and video player among the noted outliers. in my opinion, using your computer should be a very personal experience. your colors, aliases, key-bindings, etc meticulously crafted to your exacting specifications. so for me, the unix shell is the most important part of my environment.

i use [zsh](http://linux.die.net/man/1/zsh) as my interactive shell. it's an extensible, bash like shell with awesome completion and correction engines. i manage multiple shell sessions with [tmux](http://linux.die.net/man/1/tmux). it's a feature packed terminal multiplexer with support for buffers, split windows, detached local and remote sessions, etc. i'm a member of the cult of [vim](http://linux.die.net/man/1/vim). sing phrases to the third reincarnation of the glorious ed! lel.

# editor
with it's tight integration to the unix shell, [vim](http://www.vim.org) has been my editor of choice. once you start to grok movements and operators you quickly begin manipulating, not just editing text files. and in the shell, everything is just text ;D these days i'm a full time [neovim](https://neovim.io) user. it's just better than normal vim at this point imho.

with [my asliases](https://github.com/xero/dotfiles/blob/vps/zsh/.config/zsh/06-aliases.zsh#L21) `e` is `$EDITOR` and `se` is `sudo $EDITOR` so `se /etc/hosts` is `sudo nvim /etc/hosts`

# license

![kopimi logo](https://gist.githubusercontent.com/xero/cbcd5c38b695004c848b73e5c1c0c779/raw/6b32899b0af238b17383d7a878a69a076139e72d/kopimi-sm.png)

all files and scripts in this repo are released [CC0](https://creativecommons.org/publicdomain/zero/1.0/) / [kopimi](https://kopimi.com)! in the spirit of _freedom of information_, i encourage you to fork, modify, change, share, or do whatever you like with this project! `^c^v`
