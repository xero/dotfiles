
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
                                                  
--]]

local newtimer     = require("lain.helpers").newtimer

local naughty      = require("naughty")
local wibox        = require("wibox")

local debug        = { getinfo = debug.getinfo }
local io           = io
local os           = { date    = os.date,
                       getenv  = os.getenv }
local string       = { find    = string.find,
                       match   = string.match,
                       gsub    = string.gsub,
                       sub     = string.sub }
local tonumber     = tonumber

local setmetatable = setmetatable

-- YAhoo! Weather Notification
-- lain.widgets.yawn
local yawn =
{
    icon   = wibox.widget.imagebox(),
    widget = wibox.widget.textbox('')
}

local project_path        = debug.getinfo(1, 'S').source:match[[^@(.*/).*$]]
local localizations_path  = project_path .. 'localizations/'
local icon_path           = project_path .. 'icons/'
local api_url             = 'http://weather.yahooapis.com/forecastrss'
local units_set           = '?u=c&w=' -- Default is Celsius
local language            = string.match(os.getenv("LANG"), "(%S*$*)[.]")
local weather_data        = nil
local notification        = nil
local city_id             = nil
local sky                 = nil
local settings            = function() end

yawn_notification_preset = {}

local function fetch_weather()
    local url = api_url .. units_set .. city_id
    local f = io.popen("curl --connect-timeout 1 -fsm 3 '" .. url .. "'" )
    local text = f:read("*all")
    f:close()

    -- In case of no connection or invalid city ID
    -- widgets won't display
    if text == "" or text:match("City not found")
    then
        yawn.icon:set_image(icon_path .. "na.png")
        if text == "" then
            weather_data = "Service not available at the moment."
            yawn.widget:set_text(" N/A ")
        else
            weather_data = "City not found!\n" ..
                           "Are you sure " .. city_id ..
                           " is your Yahoo city ID?"
            yawn.widget:set_text(" ? ")
        end
        return
    end

    -- Processing raw data
    weather_data = text:gsub("<.->", "")
    weather_data = weather_data:match("Current Conditions:.-Full") or ""

    -- may still happens in case of bad connectivity
    if weather_data == "" then
        yawn.icon:set_image(icon_path .. "na.png")
        yawn.widget:set_text(" ? ")
        return
    end

    weather_data = weather_data:gsub("Current Conditions:.-\n", "Now: ")
    weather_data = weather_data:gsub("Forecast:.-\n", "")
    weather_data = weather_data:gsub("\nFull", "")
    weather_data = weather_data:gsub("[\n]$", "")
    weather_data = weather_data:gsub(" [-] " , ": ")
    weather_data = weather_data:gsub("[.]", ",")
    weather_data = weather_data:gsub("High: ", "")
    weather_data = weather_data:gsub(" Low: ", " - ")

    -- Getting info for text widget
    local now      = weather_data:sub(weather_data:find("Now:")+5,
                     weather_data:find("\n")-1)
    forecast       = now:sub(1, now:find(",")-1)
    units          = now:sub(now:find(",")+2, -2)

    -- Day/Night icon change
    local hour = tonumber(os.date("%H"))
    sky = icon_path

    if forecast == "Clear"         or
       forecast == "Fair"          or
       forecast == "Partly Cloudy" or
       forecast == "Mostly Cloudy"
       then
           if hour >= 6 and hour <= 18
           then
               sky = sky .. "Day"
           else
               sky = sky .. "Night"
           end
    end

    sky = sky  .. forecast:gsub(" ", ""):gsub("/", "") .. ".png"

    -- In case there's no defined icon for current forecast
    if io.open(sky) == nil then
        sky = icon_path .. "na.png"
    end

    -- Localization
    local f = io.open(localizations_path .. language, "r")
    if language:find("en_") == nil and f ~= nil
    then
        f:close()
        for line in io.lines(localizations_path .. language)
        do
            word = string.sub(line, 1, line:find("|")-1)
            translation = string.sub(line, line:find("|")+1)
            weather_data = string.gsub(weather_data, word, translation)
        end
    end

    -- Finally setting infos
    yawn.icon:set_image(sky)
    widget = yawn.widget

    forecast = weather_data:match(": %S.-,"):gsub(": ", ""):gsub(",", "")
    units = units:gsub(" ", "")

    settings()
end

function yawn.hide()
    if notification ~= nil then
        naughty.destroy(notification)
        notification = nil
    end
end

function yawn.show(t_out)
    if yawn.widget._layout.text:match("?")
    then
        fetch_weather(settings)
    end

    yawn.hide()

    notification = naughty.notify({
        preset = yawn_notification_preset,
        text = weather_data,
        icon = sky,
        timeout = t_out
    })
end

function yawn.register(id, args)
    local args     = args or {}
    local timeout  = args.timeout or 600
    settings       = args.settings or function() end

    if args.u == "f" then units_set = '?u=f&w=' end

    city_id = id

    newtimer("yawn", timeout, fetch_weather)

    yawn.icon:connect_signal("mouse::enter", function()
        yawn.show(0)
    end)
    yawn.icon:connect_signal("mouse::leave", function()
        yawn.hide()
    end)

    return yawn
end

function yawn.attach(widget, id, args)
    yawn.register(id, args)

    widget:connect_signal("mouse::enter", function()
        yawn.show(0)
    end)

    widget:connect_signal("mouse::leave", function()
        yawn.hide()
    end)
end

return setmetatable(yawn, { __call = function(_, ...) return yawn.register(...) end })
