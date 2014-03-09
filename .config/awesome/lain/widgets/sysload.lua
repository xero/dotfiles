
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local newtimer     = require("lain.helpers").newtimer

local wibox        = require("wibox")

local io           = { open = io.open }
local string       = { format = string.format,
                       match  = string.match }

local setmetatable = setmetatable

-- System load
-- lain.widgets.sysload
local sysload = {}

local function worker(args)
    local args = args or {}
    local timeout = args.timeout or 5
    local settings = args.settings or function() end

    sysload.widget = wibox.widget.textbox('')

    function update()
        local f = io.open("/proc/loadavg")
        local ret = f:read("*all")
        f:close()

        load_1, load_5, load_15 = string.match(ret, "([^%s]+) ([^%s]+) ([^%s]+)")

        widget = sysload.widget
        settings()
    end

    newtimer("sysload", timeout, update)
    return sysload.widget
end

return setmetatable(sysload, { __call = function(_, ...) return worker(...) end })
