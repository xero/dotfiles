
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
      * (c) 2013, Jan Xie                         
                                                  
--]]

local icons_dir    = require("lain.helpers").icons_dir

local awful        = require("awful")
local beautiful    = require("beautiful")
local naughty      = require("naughty")

local io           = io
local string       = { len = string.len }
local tonumber     = tonumber

local setmetatable = setmetatable

-- Taskwarrior notification
-- lain.widgets.task
local task = {}

local task_notification = nil

function task:hide()
    if task_notification ~= nil then
        naughty.destroy(task_notification)
        task_notification = nil
    end
end

function task:show()
    task:hide()

    local f, c_text

    f = io.popen('task')
    c_text = "<span font='"
             .. task.font .. " "
             .. task.font_size .. "'>"
             .. f:read("*all"):gsub("\n*$", "")
             .. "</span>"
    f:close()

    task_notification = naughty.notify({ title = "[task next]",
                                         text = c_text,
                                         icon = task.notify_icon,
                                         position = task.position,
                                         fg = task.fg,
                                         bg = task.bg,
                                         timeout = task.timeout })
end

function task:prompt_add()
  awful.prompt.run({ prompt = "Add task: " },
      mypromptbox[mouse.screen].widget,
      function (...)
          local f = io.popen("task add " .. ...)
          c_text = "\n<span font='" 
                   .. task.font .. " "
                   .. task.font_size .. "'>"
                   .. f:read("*all")
                   .. "</span>"
          f:close()

          naughty.notify({
              text     = c_text,
              icon     = task.notify_icon,
              position = task.position,
              fg       = task.fg,
              bg       = task.bg,
              timeout  = task.timeout
          })
      end,
      nil,
      awful.util.getdir("cache") .. "/history_task_add")
end

function task:prompt_search()
  awful.prompt.run({ prompt = "Search task: " },
      mypromptbox[mouse.screen].widget,
      function (...)
          local f = io.popen("task " .. ...)
          c_text = f:read("*all"):gsub(" \n*$", "")
          f:close()

          if string.len(c_text) == 0
          then
              c_text = "No results found."
          else
              c_text = "<span font='"
                       .. task.font .. " "
                       .. task.font_size .. "'>"
                       .. c_text 
                       .. "</span>"
          end

          naughty.notify({
              title    = "[task next " .. ... .. "]",
              text     = c_text,
              icon     = task.notify_icon,
              position = task.position,
              fg       = task.fg,
              bg       = task.bg,
              timeout  = task.timeout
          })
      end,
      nil,
      awful.util.getdir("cache") .. "/history_task")
end

function task:attach(widget, args)
    local args     = args or {}

    task.font_size = tonumber(args.font_size) or 12
    task.font      = beautiful.font:sub(beautiful.font:find(""),
                     beautiful.font:find(" "))
    task.fg        = args.fg or beautiful.fg_normal or "#FFFFFF"
    task.bg        = args.bg or beautiful.bg_normal or "#FFFFFF"
    task.position  = args.position or "top_right"
    task.timeout   = args.timeout or 7

    task.notify_icon = icons_dir .. "/taskwarrior/task.png"
    task.notify_icon_small = icons_dir .. "/taskwarrior/tasksmall.png"

    widget:connect_signal("mouse::enter", function () task:show() end)
    widget:connect_signal("mouse::leave", function () task:hide() end)
end

return setmetatable(task, { __call = function(_, ...) return create(...) end })
