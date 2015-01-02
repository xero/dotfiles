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

 awesome        > awesome wm config and ghost theme
 compton        > minimal composite config for opacity
 fun            > term color, sys info, and other misc scripts
 sys            > system automation scripts
 fonts          > config for gohu and bitmap fonts
 figlet         > custom 3d font
 git            > global git config and aliases
 herbstluftwm   > herbstluft wm config and greybeard theme
 irssi			> irc monokai theme
 mc             > midnight commander ui colors
 mpd            > music player daemon setup
 ncmpcpp        > ncurses mpc++ ui/color settings
 pacman         > pacman colors and progress bar animations
 ranger			> file manager with image previews and z3bra theme
 ryu-login      > ryu ansi art for /etc/issue tty login
 ssh            > remote ssh server keep alive
 stalonetray    > stand alone tray for daemons
 sublime        > sublime text 2 with greybeard, monokai, and gohu
 themes         > mod of the cathexis dark theme for gtk/qt/xfce
 tmux           > minimal terminal multiplexer setup
 vim            > vim custom airline bar, colors, and plugins
 urxvt          > urxvt terminal colors and keyboard settings
 zsh            > zshell settings, aliases, and custom prompts
```
#managing
it's been said of every console user: _"you are your dotfiles"_.

i manage mine with [gnu stow](http://www.gnu.org/software/stow/), a free, portable, lightweight symlink farm manager. this allows me to keep a versioned directory of all my config files that are virtually linked into place via a single command. this makes sharing these files among many users (root) and computers super simple. and does not clutter your home directory with version control files.

#installing
stow is available for all gnu/linux and most other unix like distributions via your package manager.

- `sudo pacman -S stow`
- `sudo apt-get install stow`
- `brew install stow`

#how it works
by default the stow command will create symlinks for files in the parent directory of where you execute the command. so my dotfiles setup assumes this repo is located in the root of your home directory `~/dotfiles`. and all stow commands should be executed in that directory. otherwise you'll need to use the `-d` flag with the repo directory location.

to install most of my configs you execute the stow command with the folder name as the only argument. 

to install **herbstluft** theme use the command:

`stow herbstluftwm`

this will symlink files to `~/.config/herbstluftwm` and various other places.

but you can override the default behavior and symlink files to another location with the `-t` (target) argument flag. 

to install the **ryu-login** you need to execute the command:

`stow -t / ryu-login` 

this will symlink the file to `/etc/issue`.

**note:** stow can only create a symlink if a config file does not already exist. if a default file was created upon program installation you must delete it first before you can install a new one with stow. this does not apply to directories, only files.

#tl;dr
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

#previews
![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/herbstluftwm.png)
- herbstluftwm greybeard theme
- vim 
- htop
- ncmpcpp
- fun pipes script
- sys arch screenfetch

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/awesome.png)
- awesome ghost theme
- sublime greybeard theme
- ncmpcpp
- fun ghost color script
- fun screenfetch
