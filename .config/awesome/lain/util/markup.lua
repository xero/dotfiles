
--[[
                                 
     Licensed under MIT License  
      * (c) 2013, Luke Bonham    
      * (c) 2009, Uli Schlachter 
      * (c) 2009, Majic          
                                 
--]]

local beautiful    = require("beautiful")
local tostring     = tostring
local setmetatable = setmetatable

-- Lain markup util submodule
-- lain.util.markup
local markup = {}

local fg = {}
local bg = {}

-- Convenience tags.
function markup.bold(text)      return '<b>'     .. tostring(text) .. '</b>'     end
function markup.italic(text)    return '<i>'     .. tostring(text) .. '</i>'     end
function markup.strike(text)    return '<s>'     .. tostring(text) .. '</s>'     end
function markup.underline(text) return '<u>'     .. tostring(text) .. '</u>'     end
function markup.monospace(text) return '<tt>'    .. tostring(text) .. '</tt>'    end
function markup.big(text)       return '<big>'   .. tostring(text) .. '</big>'   end
function markup.small(text)     return '<small>' .. tostring(text) .. '</small>' end

-- Set the font.
function markup.font(font, text)
  return '<span font="'  .. tostring(font)  .. '">' .. tostring(text) ..'</span>'
end

-- Set the foreground.
function fg.color(color, text)
  return '<span foreground="' .. tostring(color) .. '">' .. tostring(text) .. '</span>'
end

-- Set the background.
function bg.color(color, text)
  return '<span background="' .. tostring(color) .. '">' .. tostring(text) .. '</span>'
end

-- Context: focus
function fg.focus(text) return fg.color(beautiful.fg_focus, text) end
function bg.focus(text) return bg.color(beautiful.bg_focus, text) end
function markup.focus(text) return bg.focus(fg.focus(text)) end

-- Context: normal
function fg.normal(text) return fg.color(beautiful.fg_normal, text) end
function bg.normal(text) return bg.color(beautiful.bg_normal, text) end
function markup.normal(text) return bg.normal(fg.normal(text)) end

-- Context: urgent
function fg.urgent(text) return fg.color(beautiful.fg_urgent, text) end
function bg.urgent(text) return bg.color(beautiful.bg_urgent, text) end
function markup.urgent(text) return bg.urgent(fg.urgent(text)) end

markup.fg = fg
markup.bg = bg

-- link markup.{fg,bg}(...) calls to markup.{fg,bg}.color(...)
setmetatable(markup.fg, { __call = function(_, ...) return markup.fg.color(...) end })
setmetatable(markup.bg, { __call = function(_, ...) return markup.bg.color(...) end })

-- link markup(...) calls to markup.fg.color(...)
return setmetatable(markup, { __call = function(_, ...) return markup.fg.color(...) end })
