return {
	'tadaa/vimade',
	event = "VeryLazy",
	opts = {
		recipe = { "minimalist", { animate = true} }, -- 'default', 'minimalist', 'duo', and 'ripple'
		ncmode = "buffers",
		fadelevel = 0.4, -- any value between 0 and 1. 0 is hidden and 1 is opaque.
		tint = {
			-- bg = {rgb={0,0,0}, intensity=0.3}, -- adds 30% black to background
			-- fg = {rgb={0,0,255}, intensity=0.3}, -- adds 30% blue to foreground
			-- fg = {rgb={120,120,120}, intensity=1}, -- all text will be gray
			-- sp = {rgb={255,0,0}, intensity=0.5}, -- adds 50% red to special characters
		},
		blocklist = {
			default = {
				highlights = {
					---@diagnostic disable-next-line
					laststatus_3 = function(win, active)
						if vim.go.laststatus == 3 then
							return "StatusLineNC"
						end
					end,
					-- Prevent from highlighting.
					"TabLineSel",
					"Pmenu",
					"PmenuSel",
					"PmenuKind",
					"PmenuKindSel",
					"PmenuExtra",
					"PmenuExtraSel",
					"PmenuSbar",
					"PmenuThumb",
					"SignColumn",
					"CursorLine",
					"WinSeparator",
					"VertSplit",
					"StatusLineNC",
				},
				buf_opts = { buftype = { "prompt" } },
			},
			default_block_floats = function(win, active)
				return win.win_config.relative ~= "" and (win ~= active or win.buf_opts.buftype == "terminal") and true
					or false
			end,
		},
		link = {},
		groupdiff = true,
		groupscrollbind = false,
		enablefocusfading = true,
		checkinterval = 1000,
		usecursorhold = false,
		nohlcheck = true,
		focus = {
			providers = {
				filetypes = {
					default = {
						-- {'snacks', {}},
						-- {'mini', {}},
						-- {'hlchunk', {}},
						{
							"treesitter", {
								min_node_size = 2,
								min_size = 1,
								max_size = 0,
								exclude = {
									"script_file",
									"stream",
									"document",
									"source_file",
									"translation_unit",
									"chunk",
									"module",
									"stylesheet",
									"statement_block",
									"block",
									"pair",
									"program",
									"switch_case",
									"catch_clause",
									"finally_clause",
									"property_signature",
									"dictionary",
									"assignment",
									"expression_statement",
									"compound_statement",
								},
							},
						},{
							"blanks", {
								min_size = 1,
								max_size = "35%",
							},
						},{
							"static", {
								size = "35%",
							},
						},
					},
				},
			},
		},
	},
}
