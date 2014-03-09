
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local wibox        = require("awful.wibox")
local setmetatable = setmetatable

-- Creates a thin wibox at a position relative to another wibox
-- lain.widgets.borderbox
local borderbox = {}

local function worker(relbox, s, args)
    local where = args.position or 'top'
    local color = args.color or '#FFFFFF'
    local size = args.size or 1
    local box = nil
    local wiboxarg = {
        position = nil,
        bg = color
    }

    if where == 'top'
    then
        wiboxarg.width = relbox.width
        wiboxarg.height = size
        box = wibox(wiboxarg)
        box.x = relbox.x
        box.y = relbox.y - size
    elseif where == 'bottom'
    then
        wiboxarg.width = relbox.width
        wiboxarg.height = size
        box = wibox(wiboxarg)
        box.x = relbox.x
        box.y = relbox.y + relbox.height
    elseif where == 'left'
    then
        wiboxarg.width = size
        wiboxarg.height = relbox.height
        box = wibox(wiboxarg)
        box.x = relbox.x - size
        box.y = relbox.y
    elseif where == 'right'
    then
        wiboxarg.width = size
        wiboxarg.height = relbox.height
        box = wibox(wiboxarg)
        box.x = relbox.x + relbox.width
        box.y = relbox.y
    end

    box.screen = s
    return box
end

return setmetatable(borderbox, { __call = function(_, ...) return worker(...) end })
