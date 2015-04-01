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
 figlet         > custom 3d font
 fonts          > config for gohu and bitmap fonts
 fun            > term color, sys info, and other misc scripts
 git            > global git config and aliases
 herbstluftwm   > herbstluft wm config and greybeard theme
 irssi          > irc monokai theme
 mc             > midnight commander ui colors
 mpd            > music player daemon setup
 ncmpcpp        > ncurses mpc++ ui/color settings
 pacman         > pacman colors and progress bar animations
 ranger         > file manager with image previews and z3bra theme
 ryu-login      > ryu ansi art for /etc/issue tty login
 ssh            > remote ssh server keep alive
 sys            > system automation scripts
 stalonetray    > stand alone tray for daemons
 sublime        > sublime text 2 with greybeard, monokai, and gohu
 themes         > mod of the cathexis dark theme for gtk/qt/xfce
 tmux           > terminal multiplexer with custom status bar
 urxvt          > sourcerer terminal colors and keyboard settings
 vim            > wizard status bar and sourcerer color scheme
 wallpaper      > the cool desktop background images i use
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
![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-1.png)
- [sysinfo](http://git.io/.sysinfo)
- [urxvt](http://git.io/.urxvt)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-2.png)
- [sublime greybeard theme](http://git.io/sublimegreybeard)
- [ncmpcpp](http://git.io/.ncmpcpp)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-3.png)
- [chroimum with cathexis gtk](http://git.io/cathexis) & [greybeard devtools](http://git.io/greybeard-devtools)
- figlet [-f 3d](http://git.io/3d) webdev | lolcat

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-4.png)
- [irssi](http://git.io/.irssi)
- [tmux](http://git.io/.tmux)

![](https://raw.githubusercontent.com/xero/dotfiles/master/previews/scrot_nightcity-5.png)
- [vim](http://git.io/.vim)
- [color scripts](http://git.io/.fun)
