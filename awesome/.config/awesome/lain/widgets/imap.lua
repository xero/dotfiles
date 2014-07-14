
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
                                                  
--]]

local helpers      = require("lain.helpers")

local naughty      = require("naughty")
local wibox        = require("wibox")

local io           = { popen  = io.popen }
local string       = { format = string.format,
                       gsub   = string.gsub }
local tonumber     = tonumber

local setmetatable = setmetatable

-- Mail IMAP check
-- lain.widgets.imap
local imap = {}

local function worker(args)
    local args     = args or {}

    local server   = args.server
    local mail     = args.mail
    local password = args.password

    local port     = args.port or 993
    local timeout  = args.timeout or 60
    local is_plain = args.is_plain or false
    local settings = args.settings or function() end

    local head_command  = "curl --connect-timeout 1 -fsm 3"
    local request = "-X 'SEARCH (UNSEEN)'"

    helpers.set_map(mail, 0)

    if not is_plain
    then
        local f = io.popen(password)
        password = f:read("*all"):gsub("\n", "")
        f:close()
    end

    imap.widget = wibox.widget.textbox('')

    function update()
        mail_notification_preset = {
            icon     = helpers.icons_dir .. "mail.png",
            position = "top_left"
        }

        curl = string.format("%s --url imaps://%s:%s/INBOX -u %s:%s %s -k",
               head_command, server, port, mail, password, request)

        f = io.popen(curl)
        ws = f:read("*all")
        f:close()

        _, mailcount = string.gsub(ws, "%d+", "")
        _ = nil

        widget = imap.widget
        settings()

        if mailcount > helpers.get_map(mail) and mailcount >= 1
        then
            if mailcount == 1 then
                nt = mail .. " has one new message"
            else
                nt = mail .. " has <b>" .. mailcount .. "</b> new messages"
            end
            naughty.notify({ preset = mail_notification_preset, text = nt })
        end

        helpers.set_map(mail, mailcount)
    end

    helpers.newtimer(mail, timeout, update, true)
    return imap.widget
end

return setmetatable(imap, { __call = function(_, ...) return worker(...) end })
