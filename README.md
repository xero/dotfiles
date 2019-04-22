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
 ░▓ author ▓ xero <x@xero.nu>
 ░▓ code   ▓ http://code.xero.nu/dotfiles
 ░▓ mirror ▓ http://git.io/.files
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
 - [previews](#previews)
 - [license](#license)

# dotfiles
in the unix world programs are commonly configured in two different ways, via shell arguments or text based configuration files. programs with many options like window managers or text editors are configured on a per-user basis with files in your home directory `~`. in unix like operating systems any file or directory name that starts with a period or full stop character is considered hidden, and in a default view will not be displayed. thus the name dotfiles. 

it's been said of every console user: 
> _"you are your dotfiles"_.

since they dictate how your system will look and function. to many users (see [ricers](http://unixporn.net) and [beaners](http://nixers.net)) these files are very important, and need to be backed up and shared. people who create custom themes have the added challenge of managing multiple versions of them. i have tried many organization techniques. and just take my word for it when i say, keeping a git repo in the root of your home directory is a bad idea. i've written custom shell scripts for moving or symlinking files into place. there are even a few dotfile managers, but they all seem to have lots of dependencies. i knew there had to be a simple tool to help me.

# managing
i manage mine with [gnu stow](http://www.gnu.org/software/stow/), a free, portable, lightweight symlink farm manager. this allows me to keep a versioned directory of all my config files that are virtually linked into place via a single command. this makes sharing these files among many users (root) and computers super simple. and does not clutter your home directory with version control files.

# installing
stow is available for all linux and most other unix like distributions via your package manager.

- `sudo pacman -S stow`
- `sudo apt-get install stow`
- `brew install stow`

or clone it [from source](https://savannah.gnu.org/git/?group=stow) and [build it](http://git.savannah.gnu.org/cgit/stow.git/tree/INSTALL) yourself.

# how it works
by default the stow command will create symlinks for files in the parent directory of where you execute the command. so my dotfiles setup assumes this repo is located in the root of your home directory `~/dotfiles`. and all stow commands should be executed in that directory. otherwise you'll need to use the `-d` flag with the repo directory location.

to install most of my configs you execute the stow command with the folder name as the only argument. 

to install my **herbstluft** theme _greybeard_ use the command:

`stow herbstluftwm`

this will symlink files to `~/.config/herbstluftwm` and various other places.

but you can override the default behavior and symlink files to another location with the `-t` (target) argument flag. 

to install the **ryu-login** you need to execute the command:

`stow -t / ryu-login` 

this will symlink the file to `/etc/issue`.

**note:** stow can only create a symlink if a config file does not already exist. if a default file was created upon program installation you must delete it first before you can install a new one with stow. this does not apply to directories, only files.

# tl;dr
navigate to your home directory

`cd ~`

clone the repo:

`git clone http://git.xero.nu/dotfiles.git`

enter the dotfiles directory

`cd dotfiles`

install the zsh settings

`stow zsh`

install zsh settings for the root user

`sudo stow zsh -t /root`

install awesomewm theme

`stow awesome`

uninstall awesome theme

`stow -D awesome`

install herbstluftwm

`stow herbstluftwm`

etc, etc, etc...

# shell
i prefer a minimal setup, and choose to interact with my operating system via the so-called "terminal" or "command line", (read that quoting sarcastically) over a gui interface 2 times out of 3. with the web browser and video player among the noted outliers. in my opinion, using your computer should be a very personal experience. your colors, aliases, key-bindings, etc meticulously crafted to your exacting specifications. so for me, the unix shell is the most important part of my environment.

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/xero_shell.gif)

my terminal emulator of choice is the lightweight, unicode, 256 color [urxvt](http://linux.die.net/man/1/urxvt). i use [zsh](http://linux.die.net/man/1/zsh) as my interactive shell. it's an extensible, bash like shell with awesome completion and correction engines. i manage multiple shell sessions with [tmux](http://linux.die.net/man/1/tmux). it's a feature packed terminal multiplexer with support for buffers, split windows, detached local and remote sessions, etc. i'm a member of the cult of [vim](http://linux.die.net/man/1/vim). sing phrases to the third reincarnation of the glorious ed! lel. [mpd](http://linux.die.net/man/1/mpd) is my music server and i use [ncmpcpp](http://ncmpcpp.rybczak.net/) as it's frontend. my configs for [urxvt](http://git.io/.urxvt), [zsh](http://git.io/.zsh), [tmux](http://git.io/.tmux), [vim](http://git.io/.vim), [mpd](http://git.io/.mpd) and [ncmpcpp](http://git.io/.ncmpcpp) shown above feature my [sourcerer](http://sourcerer.xero.nu) color scheme.

when it comes to fonts i've been using either the bitmap font [gohu](http://font.gohu.org/) or the ttf font [hack](https://sourcefoundry.org/hack/) (i use a [mod](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/readme.md) w/ extra icons) in conjunction with [symbola](http://users.teilar.gr/~g1951d/) for extended unicode and emoji support.

you can install all three of them from the aur: 

`yay -S gohufont ttf-nerd-fonts-hack-complete-git ttf-symbola`

see [.Xdefaults](https://github.com/xero/dotfiles/blob/master/urxvt/.Xdefaults) and [xorg.conf.d/00-fonts.conf](https://github.com/xero/dotfiles/blob/master/xorg/etc/X11/xorg.conf.d/00-fonts.conf) for my fontconfig.

# vim
with it's tight integration to the unix shell, [vim](http://www.vim.org) has quickly become my editor of choice. once you start to master the movements and operators you quickly begin manipulating, not just editing source code files.

when you learn vim it's best to use a more vanilla config. if helps you focus on learning the editor and not the plugins. vim's vast and powerful plugin system can add many great features. i try to keep my editor slim and fast, but i find myself loving these plugins:

- [plug](https://github.com/junegunn/vim-plug) - to manage other plugins
- [vim completes me](https://github.com/ajh17/VimCompletesMe) - super lightweight completion system
- [colorizer](https://github.com/lilydjwg/colorizer) - display color codes as their colors inline
- [ale](https://github.com/w0rp/ale) - async syntax linting
- [git gutter](https://github.com/airblade/vim-gitgutter) - git diff in the gutter
- [match it](https://github.com/isa/vim-matchit) - extended word and regex matching
- [lightline](https://github.com/itchyny/lightline.vim) - custom status line (for much rice)
- [fugitive](https://github.com/tpope/vim-fugitive) - fast git integration
- [GV](https://github.com/junegunn/gv.vim) - git commit browser (great for pr review)
- [vim-tmux-clipboard](https://github.com/roxma/vim-tmux-clipboard) - seamless integration between vim, tmux, and the system clipboard
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - seamless navigation between tmux panes and vim splits
- [vim-tmux-resizer](https://github.com/melonmanchan/vim-tmux-resizer) - resize tmux panes and vim splits with same keybinds

# previews
![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/nord.png)
- [details](https://github.com/xero/dotfiles/blob/master/previews/nord-setup.md)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/solid_gold.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/bbs_lyfe.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/bridge-of-leaves.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/blaquemagick.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/miasma.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/coils.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/blizzard-orb.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/work.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/sysinfo.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/neongold.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_converge.png)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-1.png)

i'm a mod on [/r/unixporn](https://reddit.com/r/unixporn/), and you can find [more of my stuff there](https://www.reddit.com/search?q=author%3Ax_ero+subreddit%3Aunixporn&restrict_sr=&sort=relevance&t=all).

# license

![kopimi logo](https://gist.githubusercontent.com/xero/cbcd5c38b695004c848b73e5c1c0c779/raw/6b32899b0af238b17383d7a878a69a076139e72d/kopimi-sm.png)

all files and scripts in this repo are released [CC0](https://creativecommons.org/publicdomain/zero/1.0/) / [kopimi](https://kopimi.com)! in the spirit of _freedom of information_, i encourage you to fork, modify, change, share, or do whatever you like with this project! `^c^v`
