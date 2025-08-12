return {
	'tadaa/vimade',
	event = "VeryLazy",
  cond = function()
    return not vim.g.neovide
  end,
	opts = {
		ncmode = "buffers",
		recipe = { "duo", {
			animate = true,
			fadelevel = 0.98, -- 0 hidden / 1 opaque.
		} },
		tint = {
			bg = {rgb={0,0,0}, intensity=0.15}, -- +15% black bg
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
			buf_and_filetypes = {
				buf_opts = {
					buftype = {
						"help",
					},
					filetype = {
						"help",
						"man",
						"trouble",
					},
				},
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
						{
							"blanks", {
								min_size = 1,
								max_size = "35%",
							},
						},{
							"static", {
								size = "35%",
							},
						},
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
						},
					},
				},
			},
		},
	},
}
