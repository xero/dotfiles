
--[[
                                                  
     smapi.lua                                    
     Interface with thinkpad battery information  
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Conor Heine                     
                                                  
--]]

local first_line   = require("lain.helpers").first_line

local string       = { format = string.format }
local tonumber     = tonumber
local setmetatable = setmetatable

local smapi = {}

local apipath = "/sys/devices/platform/smapi"

-- Most are readable values, but some can be written to (not implemented, yet?)
local readable = {
    barcoding                  = true,
    charging_max_current       = true,
    charging_max_voltage       = true,
    chemistry                  = true,
    current_avg                = true,
    current_now                = true,
    cycle_count                = true,
    design_capacity            = true,
    design_voltage             = true,
    dump                       = true,
    first_use_date             = true,
    force_discharge            = false,
    group0_voltage             = true,
    group1_voltage             = true,
    group2_voltage             = true,
    group3_voltage             = true,
    inhibit_charge_minutes     = false,
    installed                  = true,
    last_full_capacity         = true,
    manufacture_date           = true,
    manufacturer               = true,
    model                      = true,
    power_avg                  = true,
    power_now                  = true,
    remaining_capacity         = true,
    remaining_charging_time    = true,
    remaining_percent          = true,
    remaining_percent_error    = true,
    remaining_running_time     = true,
    remaining_running_time_now = true,
    serial                     = true,
    start_charge_thresh        = false,
    state                      = true,
    stop_charge_thresh         = false,
    temperature                = true,
    voltage                    = true,
}

function smapi:battery(name)
    local bat = {}

    bat.name = name
    bat.path = apipath .. "/" .. name

    function bat:get(item)
        return self.path ~= nil and readable[item] and first_line(self.path .. "/" .. item) or nil
    end

    function bat:installed()
        return self:get("installed") == "1"
    end

    function bat:status()
        return self:get('state')
    end

    -- Remaining time can either be time until battery dies or time until charging completes
    function bat:remaining_time()
        local time_val = bat_now.status == 'discharging' and 'remaining_running_time' or 'remaining_charging_time'
        local mins_left = self:get(time_val)

        if mins_left:find("^%d+") == nil
        then
            return "N/A"
        end

        local hrs = mins_left / 60
        local min = mins_left % 60
        return string.format("%02d:%02d", hrs, min)
    end

    function bat:percent()
        return tonumber(self:get("remaining_percent"))
    end

    return setmetatable(bat, {__metatable = false, __newindex = false})
end

return smapi
