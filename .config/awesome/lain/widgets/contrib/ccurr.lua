
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2014, Aaron Lebo                      
                                                  
--]]

local newtimer = require("lain.helpers").newtimer

local wibox    = require("wibox")
local json     = require("dkjson")

local string   = { format = string.format }
local tonumber = tonumber

-- Crypto currencies widget
-- lain.widgets.contrib.ccurr
local ccurr = {}

-- Currently gets
--   * BTC/USD
--   * DOGE/USD
-- using Coinbase and Cryptsy APIs.

-- requires   http://dkolf.de/src/dkjson-lua.fsl/home
-- based upon http://awesome.naquadah.org/wiki/Bitcoin_Price_Widget

local function get(url)
    local f = io.popen('curl -m 5 -s "' .. url .. '"')
    if not f then
        return 0
    else
        local s = f:read("*all")
        f:close()
        return s
    end
end

local function parse(j)
    local obj, pos, err = json.decode(j, 1, nil)
    if err then
        return nil
    else
        return obj
    end
end

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout  or 600
    local btc_url  = args.btc_url  or "https://coinbase.com/api/v1/prices/buy"
    local doge_url = args.doge_url or "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132"
    local settings = args.settings or function() end

    ccurr.widget = wibox.widget.textbox('')

    local function update()
        price_now = {
            btc  = "N/A",
            doge = "N/A"
        }

        btc  = parse(get(btc_url))
        doge = parse(get(doge_url))

        if btc and doge then
            price_now.btc  = tonumber(btc["subtotal"]["amount"])
            price_now.doge = tonumber(doge["return"]["markets"]["DOGE"]["lasttradeprice"])
            price_now.doge = string.format("%.4f", price_now.btc * price_now.doge)
        end

        widget = ccurr.widget
        settings()
    end

    newtimer("ccurr", timeout, update)

    return ccurr.widget
end

return setmetatable(ccurr, { __call = function(_, ...) return worker(...) end })
