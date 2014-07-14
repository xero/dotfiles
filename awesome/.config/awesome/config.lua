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
sloppy_focus 	= false

-- █▓▒░ preffered apps
terminal 		= "urxvtc"
rootterm 		= "urxvtc -hold -e sudo "
term_exec 		= "urxvtc -hold -e "
filegui 		= "thunar"
filecli 		= terminal.." -e mc"
cpucli 			= terminal.." -e htop"
editor 			= os.getenv("EDITOR") or "vim"
editor_cmd 		= terminal.." -e "..editor
apparence 		= "lxappearance"
archiver 		= "file-roller"
search 			= "catfish"
guieditor 		= "subl"
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
exiter 			= terminal.." -T goodbye -e bash /home/xero/code/sys/goodbye.sh"
passmanager 	= "keepassx"
runcmd 			= "gmrun"
mp3tag 			= "puddletag"
blanktag 		= terminal.. " -T blank"
vbox                    = "gksudo " ..term_exec.. "modprobe vboxdrv && virtualbox"
