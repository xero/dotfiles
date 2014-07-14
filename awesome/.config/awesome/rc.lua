--          ██                                           
--         ░██  a  w  e  s  o  m  e    ██                
--         ░██                        ░██                
--   █████ ░██████   ██████   ██████ ██████              
--  ██░░░██░██░░░██ ██░░░░██ ██░░░░ ░░░██░               
--  ██░░░██░██  ░██░██   ░██░░█████   ░██                
-- ░██  ░██░██  ░██░██   ░██ ░░░░░██  ░██      ▄▄▄       
-- ░░██████░██  ░██░░██████  ██████   ░░██    ▀█▀██  ▄   
--  ░░░░░██░░   ░░  ░░░░░░  ░░░░░░     ░░    ▀▄██████▀   
--   █████                                      ▀█████   
--  ░░░░░   ▓▓▓▓▓▓▓▓▓▓                             ▀▀██▄ 
--         ░▓ author ▓ xero <x@xero.nu>                 ▀
--         ░▓ code   ▓ http://code.xero.nu/dotfiles      
--         ░▓ mirror ▓ http://git.io/.files              
--         ░▓▓▓▓▓▓▓▓▓▓                                   
--         ░░░░░░░░░░                                    

-- █▓▒░ libraries
gears        = require("gears")
awful        = require("awful")
awful.rules  = require("awful.rules")
require("awful.autofocus")
wibox        = require("wibox")
beautiful    = require("beautiful")
naughty      = require("naughty")
lain         = require("lain")

-- █▓▒░ error handling
if awesome.startup_errors then
	naughty.notify({ 
		preset = naughty.config.presets.critical,
		title = "#@*! startup errors!",
		text = awesome.startup_errors 
	})
end
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		if in_error then return end
		in_error = true
		naughty.notify({ 
			preset = naughty.config.presets.critical,
			title = "#@*! an error occured!",
			text = err 
		})
		in_error = false
	end)
end

-- █▓▒░ variables
home       = os.getenv("HOME")
config_dir = awful.util.getdir("config")

-- █▓▒░ user config
print(os.time().." : load config")
dofile(home.."/.config/awesome/config.lua")

-- █▓▒░ autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
	 findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x "..findme.." > /dev/null || ("..cmd..")")
end

run_once("urxvtd")
run_once("unclutter")

-- █▓▒░ theme
beautiful.init(os.getenv("HOME").."/.config/awesome/themes/ghost/theme.lua")

-- █▓▒░ layouts
local layouts = {
	-- awful layouts
	-- awful.layout.suit.floating,
	-- awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- lain layouts
	awful.layout.suit.floating,
	lain.layout.uselesstile,
	lain.layout.uselesstile.left,
	lain.layout.uselesstile.top,
	lain.layout.uselesstile.bottom,
	lain.layout.uselessfair,
	lain.layout.uselessfair.horizontal,
	lain.layout.termfair,
	lain.layout.centerfair,
	lain.layout.centerwork,
	lain.layout.uselesspiral,
	lain.layout.uselesspiral.dwindle,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}

-- █▓▒░ tag list
tags = {
	names = {},
	layout = {}
}
for i = 1, tag_count do
	tags.names[i] = tag_icon
	tags.layout[i] = layouts[1]
end
for s = 1, screen.count() do
	tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- █▓▒░ wallpaper
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end

-- █▓▒░ menu
awesomemenu = {
	{"░░▒▒▓▓███▓▓▒▒░░"},
	{"edit lua files :"},
	{"rc", editor_cmd.." "..home.."/.config/awesome/rc.lua"},
	{"config", editor_cmd.." "..home.."/.config/awesome/config.lua"},
	{"theme", editor_cmd.." "..home.."/.config/awesome/themes/ghost/theme.lua"},
	{"░░▒▒▓▓███▓▓▒▒░░"},
	{"reload", awesome.restart},
	{"exit", awesome.quit},
	{"reboot", "systemctl reboot"},
	{"showdown", "systemctl shutdown"},
}
gfx_settings = {
	{"view","bash "..home.."/code/sys/gfx-status.sh"},
	{"░░▒▒▓▓████▓▓▒▒░░"},
	{"switch to ati","bash "..home.."/code/sys/gfx-radeon.sh"},
	{"switch to intel","bash "..home.."/code/sys/gfx-intel.sh"},
	{"power off unused","bash "..home.."/code/sys/gfx-off.sh"},
	{"power on unused","bash "..home.."/code/sys/gfx-on.sh"},
}
prefs = {
	{"awesome", awesomemenu, beautiful.awesome_icon},
	{"~.xinitrc", editor_cmd.." .xinitrc"},
	{"wallpaper","nitrogen "..home.."/images/wallpaper/"},
	-- {"screensaver","xscreensaver-demo"},
	{"power manager","xfce4-power-manager-settings"},
	{"appearance","lxappearance"},
	{"resolution","arandr"},
	{"░░▒▒▓▓███▓▓▒▒░░"},
	{"graphix", gfx_settings},
}
systemmenu = {
	{"disks usage", term_exec.."ncdu"},
	{"# disks usage", rootterm.."ncdu"},
	{"cleanup","bleachbit"},
	{"# terminal", rootterm},
}
net = {
	{"chrome", webgui},
	{"iceweasel", "iceweasel"},
	{"irc", irc},
	{"filezilla", ftpgui},
}
screenshot = {
	{"screenshot", "xfce4-screenshooter"},
	{"scrot", terminal.."scrot"},
	{"scrot in 5", terminal.."scrot -d 5 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f bash "..home.."/images/ &amp; viewnior bash "..home.."/images/$f'"},
}
gfx = {
	{"gimp","gimp"},
	{"color picker","gcolor2"},
	{"░░▒▒▓▓███▓▓▒▒░░"},
	{"screenshot", screenshot},
}
media = {
	{"media player", mediaplayer},
	{"music player", musicplayer},
	{"mp3 metadata", mp3tag},
	{"cd/dvd burner", burner},
	{"volume", volumecontrol},
}
office = {
	{"sublime",guieditor},
	{"# sublime", "gksudo "..guieditor},
	{"word","abiword"},
}
accessories = {
	{"search",search},
	{"archive",archiver},
	{"sublime",guieditor},
	{"geany","geany"},
	{"terminal",terminal},
	{ "# terminal", rootterm },
	{"files", filegui},
	{"# files", "gksudo "..filegui},
	{"images",imageviewer},
	{"calculator",calc},
	{"pdf viewer",pdf},
	{"charmap","gucharmap"},
}
applications = {
	{"internet", net},
	{"graphix", gfx},
	{"entertainment", media},
	{"office", office},
	{"accessories", accessories},
	{"vbox", vbox},
}
fun_scripts = {
	{"colors", term_exec.."bash "..home.."/code/fun/colors"},
	{"colorscheme", term_exec.."bash "..home.."/code/fun/colorscheme"},
	{"dna", term_exec.."bash "..home.."/code/fun/dna"},
	{"ghosts", term_exec.."bash "..home.."/code/fun/ghosts"},
	{"hax0r", term_exec.."lua "..home.."/code/fun/2spooky.lua"},
	{"invaders", term_exec.."bash "..home.."/code/fun/invaders"},
	{"matrix", term_exec.."cmatrix"},
	{"pacman", term_exec.."bash "..home.."/code/fun/pacman"},
	{"pipes", term_exec.."bash "..home.."/code/fun/pipes"},
	{"pipesx", term_exec.."bash "..home.."/code/fun/pipesx"},
	{"rain", term_exec.."bash "..home.."/code/fun/rain"},
	{"screenfetch", term_exec.."bash "..home.."/code/fun/screenfetch"},
	{"skull", term_exec.."bash "..home.."/code/fun/skull"},
	{"slendy", term_exec.."bash "..home.."/code/fun/slendy"},
}
climenu = {
	{"blank", blanktag},
	{"$ terminal", terminal},
	{"# terminal", rootterm},
	{"file-manager", filecli},
	{"editor", editor_cmd},
	{"music player", musicplayer},
	{"web browser", webcli},
	{"cpu usage", cpucli},
	{"fun scripts", fun_scripts},
}
mymainmenu = awful.menu({ 
	items = { 
		{"awesome", awesomemenu, beautiful.awesome_icon},
		{"run", runcmd},
		{"cli apps", climenu},
		{"░░▒▒▓▓███▓▓▒▒░░"},
		{"terminal", terminal},
		{"file manager", filegui},
		{"# file manager", "gksudo "..filegui},
		{"web browser", webgui},
		{"text editor", guieditor},
		{"# text editor", "gksudo "..guieditor},
		{"music player", musicplayer},
		{"media player", mediaplayer},
		{"keepass", passmanager},
		{"░░▒▒▓▓███▓▓▒▒░░"},
		{"applications", applications},
		{"preferences", prefs},
		{"system", systemmenu},
		{"░░▒▒▓▓███▓▓▒▒░░"},
		{"exit menu", exiter}
	}, 
	width = 250
})

-- █▓▒░ wibox
markup = lain.util.markup

-- █▓▒░ textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = wibox.widget.background(awful.widget.textclock(markup("#FFFFFF",clock_format)), "#000000")

-- █▓▒░ calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10, fg = "#FFFFFF", position = "bottom_right" })

-- █▓▒░ MPD
-- mpdicon = wibox.widget.imagebox(beautiful.widget_music)
-- mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplayer) end)))
-- mpdwidget = lain.widgets.mpd({
-- 	settings = function()
-- 		mpdicon:set_image(beautiful.widget_music)
-- 		if mpd_now.state == "play" then
-- 			artist = " "..mpd_now.artist.." "
-- 			-- truncate titles if too long
-- 			title  = string.sub(mpd_now.title, 0, 55).." "
-- 		else
-- 			artist = ""
-- 			title  = ""
-- 		end

-- 		widget:set_markup(markup("#74999E", artist)..title)
-- 	end
-- })
-- mpdwidgetbg = mpdwidget

-- █▓▒░ systray
systray = wibox.widget.systray()

-- █▓▒░ memory
memicon = wibox.widget.background(wibox.widget.imagebox(beautiful.widget_mem), "#000000")
memwidget = wibox.widget.background(lain.widgets.mem({
	settings = function()
		widget:set_text(" "..math.floor((mem_now.used/mem_now.total)*100).."% ")
	end
}), "#000000")

-- █▓▒░ cpu
cpuicon = wibox.widget.background(wibox.widget.imagebox(beautiful.widget_cpu), "#313131")
cpuwidget = wibox.widget.background(lain.widgets.cpu({
	settings = function()
		widget:set_text(" "..cpu_now.usage.."% ")
	end
}), "#313131")

-- █▓▒░ temp
tempicon = wibox.widget.background(wibox.widget.imagebox(beautiful.widget_temp), "#313131")
tempwidget = wibox.widget.background(lain.widgets.temp({
	settings = function()
		widget:set_text(" "..coretemp_now.."°C ")
	end
}), "#313131")

-- █▓▒░ file system
fsicon = wibox.widget.background(wibox.widget.imagebox(beautiful.widget_hdd), "#000000")
fswidget = wibox.widget.background(lain.widgets.fs({
	settings  = function()
		widget:set_text(" "..fs_now.used.."% ")
	end
}), "#000000")
fswidgetbg = fswidget

-- █▓▒░ battery
baticon = wibox.widget.imagebox(beautiful.widget_battery)
batwidget = lain.widgets.bat({
	battery = battery_id,
	settings = function()
		widget:set_markup(" "..bat_now.perc.."% ")
		if bat_now.perc == "N/A" or bat_now.perc == "100" then
			baticon:set_image(beautiful.widget_ac)
			return
		elseif tonumber(bat_now.perc) <= 5 then
			baticon:set_image(beautiful.widget_battery_empty)
		elseif tonumber(bat_now.perc) <= 15 then
			baticon:set_image(beautiful.widget_battery_low)
		else
			baticon:set_image(beautiful.widget_battery)
		end
	end
})

-- █▓▒░ network
neticon = wibox.widget.background(wibox.widget.imagebox(beautiful.widget_net), "#313131")
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(iptraf) end)))
netwidget = wibox.widget.background(lain.widgets.net({
	settings = function()
		widget:set_markup(markup("#ffffff", " "..net_now.received)..
						  markup("#ffffff", " / "..net_now.sent.." "))
	end
}), "#313131")

-- █▓▒░ separators
space = wibox.widget.textbox('  ')
black = wibox.widget.imagebox(beautiful.widget_black)
hash1 = wibox.widget.imagebox(beautiful.widget_hash1)
hash2 = wibox.widget.imagebox(beautiful.widget_hash2)
hash3 = wibox.widget.imagebox(beautiful.widget_hash3)
grey = wibox.widget.imagebox(beautiful.widget_grey)

-- █▓▒░ create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
					awful.button({ }, 1, awful.tag.viewonly),
					awful.button({ modkey }, 1, awful.client.movetotag),
					awful.button({ }, 3, awful.tag.viewtoggle),
					awful.button({ modkey }, 3, awful.client.toggletag),
					awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
					awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
					)
for s = 1, screen.count() do

	-- create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()

	-- we need one layoutbox per screen.
	mylayoutbox[s] = wibox.widget.background(awful.widget.layoutbox(s), "#313131")
	mylayoutbox[s]:buttons(awful.util.table.join(
							awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
							awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
							awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
							awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

	-- create a taglist widget
	mytaglist[s] = wibox.widget.background(awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons), beautiful.tag_bg_normal)

	-- create the wibox
	mywibox[s] = awful.wibox({ position = bar_position, screen = s, height = 18 })

	-- widgets that are aligned to the upper left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(hash3)
	left_layout:add(hash3)
	left_layout:add(black)
	left_layout:add(mytaglist[s])
	left_layout:add(black)
	left_layout:add(hash1)
	left_layout:add(hash1)
	left_layout:add(grey)
	left_layout:add(mylayoutbox[s])
	left_layout:add(grey)
	left_layout:add(hash2)
	left_layout:add(hash2)
	left_layout:add(mypromptbox[s])
	left_layout:add(space)

	-- widgets that are aligned to the upper right
	local right_layout = wibox.layout.fixed.horizontal()
	if s == 1 then 
		right_layout:add(hash2)
		right_layout:add(hash2)
		right_layout:add(grey)
		right_layout:add(systray) 
		right_layout:add(grey)
	end
	right_layout:add(hash1)
	right_layout:add(hash1)
	right_layout:add(black)
	right_layout:add(mytextclock)
	right_layout:add(black)
	right_layout:add(hash3)
	right_layout:add(hash3)

	local middle_layout = wibox.layout.fixed.horizontal()
	middle_layout:add(hash2)
	middle_layout:add(hash2)
	middle_layout:add(grey)
	middle_layout:add(cpuicon)
	middle_layout:add(cpuwidget)
	middle_layout:add(grey)
	middle_layout:add(hash1)
	middle_layout:add(hash1)
	middle_layout:add(black)
	middle_layout:add(memicon)
	middle_layout:add(memwidget)
	middle_layout:add(black)
	middle_layout:add(hash1)
	middle_layout:add(hash1)
	middle_layout:add(grey)
	middle_layout:add(tempicon)
	middle_layout:add(tempwidget)
	middle_layout:add(grey)
	middle_layout:add(hash1)
	middle_layout:add(hash1)
	middle_layout:add(space)
	middle_layout:add(baticon)
	middle_layout:add(batwidget)
	middle_layout:add(space)
	middle_layout:add(hash3)
	middle_layout:add(hash3)
	middle_layout:add(black)
	middle_layout:add(fsicon)
	middle_layout:add(fswidgetbg)
	middle_layout:add(black)
	middle_layout:add(hash1)
	middle_layout:add(hash1)
	middle_layout:add(grey)
	middle_layout:add(neticon)
	middle_layout:add(netwidget)
	middle_layout:add(grey)
	middle_layout:add(hash2)
	middle_layout:add(hash2)
	-- middle_layout:add(mpdicon)
	-- middle_layout:add(mpdwidgetbg)

	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(middle_layout)
	layout:set_right(right_layout)
	mywibox[s]:set_widget(layout)

end

-- █▓▒░ mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end)
))

-- █▓▒░ global key bindings
globalkeys = awful.util.table.join(
	-- sreenshot
	awful.key({ modkey }, "Print", 
		function () 
			awful.util.spawn("scrot -d 5 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f ~/images/ & viewnior ~/images/$f'") 
		end),
	awful.key({ }, "Print", 
		function () 
			awful.util.spawn("scrot -d 5 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f ~/images/ & viewnior ~/images/$f'") 
		end),
	
	-- touchpad toggle
	awful.key({ modkey,           }, "m",      
		function () 
			awful.util.spawn('bash /home/xero/code/sys/toggle-touchpad.sh') 
		end),

	-- tag browsing
	awful.key({ modkey }, "Left",   
			awful.tag.viewprev       
		),
	awful.key({ modkey }, "Right",  
			awful.tag.viewnext       
		),
	awful.key({ modkey }, "Escape", 
			awful.tag.history.restore
		),

	-- client focus
	awful.key({ modkey }, "k",
		function ()
			awful.client.focus.byidx( 1)
			if client.focus then client.focus:raise() end
		end),
	awful.key({ modkey }, "j",
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end),

	-- client reorder
	awful.key({ modkey, "Shift"   }, "j", 
		function () 
			awful.client.swap.byidx(  1)    
		end),
	awful.key({ modkey, "Shift"   }, "k", 
		function () 
			awful.client.swap.byidx( -1)    
		end),

	-- resize tags/clients
	awful.key({ modkey }, "l",     
		function () 
			awful.tag.incmwfact( 0.05)    
		end),
	awful.key({ modkey }, "h",     
		function () 
			awful.tag.incmwfact(-0.05)    
		end),
	awful.key({ modkey, "Shift" }, "l", 
		function () 
			awful.client.incwfact(-0.05) 
		end),
	awful.key({ modkey, "Shift" }, "h", 
		function () 
			awful.client.incwfact( 0.05) 
		end),

	-- move tags/clients
	awful.key({ modkey, "Control" }, "Next",  
		function () 
			awful.client.moveresize( 20,  20, -40, -40) 
		end),
	awful.key({ modkey, "Control" }, "Prior", 
		function () 
			awful.client.moveresize(-20, -20,  40,  40) 
		end),
	awful.key({ modkey, "Control" }, "Down",  
		function () 
			awful.client.moveresize(  0,  20,   0,   0) 
		end),
	awful.key({ modkey, "Control" }, "Up",    
		function () 
			awful.client.moveresize(  0, -20,   0,   0) 
		end),
	awful.key({ modkey, "Control" }, "Left",  
		function () 
			awful.client.moveresize(-20,   0,   0,   0) 
		end),
	awful.key({ modkey, "Control" }, "Right", 
		function () 
			awful.client.moveresize( 20,   0,   0,   0) 
		end),

	-- show menu
	awful.key({ modkey }, "w",
		function ()
			mymainmenu:show({ keygrabber = true })
		end),

	-- show/hide wibox
	awful.key({ modkey }, "b", function ()
		mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
	end),

	-- switch mouse screen
	awful.key({ modkey, "Control" }, "j", 
		function () 
			awful.screen.focus_relative( 1) 
		end),
	awful.key({ modkey, "Control" }, "k", 
		function () 
			awful.screen.focus_relative(-1) 
		end),


	-- Layout manipulation
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
	awful.key({ modkey,           }, "space",  
		function () 
			awful.layout.inc(layouts,  1)  
		end),
	awful.key({ modkey, "Shift"   }, "space",  
		function () 
			awful.layout.inc(layouts, -1)  
		end),
	awful.key({ modkey, "Control" }, "n",      awful.client.restore),

	-- change useless gap
	awful.key({ modkey, "Control" }, "=", function () lain.util.useless_gaps_resize(1) end),
	awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(- 1) end),

	-- standard program
	awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
	awful.key({ modkey, "Control" }, "r",      awesome.restart),
	awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

	-- widgets popups
	awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
	awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),

	-- MPD control
	-- awful.key({ altkey, "Control" }, "Up",
	-- 	function ()
	-- 		awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle")
	-- 		mpdwidget.update()
	-- 	end),
	-- awful.key({ altkey, "Control" }, "Down",
	-- 	function ()
	-- 		awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop")
	-- 		mpdwidget.update()
	-- 	end),
	-- awful.key({ altkey, "Control" }, "Left",
	-- 	function ()
	-- 		awful.util.spawn_with_shell("mpc prev || ncmpcpp prev || ncmpc prev || pms prev")
	-- 		mpdwidget.update()
	-- 	end),
	-- awful.key({ altkey, "Control" }, "Right",
	-- 	function ()
	-- 		awful.util.spawn_with_shell("mpc next || ncmpcpp next || ncmpc next || pms next")
	-- 		mpdwidget.update()
	-- 	end),

	-- clipboard
	awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),

	-- prompt
	awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
	awful.key({ modkey }, "x",
			  function ()
				  awful.prompt.run({ prompt = "Run Lua code: " },
				  mypromptbox[mouse.screen].widget,
				  awful.util.eval, nil,
				  awful.util.getdir("cache").."/history_eval")
			  end)
	-- help cheatsheet
	-- awful.key(
	-- 	{ altkey, "Shift" }, "h",
	-- 	function ()
	-- 		naughty.notify({ 
	-- 			title   = "Command Reference: Client Keybindings"
	-- 			, text = "<span background=\"#000000\" color=\"#FFFFFF\">WIN+SPACE</span> : spawn terminal\nWIN+W     : open menu"
	-- 			, timeout = 10
	-- 			, position = "top_right"
	-- 			, fg = beautiful.fg_focus
	-- 			, bg = beautiful.bg_focus
	-- 		})
	-- 	end
	-- )        
)

-- █▓▒░ client key bindings
clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, "f", 
		function (c) 
			c.fullscreen = not c.fullscreen  
		end),
	awful.key({ modkey, "Shift"   }, "c", 
		function (c) 
			c:kill()
		end),
	awful.key({ modkey, "Control" }, "space", 
			awful.client.floating.toggle
		),
	awful.key({ modkey, "Control" }, "Return", 
		function (c) 
			c:swap(awful.client.getmaster()) 
		end),
	awful.key({ modkey,           }, "o", 
			awful.client.movetoscreen 
		),
	awful.key({ modkey,           }, "t", 
		function (c) 
			c.ontop = not c.ontop            
		end),
	awful.key({ modkey,           }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end),
	awful.key({ modkey, "Shift"   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
		end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#"..i + 9,
				  function ()
						local screen = mouse.screen
						local tag = awful.tag.gettags(screen)[i]
						if tag then
						   awful.tag.viewonly(tag)
						end
				  end),
		awful.key({ modkey, "Control" }, "#"..i + 9,
				  function ()
					  local screen = mouse.screen
					  local tag = awful.tag.gettags(screen)[i]
					  if tag then
						 awful.tag.viewtoggle(tag)
					  end
				  end),
		awful.key({ modkey, "Shift" }, "#"..i + 9,
				  function ()
					  local tag = awful.tag.gettags(client.focus.screen)[i]
					  if client.focus and tag then
						  awful.client.movetotag(tag)
					 end
				  end),
		awful.key({ modkey, "Control", "Shift" }, "#"..i + 9,
				  function ()
					  local tag = awful.tag.gettags(client.focus.screen)[i]
					  if client.focus and tag then
						  awful.client.toggletag(tag)
					  end
				  end))
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, 
		function (c) 
			client.focus = c; c:raise() 
		end),
	awful.button({ modkey }, 1, 
			awful.mouse.client.move
		),
	awful.button({ modkey }, 3, 
			awful.mouse.client.resize
		)
)

-- set keys
root.keys(globalkeys)

-- █▓▒░ rules
awful.rules.rules = {
	-- catch all rules
	{ rule = { },
		properties = { 
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = true,
			keys = clientkeys,
			buttons = clientbuttons
		} },
	-- app rules
	{ rule = { class = "smplayer" },
		properties = { 
			floating = true 
		} 
	},
	{ rule = { class = "gimp" },
		properties = { 
			floating = true 
		} 
	},
	{ rule = { name = "File Operation Progress" },
		properties = { 
			floating = true 
		} 
	},
	{ rule = { name = "blank" },
		properties = { 
			opacity = 0 -- works via composite manager
		} 
	},
	{ rule = { name = "goodbye" },
		properties = { 
			floating = true 
		},
		callback = function(c)
			awful.placement.centered(c, nil)
		end
	},
	{ rule = { name = "urxvt" },
		properties = { 
			-- fix term sizing calculation glitches
			size_hints_honor = false 
		} 
	}
}
-- █▓▒░ signals
-- change tag names dynamically
dynamic_tagging = function() 
	for s = 1, screen.count() do
		-- get a list of all tags 
		local atags = awful.tag.gettags(s)
		-- set the standard icon
		for i, t in ipairs(atags) do
			t.name = tag_icon
		end

		-- get a list of all running clients
		local clist = client.get(s)
		for i, c in ipairs(clist) do
			-- get the tags on which the client is displayed
			local ctags = c:tags()
			for i, t in ipairs(ctags) do
				-- set active icon
				t.name = tag_icon_active
			end
		end
	end
end 

-- opened client
client.connect_signal("manage", function (c, startup)
	dynamic_tagging()

	if not startup and not c.size_hints.user_position
	   and not c.size_hints.program_position then
		awful.placement.no_overlap(c)
		awful.placement.no_offscreen(c)
	end
    -- sloppy focus
    if sloppy_focus then
	    c:connect_signal("mouse::enter", function(c)
	        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
	            and awful.client.focus.filter(c) then
	            client.focus = c
	        end
	    end)	
	end	
end)

-- closed client
client.connect_signal("unmanage", function (c, startup)
	dynamic_tagging()
end)

-- border rollovers
client.connect_signal("focus",
	function(c)
		if c.maximized_horizontal == true and c.maximized_vertical == true then
			c.border_width = 0
			c.border_color = beautiful.border_normal
		else
			c.border_width = beautiful.border_width
			c.border_color = beautiful.border_focus
		end
	end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- rearrange clients
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
	dynamic_tagging()
	local clients = awful.client.visible(s)
	local layout  = awful.layout.getname(awful.layout.get(s))

	if #clients > 0 then -- fine grained borders and floaters control
		for _, c in pairs(clients) do -- floaters always have borders
			if awful.client.floating.get(c) or layout == "floating" then
				c.border_width = beautiful.border_width

			-- no borders with only one visible client
			elseif #clients == 1 or layout == "max" then
				clients[1].border_width = 0
				awful.client.moveresize(0, 0, 2, 2, clients[1])
			else
				c.border_width = beautiful.border_width
			end
		end
	end
end)
end

-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end

run_once("nitrogen --restore")
