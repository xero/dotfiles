return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		-- disable until lualine loads
		vim.opt.laststatus = 0
	end,
	opts = function()
		-- evangelion colors
		local colors = require("evangelion.unit01").get()
		-- size display logic
		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width_first = function()
				return vim.fn.winwidth(0) > 80
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 70
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}
		-- auto change color according to neovims mode
		local mode_color = {
			n = { bg = colors.longingus, fg = colors.kaworu },
			i = { bg = colors.dummyplug, fg = colors.core },
			v = { bg = colors.kaworu, fg = colors.core },
			[""] = { bg = colors.kaworu, fg = colors.core },
			V = { bg = colors.kaworu, fg = colors.core },
			c = { bg = colors.lcl, fg = colors.core },
			no = { bg = colors.kaworu, fg = colors.core },
			s = { bg = colors.lcl, fg = colors.core },
			S = { bg = colors.lcl, fg = colors.core },
			[""] = { bg = colors.lcl, fg = colors.core },
			ic = { bg = colors.lcl, fg = colors.core },
			R = { bg = colors.lcl, fg = colors.core },
			Rv = { bg = colors.lcl, fg = colors.core },
			cv = { bg = colors.lcl, fg = colors.core },
			ce = { bg = colors.lcl, fg = colors.core },
			r = { bg = colors.nerv, fg = colors.core },
			rm = { bg = colors.nerv, fg = colors.core },
			["r?"] = { bg = colors.nerv, fg = colors.core },
			["!"] = { bg = colors.nerv, fg = colors.core },
			t = { bg = colors.kaworu, fg = colors.core },
		}
		-- config
		local config = {
			options = {
				-- remove default sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- setting defaults to statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- clear defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- clear for later use
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- clear defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- clear for later use
				lualine_c = {},
				lualine_x = {},
			},
		}

		-- insert active component in lualine_c at left section
		local function active_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- insert inactive component in lualine_c at left section
		local function inactive_left(component)
			table.insert(config.inactive_sections.lualine_c, component)
		end

		-- insert active component in lualine_x at right section
		local function active_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		-- insert inactive component in lualine_x at right section
		local function inactive_right(component)
			table.insert(config.inactive_sections.lualine_x, component)
		end

		-- dump object contents
		local function dump(o)
			if type(o) == "table" then
				local s = ""
				for k, v in pairs(o) do
					if type(k) ~= "number" then
						k = '"' .. k .. '"'
					end
					s = s .. dump(v) .. ","
				end
				return s
			else
				return tostring(o)
			end
		end

		-- active left section
		active_left({
			function()
				local icon
				local ok, devicons = pcall(require, "nvim-web-devicons")
				if ok then
					icon = devicons.get_icon(vim.fn.expand("%:t"))
					if icon == nil then
						icon = devicons.get_icon_by_filetype(vim.bo.filetype)
					end
				else
					if vim.fn.exists("*WebDevIconsGetFileTypeSymbol") > 0 then
						icon = vim.fn.WebDevIconsGetFileTypeSymbol()
					end
				end
				if icon == nil then
					icon = ""
				end
				return icon:gsub("%s+", "")
			end,
			color = function()
				return { bg = mode_color[vim.fn.mode()].bg, fg = mode_color[vim.fn.mode()].fg }
			end,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
		})
		active_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = function()
				return { bg = mode_color[vim.fn.mode()].bg, fg = mode_color[vim.fn.mode()].fg }
			end,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
			symbols = {
				modified = "󰶻 ",
				readonly = " ",
				unnamed = " ",
				newfile = " ",
			},
		})
		active_left({
			"branch",
			icon = "",
			color = { bg = colors.unit01, fg = colors.rei },
			padding = { left = 0, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		-- inactive left section
		inactive_left({
			function()
				return ""
			end,
			cond = conditions.buffer_not_empty,
			color = { bg = colors.core, fg = colors.fog },
			padding = { left = 1, right = 1 },
		})
		inactive_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { bg = colors.core, fg = colors.fog },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
			symbols = {
				modified = "",
				readonly = "",
				unnamed = "",
				newfile = "",
			},
		})

		-- active right section
		active_right({
			function()
				if vim.lsp.get_clients then
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					local clients_list = {}
					for _, client in pairs(clients) do
						if not clients_list[client.name] then
							table.insert(clients_list, client.name)
						end
					end
					local lsp_lbl = dump(clients_list):gsub("(.*),", "%1")
					return lsp_lbl:gsub(",", ", ")
				end
			end,
			icon = " ",
			color = { bg = colors.kaji, fg = colors.core },
			padding = { left = 1, right = 1 },
			cond = conditions.hide_in_width_first,
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		active_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.core },
				info = { fg = colors.core },
				warn = { fg = colors.core },
			},
			colounit01 = false,
			color = { bg = colors.lcl, fg = colors.core },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})
		active_right({
			"searchcount",
			color = { bg = colors.dummyplug, fg = colors.rei },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})
		active_right({
			"location",
			color = { bg = colors.mari, fg = colors.rei },
			padding = { left = 1, right = 0 },
			separator = { left = "░▒▓" },
		})
		active_right({
			function()
				local cur = vim.fn.line(".")
				local total = vim.fn.line("$")
				return string.format("%2d%%%%", math.floor(cur / total * 100))
			end,
			color = { bg = colors.mari, fg = colors.rei },
			padding = { left = 1, right = 1 },
			cond = conditions.hide_in_width,
			separator = { right = "▓▒░" },
		})
		active_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			color = { bg = colors.unit01, fg = colors.core },
		})
		active_right({
			"fileformat",
			fmt = string.lower,
			icons_enabled = false,
			cond = conditions.hide_in_width,
			color = { bg = colors.unit01, fg = colors.core },
			separator = { right = "▓▒░" },
			padding = { left = 0, right = 1 },
		})

		-- inactive right section
		inactive_right({
			"location",
			color = { bg = colors.core, fg = colors.fog },
			padding = { left = 1, right = 0 },
			separator = { left = "░▒▓" },
		})
		inactive_right({
			"progress",
			color = { bg = colors.core, fg = colors.fog },
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
		})
		inactive_right({
			"fileformat",
			fmt = string.lower,
			icons_enabled = false,
			cond = conditions.hide_in_width,
			color = { bg = colors.core, fg = colors.fog },
			separator = { right = "▓▒░" },
			padding = { left = 0, right = 1 },
		})
		return config
	end,
}
