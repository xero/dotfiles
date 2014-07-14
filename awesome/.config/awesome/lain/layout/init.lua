
--[[
                                                   
     Lain                                          
     Layouts, widgets and utilities for Awesome WM 
                                                   
     Layouts section                               
                                                   
     Licensed under GNU General Public License v2  
      * (c) 2013,      Luke Bonham                 
      * (c) 2010-2012, Peter Hofmann               
                                                   
--]]

local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local layout       = { _NAME = "lain.layout" }

return setmetatable(layout, { __index = wrequire })
