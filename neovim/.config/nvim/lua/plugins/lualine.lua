return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		-- disable until lualine loads
		vim.opt.laststatus = 0
	end,
	opts = function()
		local colors = {
			bg = "#222222",
			black = "#1c1c1c",
			grey = "#666666",
			red = "#685742",
			green = "#5f875f",
			yellow = "#B36D43",
			blue = "#78824B",
			magenta = "#bb7744",
			cyan = "#C9A554",
			white = "#D7C483",
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			"filetype",
			cond = conditions.buffer_not_empty,
			icon_only = true,
			colored = false,
			icon = { color = { fg = colors.white } },
			color = function()
				return { bg = mode_color[vim.fn.mode()], fg = colors.white }
			end,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
		})
		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = function()
				return { bg = mode_color[vim.fn.mode()], fg = colors.white }
			end,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
			symbols = {
				modified = "»",
				readonly = "",
				unnamed = "",
				newfile = "",
			},
		})
		ins_left({
			"branch",
			icon = "",
			color = { bg = colors.blue, fg = colors.black },
			padding = { left = 0, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		ins_right({
			function()
				local msg = "n/a"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " ",
			color = { bg = colors.green,  fg = colors.black },
			padding = { left = 1, right = 1 },
			cond = conditions.hide_in_width,
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		ins_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			colored = false,
			color = { bg = colors.magenta, fg = colors.black },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		ins_right({
			"searchcount",
			color = { bg = colors.cyan, fg = colors.black},
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})
		ins_right({
			"location",
			color = { bg = colors.red, fg = colors.white},
			padding = { left = 1, right = 0 },
			separator = { left = "░▒▓" },
		})
		ins_right({
			"progress",
			color = { bg = colors.red, fg = colors.white},
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
		})

		ins_right({
			"diff",
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "▒▓" },
		})

		ins_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			color = { bg = colors.blue, fg = colors.black },
		})

		ins_right({
			"fileformat",
			fmt = string.lower,
			icons_enabled = false,
			cond = conditions.hide_in_width,
			color = { bg = colors.blue, fg = colors.black },
			separator = { right = "▓▒░" },
			padding = { left = 0, right = 1 },
		})

		--		ins_right({
		--			function()
		--				return "░▒▓"
		--			end,
		--			color = { bg = colors.blue, fg = colors.black },
		--			padding = { left = 1 },
		--		})
		return config
	end,
}
