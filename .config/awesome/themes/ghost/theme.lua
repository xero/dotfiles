--          ██                                           
--         ░██  a  w  e  s  o  m  e    ██                
--         ░██                        ░██                
--   █████ ░██████   ██████   ██████ ██████              
--  ██░░░██░██░░░██ ██░░░░██ ██░░░░ ░░░██░               
--  ██░░░██░██  ░██░██   ░██░░█████   ░██                
-- ░██  ░██░██  ░██░██   ░██ ░░░░░██  ░██      ▄▄▄       
-- ░░██████░██  ░██░░██████  ██████   ░░██    ▀█▀██  ▄   
--  ░░░░░██░░   ░░  ░░░░░░  ░░░░░░     ░░    ▀▄██████▀   
--   █████                                      ▀█████   
--  ░░░░░   ▓▓▓▓▓▓▓▓▓▓                             ▀▀██▄ 
--         ░▓ author ▓ xero <x@xero.nu>                 ▀
--         ░▓ code   ▓ http://code.xero.nu/dotfiles      
--         ░▓ mirror ▓ http://git.io/.files              
--         ░▓▓▓▓▓▓▓▓▓▓                                   
--         ░░░░░░░░░░                                    

theme                               = {}

themes_dir                          = os.getenv("HOME") .. "/.config/awesome/themes/ghost"
theme.wallpaper                     = themes_dir .. "/hash.png"

theme.font                          = "gohuFont"
theme.fg_normal                     = "#DDDDFF"
theme.fg_focus                      = "#F0DFAF"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#1A1A1A"
theme.bg_focus                      = "#313131"
theme.bg_urgent                     = "#1A1A1A"
theme.bg_systray                    = "#2F2F2F"
theme.tag_bg_normal                 = "#000000"
theme.border_width                  = "1"
theme.border_normal                 = "#3F3F3F"
theme.border_focus                  = "#7F7F7F"
theme.border_marked                 = "#CC9393"
theme.titlebar_bg_focus             = "#FFFFFF"
theme.titlebar_bg_normal            = "#FFFFFF"
theme.textbox_widget_margin_top     = 1
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.useless_gap_width             = 10
theme.mouse_finder_color            = "#CC9393"
theme.menu_height                   = "16"
theme.menu_width                    = "150"

theme.menu_submenu_icon             = themes_dir .. "/icons/submenu.png"
theme.tasklist_disable_icon         = true -- do not display the taglist squares

theme.layout_tile                   = themes_dir .. "/layouts/tile.png"
theme.layout_tilegaps               = themes_dir .. "/layouts/tile.png"
theme.layout_tileleft               = themes_dir .. "/layouts/tileleft.png"
theme.layout_tilebottom             = themes_dir .. "/layouts/tilebottom.png"
theme.layout_tiletop                = themes_dir .. "/layouts/tiletop.png"
theme.layout_fairv                  = themes_dir .. "/layouts/fairv.png"
theme.layout_fairh                  = themes_dir .. "/layouts/fairh.png"
theme.layout_spiral                 = themes_dir .. "/layouts/spiral.png"
theme.layout_dwindle                = themes_dir .. "/layouts/dwindle.png"
theme.layout_max                    = themes_dir .. "/layouts/max.png"
theme.layout_fullscreen             = themes_dir .. "/layouts/max.png"
theme.layout_magnifier              = themes_dir .. "/layouts/magnifier.png"
theme.layout_floating               = themes_dir .. "/layouts/floating.png"
theme.layout_uselesstile            = themes_dir .. "/layouts/tile.png"
theme.layout_uselesstileleft        = themes_dir .. "/layouts/tileleft.png"
theme.layout_uselesstiletop         = themes_dir .. "/layouts/tiletop.png"
theme.layout_uselesstilebottom      = themes_dir .. "/layouts/tilebottom.png"
theme.layout_uselessfair            = themes_dir .. "/layouts/fairv.png"
theme.layout_uselessfairh           = themes_dir .. "/layouts/fairh.png"
theme.layout_termfair               = themes_dir .. "/layouts/termfair.png"
theme.layout_uselesspiral           = themes_dir .. "/layouts/spiral.png"
theme.layout_uselessdwindle         = themes_dir .. "/layouts/dwindle.png"
theme.layout_centerfair             = themes_dir .. "/layouts/centerfair.png"
theme.layout_centerwork             = themes_dir .. "/layouts/centerwork.png"

theme.widget_hash1                  = themes_dir .. "/icons/hash1.png"
theme.widget_hash2                  = themes_dir .. "/icons/hash2.png"
theme.widget_hash3                  = themes_dir .. "/icons/hash3.png"
theme.widget_grey                   = themes_dir .. "/icons/grey.png"
theme.widget_black                  = themes_dir .. "/icons/black.png"
theme.widget_ac                     = themes_dir .. "/icons/ac.png"
theme.widget_battery                = themes_dir .. "/icons/battery.png"
theme.widget_battery_low            = themes_dir .. "/icons/battery_low.png"
theme.widget_battery_empty          = themes_dir .. "/icons/battery_empty.png"
theme.widget_mem                    = themes_dir .. "/icons/mem.png"
theme.widget_cpu                    = themes_dir .. "/icons/cpu.png"
theme.widget_temp                   = themes_dir .. "/icons/temp.png"
theme.widget_net                    = themes_dir .. "/icons/net.png"
theme.widget_hdd                    = themes_dir .. "/icons/hdd.png"
theme.widget_music                  = themes_dir .. "/icons/note.png"

return theme
