
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
                                                  
--]]

local icons_dir    = require("lain.helpers").icons_dir

local awful        = require("awful")
local beautiful    = require("beautiful")
local naughty      = require("naughty")

local io           = io
local os           = { date = os.date }
local tonumber     = tonumber

local setmetatable = setmetatable

-- Calendar notification
-- lain.widgets.calendar
local calendar = {}
local cal_notification = nil

function calendar:hide()
    if cal_notification ~= nil then
        naughty.destroy(cal_notification)
        cal_notification = nil
    end
end

function calendar:show(t_out, inc_offset)
    calendar:hide()

    local offs = inc_offset or 0
    local tims = t_out or 0
    local f, c_text
    local today = tonumber(os.date('%d'))
    local init_t = '/usr/bin/cal | sed -r -e "s/(^| )( '

    if offs == 0
    then -- current month showing, today highlighted
        if today >= 10
        then
           init_t = '/usr/bin/cal | sed -r -e "s/(^| )('
        end

        calendar.offset = 0
        calendar.notify_icon = calendar.icons .. today .. ".png"

        -- bg and fg inverted to highlight today
        f = io.popen( init_t .. today ..
                      ')($| )/\\1<b><span foreground=\\"'
                      .. calendar.bg ..
                      '\\" background=\\"'
                      .. calendar.fg ..
                      '\\">\\2<\\/span><\\/b>\\3/"' )

    else -- no current month showing, no day to highlight
       local month = tonumber(os.date('%m'))
       local year = tonumber(os.date('%Y'))

       calendar.offset = calendar.offset + offs
       month = month + calendar.offset

       if month > 12 then
           month = month % 12
           year = year + 1
           if month <= 0 then
               month = 12
           end
       elseif month < 1 then
           month = month + 12
           year = year - 1
           if month <= 0 then
               month = 1
           end
       end

       calendar.notify_icon = nil

       f = io.popen('/usr/bin/cal ' .. month .. ' ' .. year)
    end

    c_text = "<tt><span font='" .. calendar.font .. " "
             .. calendar.font_size .. "'><b>"
             .. f:read() .. "</b>\n\n"
             .. f:read() .. "\n"
             .. f:read("*all"):gsub("\n*$", "")
             .. "</span></tt>"
    f:close()

    cal_notification = naughty.notify({
        text = c_text,
        icon = calendar.notify_icon,
        position = calendar.position,
        fg = calendar.fg,
        bg = calendar.bg,
        timeout = tims
    })
end

function calendar:attach(widget, args)
    local args = args or {}
    calendar.icons     = args.icons or icons_dir .. "cal/white/"
    calendar.font      = args.font or beautiful.font:sub(beautiful.font:find(""),
                         beautiful.font:find(" "))
    calendar.font_size = tonumber(args.font_size) or 11
    calendar.fg        = args.fg or beautiful.fg_normal or "#FFFFFF"
    calendar.bg        = args.bg or beautiful.bg_normal or "#FFFFFF"
    calendar.position  = args.position or "top_right"

    calendar.offset = 0
    calendar.notify_icon = nil

    widget:connect_signal("mouse::enter", function () calendar:show() end)
    widget:connect_signal("mouse::leave", function () calendar:hide() end)
    widget:buttons(awful.util.table.join( awful.button({ }, 1, function ()
                                              calendar:show(0, -1) end),
                                          awful.button({ }, 3, function ()
                                              calendar:show(0, 1) end) ))
end

return setmetatable(calendar, { __call = function(_, ...) return create(...) end })
