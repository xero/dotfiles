
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local first_line   = require("lain.helpers").first_line
local newtimer     = require("lain.helpers").newtimer

local wibox        = require("wibox")

local math         = { ceil   = math.ceil }
local string       = { format = string.format,
                       gmatch = string.gmatch }
local tostring     = tostring

local setmetatable = setmetatable

-- CPU usage
-- lain.widgets.cpu
local cpu = {
    last_total = 0,
    last_active = 0
}

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    cpu.widget = wibox.widget.textbox('')

    function update()
        -- Read the amount of time the CPUs have spent performing
        -- different kinds of work. Read the first line of /proc/stat
        -- which is the sum of all CPUs.
        local times = first_line("/proc/stat")
        local at = 1
        local idle = 0
        local total = 0
        for field in string.gmatch(times, "[%s]+([^%s]+)")
        do
            -- 3 = idle, 4 = ioWait. Essentially, the CPUs have done
            -- nothing during these times.
            if at == 3 or at == 4
            then
                idle = idle + field
            end
            total = total + field
            at = at + 1
        end
        local active = total - idle

        -- Read current data and calculate relative values.
        local dactive = active - cpu.last_active
        local dtotal = total - cpu.last_total

        cpu_now = {}
        cpu_now.usage = tostring(math.ceil((dactive / dtotal) * 100))

        widget = cpu.widget
        settings()

        -- Save current data for the next run.
        cpu.last_active = active
        cpu.last_total = total
    end

    newtimer("cpu", timeout, update)

    return cpu.widget
end

return setmetatable(cpu, { __call = function(_, ...) return worker(...) end })
