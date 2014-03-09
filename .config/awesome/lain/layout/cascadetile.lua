
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local tag       = require("awful.tag")
local beautiful = require("beautiful")
local tonumber  = tonumber

local cascadetile =
{
    name          = "cascadetile",
    nmaster       = 0,
    ncol          = 0,
    mwfact        = 0,
    offset_x      = 5,
    offset_y      = 32,
    extra_padding = 0
}

function cascadetile.arrange(p)

    -- Layout with one fixed column meant for a master window. Its
    -- width is calculated according to mwfact. Other clients are
    -- cascaded or "tabbed" in a slave column on the right.

    -- It's a bit hard to demonstrate the behaviour with ASCII-images...
    --
    --       (1)              (2)              (3)              (4)
    --   +-----+---+      +-----+---+      +-----+---+      +-----+---+
    --   |     |   |      |     |   |      |     |   |      |     | 4 |
    --   |     |   |      |     | 2 |      |     | 3 |      |     |   |
    --   |  1  |   |  ->  |  1  |   |  ->  |  1  |   |  ->  |  1  +---+
    --   |     |   |      |     +---+      |     +---+      |     | 3 |
    --   |     |   |      |     |   |      |     | 2 |      |     |---|
    --   |     |   |      |     |   |      |     |---|      |     | 2 |
    --   |     |   |      |     |   |      |     |   |      |     |---|
    --   +-----+---+      +-----+---+      +-----+---+      +-----+---+

    -- A useless gap (like the dwm patch) can be defined with
    -- beautiful.useless_gap_width.
    local useless_gap = tonumber(beautiful.useless_gap_width) or 0

    -- Screen.
    local wa = p.workarea
    local cls = p.clients

    -- Width of main column?
    local t = tag.selected(p.screen)
    local mwfact
    if cascadetile.mwfact > 0
    then
        mwfact = cascadetile.mwfact
    else
        mwfact = tag.getmwfact(t)
    end

    -- Make slave windows overlap main window? Do this if ncol is 1.
    local overlap_main
    if cascadetile.ncol > 0
    then
        overlap_main = cascadetile.ncol
    else
        overlap_main = tag.getncol(t)
    end

    -- Minimum space for slave windows? See cascade.lua.
    local num_c
    if cascadetile.nmaster > 0
    then
        num_c = cascadetile.nmaster
    else
        num_c = tag.getnmaster(t)
    end

    local how_many = #cls - 1
    if how_many < num_c
    then
        how_many = num_c
    end
    local current_offset_x = cascadetile.offset_x * (how_many - 1)
    local current_offset_y = cascadetile.offset_y * (how_many - 1)

    if #cls > 0
    then
        -- Main column, fixed width and height.
        local c = cls[#cls]
        local g = {}
        local mainwid = wa.width * mwfact
        local slavewid = wa.width - mainwid

        if overlap_main == 1
        then
            g.width = wa.width

            -- The size of the main window may be reduced a little bit.
            -- This allows you to see if there are any windows below the
            -- main window.
            -- This only makes sense, though, if the main window is
            -- overlapping everything else.
            g.width = g.width - cascadetile.extra_padding
        else
            g.width = mainwid
        end

        g.height = wa.height
        g.x = wa.x
        g.y = wa.y
        if useless_gap > 0
        then
            -- Reduce width once and move window to the right. Reduce
            -- height twice, however.
            g.width = g.width - useless_gap
            g.height = g.height - 2 * useless_gap
            g.x = g.x + useless_gap
            g.y = g.y + useless_gap

            -- When there's no window to the right, add an additional
            -- gap.
            if overlap_main == 1
            then
                g.width = g.width - useless_gap
            end
        end
        c:geometry(g)

        -- Remaining clients stacked in slave column, new ones on top.
        if #cls > 1
        then
            for i = (#cls - 1),1,-1
            do
                c = cls[i]
                g = {}
                g.width = slavewid - current_offset_x
                g.height = wa.height - current_offset_y
                g.x = wa.x + mainwid + (how_many - i) * cascadetile.offset_x
                g.y = wa.y + (i - 1) * cascadetile.offset_y
                if useless_gap > 0
                then
                    g.width = g.width - 2 * useless_gap
                    g.height = g.height - 2 * useless_gap
                    g.x = g.x + useless_gap
                    g.y = g.y + useless_gap
                end
                c:geometry(g)
            end
        end
    end
end

return cascadetile
