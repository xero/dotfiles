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
bar_position 	= "bottom"
tag_count		= 4
tag_icon 		= "◊"
tag_icon_active = "◆"
clock_format 	= " %a %m/%d %H:%M " -- http://linux.die.net/man/3/strftime
battery_id 		= "BAT1"

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
iptraf 			= terminal.." -g -e sudo iptraf-ng -i all"
burner 			= "xfburn"
webgui 			= "chromium"
webcli 			= terminal.." -e links2"
ftpgui 			= "filezilla"
torrent 		= "transmission-gtk"
calc 			= "galculator"
pdf 			= "evince"
imageviewer 	= "viewnior"
exiter 			= "cb-exit"
passmanager 	= "keepassx"
runcmd 			= "gmrun"
mp3tag 			= "puddletag"
