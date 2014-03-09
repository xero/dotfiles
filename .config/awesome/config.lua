--       a  w  e  s  o  m  e     ███ ██        
--                             ░██░ ░░         
--   █████   ██████  ███████  ██████ ██  █████ 
--  ██░░░██ ██░░░░██░░██░░░██░░░██░ ░██ ██░░░██
-- ░██  ░░ ░██   ░██ ░██  ░██  ░██  ░██░██  ░██
-- ░██   ██░██   ░██ ░██  ░██  ░██  ░██░██  ░██
-- ░░█████ ░░██████  ███  ░██  ░██  ░██░░██████
--  ░░░░░   ░░░░░░  ░░░   ░░   ░░   ░░  ░░░░░██
--                                       █████ 
--                                      ░░░░░  

-- █▓▒░ interface settings
modkey 			= "Mod4"
altkey 			= "Mod1"
menu_position 	= "bottom"
tag_count		= 4
tag_icon 		= "◊"
tag_icon_active = "◆"
menu_icon 		= true
tasks_icon_only	= true
clock_format 	= " %a %m/%d %H:%M " -- http://linux.die.net/man/3/strftime
sloppy_focus 	= false -- switch to client on mouse over

-- █▓▒░ preffered apps
terminal 		= "urxvtc"
rootterm 		= "urxvtc -hold -e sudo su"
term_exec 		= "urxvtc -hold -e "
filegui 		= "thunar"
filecli 		= terminal.." -e ranger"
cpucli 			= terminal.." -e htop"
--editor = os.getenv("EDITOR") or "nano"
editor 			= os.getenv("EDITOR") or "sublime_text"
editor_cmd 		= terminal.." -e "..editor
apparence 		= "lxappearance"
archiver 		= "file-roller"
search 			= "catfish"
guieditor 		= "sublime_text"
filer 			= "thunar"
mediaplayer 	= "smplayer"
musicplayer 	= terminal.." -e ncmpcpp"
volumecontrol 	= terminal.. " -T sound -e alsamixer"
irc 			= terminal.." -T weechat -e weechat-curses"
burner 			= "xfburn"
webgui 			= "chromium"
webcli 			= terminal.." -e links2"
ftpgui 			= "filezilla"
torrent 		= "transmission-gtk"
calc 			= "galculator"
pdf 			= "evince"
imageviewer 	= "viewnior"
locker 			= "cb-lock"
exiter 			= "cb-exit"
passmanager 	= "keepassx"
runcmd 			= "gmrun"
mp3tag 			= "puddletag"
