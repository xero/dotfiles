
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local newtimer        = require("lain.helpers").newtimer

local wibox           = require("wibox")

local io              = io
local os              = { getenv = os.getenv }
local pairs           = pairs
local string          = { len    = string.len,
                          match  = string.match }
local table           = { sort   = table.sort }

local setmetatable    = setmetatable

-- Maildir check
-- lain.widgets.maildir
local maildir = {}

local function worker(args)
    local args         = args or {}
    local timeout      = args.timeout or 60
    local mailpath     = args.mailpath or os.getenv("HOME") .. "/Mail"
    local ignore_boxes = args.ignore_boxes or {}
    local settings     = args.settings or function() end

    maildir.widget = wibox.widget.textbox('')

    function update()
        -- Find pathes to mailboxes.
        local p = io.popen("find " .. mailpath ..
                           " -mindepth 1 -maxdepth 1 -type d" ..
                           " -not -name .git")
        local boxes = {}
        repeat
            line = p:read("*l")
            if line ~= nil
            then
                -- Find all files in the "new" subdirectory. For each
                -- file, print a single character (no newline). Don't
                -- match files that begin with a dot.
                -- Afterwards the length of this string is the number of
                -- new mails in that box.
                local np = io.popen("find " .. line ..
                                    "/new -mindepth 1 -type f " ..
                                    "-not -name '.*' -printf a")
                local mailstring = np:read("*all")

                -- Strip off leading mailpath.
                local box = string.match(line, mailpath .. "/*([^/]+)")
                local nummails = string.len(mailstring)
                if nummails > 0
                then
                    boxes[box] = nummails
                end
            end
        until line == nil

        table.sort(boxes)

        newmail = "no mail"

        local count = 0
        for box, number in pairs(boxes)
        do
            count = count + 1
            -- Add this box only if it's not to be ignored.
            if not util.element_in_table(box, ignore_boxes)
            then
                if newmail == ""
                then
                    newmail = box .. "(" .. number .. ")"
                else
                    newmail = newmail .. ", " ..
                              box .. "(" .. number .. ")"
                end
            end
        end

        widget = maildir.widget
        settings()
    end

    newtimer(mailpath, timeout, update, true)
    return maildir.widget
end

return setmetatable(maildir, { __call = function(_, ...) return worker(...) end })
