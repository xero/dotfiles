
--[[
                                                               
     tpbat.lua                                                 
     Battery status widget for ThinkPad laptops that use SMAPI 
     lain.widgets.contrib.tpbat                                
                                                               
     More on tp_smapi: http://www.thinkwiki.org/wiki/Tp_smapi  
                                                               
     Licensed under GNU General Public License v2              
      * (c) 2013,      Conor Heine                             
      * (c) 2013,      Luke Bonham                             
      * (c) 2010-2012, Peter Hofmann                           
                                                               
--]]

local debug        = { getinfo = debug.getinfo }
local newtimer     = require("lain.helpers").newtimer
local first_line   = require("lain.helpers").first_line
local beautiful    = require("beautiful")
local naughty      = require("naughty")
local wibox        = require("wibox")

local string       = { format = string.format }
local math         = { floor = math.floor }
local tostring     = tostring
local setmetatable = setmetatable

package.path       = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .. "?.lua;" .. package.path
local smapi        = require("smapi")

-- ThinkPad SMAPI-enabled battery info widget
-- lain.widgets.contrib.tpbat
local tpbat = { }
local tpbat_notification = nil

function tpbat:hide()
    if tpbat_notification ~= nil
    then
        naughty.destroy(tpbat_notification)
        tpbat_notification = nil
    end
end

function tpbat:show(t_out)
    tpbat:hide()

    local bat   = self.bat
    local t_out = t_out or 0

    if bat == nil or not bat:installed() then return end

    local mfgr   = bat:get('manufacturer') or "no_mfgr"
    local model  = bat:get('model') or "no_model"
    local chem   = bat:get('chemistry') or "no_chem"
    local status = bat:get('state') or "nil"
    local time   = bat:remaining_time()
    local msg    = "\t"

    if status ~= "idle" and status ~= "nil"
    then
        if time == "N/A"
        then
            msg = "...Calculating time remaining..."
        else
            msg = time .. (status == "charging" and " until charged" or " remaining")
        end
    else
        msg = "On AC Power"
    end

    local str = string.format("%s : %s %s (%s)\n", bat.name, mfgr, model, chem)
                .. string.format("\n%s \t\t\t %s", status:upper(), msg)

    tpbat_notification = naughty.notify({
        preset = { fg = beautiful.fg_normal },
        text = str,
        timeout = t_out
    })
end

function tpbat.register(args)
    local args = args or {}
    local timeout = args.timeout or 30
    local battery = args.battery or "BAT0"
    local settings = args.settings or function() end

    tpbat.bat = smapi:battery(battery) -- Create a new battery
    local bat = tpbat.bat

    tpbat.widget = wibox.widget.textbox('')

    bat_notification_low_preset = {
        title = "Battery low",
        text = "Plug the cable!",
        timeout = 15,
        fg = "#202020",
        bg = "#CDCDCD"
    }

    bat_notification_critical_preset = {
        title = "Battery exhausted",
        text = "Shutdown imminent",
        timeout = 15,
        fg = "#000000",
        bg = "#FFFFFF"
    }

    if bat:get('state') == nil
    then
        local n = naughty.notify({
            preset = bat_notification_low_preset,
            title = "SMAPI Battery Warning: Unable to read battery state!",
            text = "This widget is intended for ThinkPads. Is tp_smapi installed? Check your configs & paths."
        })
    end

    function update()
        bat_now = {
            status = "Not present",
            perc   = "N/A",
            time   = "N/A",
            watt   = "N/A"
        }

        if bat:installed()
        then
            bat_now.status = bat:status() or "N/A"
            bat_now.perc   = bat:percent()
            bat_now.time   = bat:remaining_time()
            -- bat_now.watt = string.format("%.2fW", (VOLTS * AMPS) / 1e12)

            -- notifications for low and critical states (when discharging)
            if bat_now.status == "discharging"
            then
                if bat_now.perc <= 5
                then
                    tpbat.id = naughty.notify({
                        preset = bat_notification_critical_preset,
                        replaces_id = tpbat.id
                    }).id
                elseif bat_now.perc <= 15
                then
                    tpbat.id = naughty.notify({
                        preset = bat_notification_low_preset,
                        replaces_id = tpbat.id
                    }).id
                end
            end

            bat_now.perc = tostring(bat_now.perc)
        end

        widget = tpbat.widget
        settings()
    end

    newtimer("tpbat", timeout, update)

    widget:connect_signal('mouse::enter', function () tpbat:show() end)
    widget:connect_signal('mouse::leave', function () tpbat:hide() end)

    return tpbat.widget
end

return setmetatable(tpbat, { __call = function(_, ...) return tpbat.register(...) end })
