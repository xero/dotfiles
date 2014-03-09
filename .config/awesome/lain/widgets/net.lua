
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local helpers      = require("lain.helpers")

local notify_fg    = require("beautiful").fg_focus
local naughty      = require("naughty")
local wibox        = require("wibox")

local io           = io
local tostring     = tostring
local string       = { format = string.format,
                       gsub   = string.gsub }

local setmetatable = setmetatable

-- Network infos
-- lain.widgets.net
local net = {
    last_t = 0,
    last_r = 0
}

function net.get_device()
    f = io.popen("ip link show | cut -d' ' -f2,9")
    ws = f:read("*all")
    f:close()
    ws = ws:match("%w+: UP")
    if ws ~= nil then
        return ws:gsub(": UP", "")
    else
        return "network off"
    end
end

local function worker(args)
    local args = args or {}
    local timeout = args.timeout or 2
    local iface = args.iface or net.get_device()
    local units = args.units or 1024 --kb
    local settings = args.settings or function() end

    net.widget = wibox.widget.textbox('')

    helpers.set_map(iface, true)

    function update()
        net_now = {}

        if iface == "" then iface = net.get_device() end

        net_now.carrier = helpers.first_line('/sys/class/net/' .. iface ..
                                           '/carrier') or "0"
        net_now.state = helpers.first_line('/sys/class/net/' .. iface ..
                                           '/operstate') or "down"
        local now_t = helpers.first_line('/sys/class/net/' .. iface ..
                                           '/statistics/tx_bytes') or 0
        local now_r = helpers.first_line('/sys/class/net/' .. iface ..
                                           '/statistics/rx_bytes') or 0

        net_now.sent = tostring((now_t - net.last_t) / timeout / units)
        net_now.sent = string.gsub(string.format('%.1f', net_now.sent), ",", ".")

        net_now.received = tostring((now_r - net.last_r) / timeout / units)
        net_now.received = string.gsub(string.format('%.1f', net_now.received), ",", ".")

        widget = net.widget
        settings()

        net.last_t = now_t
        net.last_r = now_r

        if net_now.carrier ~= "1"
        then
            if helpers.get_map(iface)
            then
                naughty.notify({
                    title    = iface,
                    text     = "no carrier",
                    timeout  = 7,
                    position = "top_left",
                    icon     = helpers.icons_dir .. "no_net.png",
                    fg       = notify_fg or "#FFFFFF"
                })
                helpers.set_map(iface, false)
            end
        else
            helpers.set_map(iface, true)
        end
    end

    helpers.newtimer(iface, timeout, update)
    return net.widget
end

return setmetatable(net, { __call = function(_, ...) return worker(...) end })
