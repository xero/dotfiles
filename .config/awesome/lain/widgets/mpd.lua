
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
      * (c) 2010, Adrian C. <anrxc@sysphere.org>  
                                                  
--]]

local helpers      = require("lain.helpers")

local escape_f     = require("awful.util").escape
local naughty      = require("naughty")
local wibox        = require("wibox")

local io           = { popen    = io.popen }
local os           = { execute  = os.execute,
                       getenv   = os.getenv }
local string       = { format   = string.format,
                       gmatch   = string.gmatch }

local setmetatable = setmetatable

-- MPD infos
-- lain.widgets.mpd
local mpd = {}

local function worker(args)
    local args        = args or {}
    local timeout     = args.timeout or 2
    local password    = args.password or ""
    local host        = args.host or "127.0.0.1"
    local port        = args.port or "6600"
    local music_dir   = args.music_dir or os.getenv("HOME") .. "/Music"
    local cover_size  = args.cover_size or 100
    local default_art = args.default_art or ""
    local settings    = args.settings or function() end

    local mpdcover = helpers.scripts_dir .. "mpdcover"
    local mpdh = "telnet://" .. host .. ":" .. port
    local echo = "echo 'password " .. password .. "\nstatus\ncurrentsong\nclose'"

    mpd.widget = wibox.widget.textbox('')

    mpd_notification_preset = {
        -- title   = "now playing\n░░░░▒▒▒▒▓▓▓▓▓▓████████▓▓▓▓▓▓▒▒▒▒░░░░",
        title   = "now playing",
        timeout = 6
    }

    helpers.set_map("current mpd track", nil)

    function mpd.update()
        mpd_now = {
            state  = "N/A",
            file   = "N/A",
            artist = "N/A",
            title  = "N/A",
            album  = "N/A",
            date   = "N/A"
        }

        local f = io.popen(echo .. " | curl --connect-timeout 1 -fsm 3 " .. mpdh)

        for line in f:lines() do
            for k, v in string.gmatch(line, "([%w]+):[%s](.*)$") do
                if     k == "state"  then mpd_now.state  = v
                elseif k == "file"   then mpd_now.file   = v
                elseif k == "Artist" then mpd_now.artist = escape_f(v)
                elseif k == "Title"  then mpd_now.title  = escape_f(v)
                elseif k == "Album"  then mpd_now.album  = escape_f(v)
                elseif k == "Date"   then mpd_now.date   = escape_f(v)
                end
            end
        end

        f:close()

        mpd_notification_preset.text = string.format("%s (%s) - %s\n%s", mpd_now.artist,
                                       mpd_now.album, mpd_now.date, mpd_now.title)
        widget = mpd.widget
        settings()

        if mpd_now.state == "play"
        then
            if mpd_now.title ~= helpers.get_map("current mpd track")
            then
                helpers.set_map("current mpd track", mpd_now.title)

                os.execute(string.format("%s %q %q %d %q", mpdcover, music_dir,
                           mpd_now.file, cover_size, default_art))

                mpd.id = naughty.notify({
                    preset = mpd_notification_preset,
                    icon = "/tmp/mpdcover.png",
                    replaces_id = mpd.id
                }).id
            end
        elseif mpd_now.state ~= "pause"
        then
            helpers.set_map("current mpd track", nil)
	      end
    end

    helpers.newtimer("mpd", timeout, mpd.update)

    return setmetatable(mpd, { __index = mpd.widget })
end

return setmetatable(mpd, { __call = function(_, ...) return worker(...) end })
