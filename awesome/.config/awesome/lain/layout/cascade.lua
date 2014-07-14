
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local tag = require("awful.tag")

local cascade =
{
    name     = "cascade",
    nmaster  = 0,
    offset_x = 32,
    offset_y = 8
}

function cascade.arrange(p)

    -- Cascade windows.

    -- Screen.
    local wa = p.workarea
    local cls = p.clients

    -- Opening a new window will usually force all existing windows to
    -- get resized. This wastes a lot of CPU time. So let's set a lower
    -- bound to "how_many": This wastes a little screen space but you'll
    -- get a much better user experience.
    local t = tag.selected(p.screen)
    local num_c
    if cascade.nmaster > 0
    then
        num_c = cascade.nmaster
    else
        num_c = tag.getnmaster(t)
    end

    local how_many = #cls
    if how_many < num_c
    then
        how_many = num_c
    end

    local current_offset_x = cascade.offset_x * (how_many - 1)
    local current_offset_y = cascade.offset_y * (how_many - 1)

    -- Iterate.
    for i = 1,#cls,1
    do
        local c = cls[i]
        local g = {}

        g.x = wa.x + (how_many - i) * cascade.offset_x
        g.y = wa.y + (i - 1) * cascade.offset_y
        g.width = wa.width - current_offset_x
        g.height = wa.height - current_offset_y

        c:geometry(g)
    end
end

return cascade
