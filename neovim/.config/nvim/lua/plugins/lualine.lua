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
		local colors = {
			bg = "#201430",
			black = "#000000",
			magenta = "#483160",
			green = "#87FF5F",
			lost = "#666666",
			unit01 = "#67478a",
			selee = "#875FAF",
			mint = "#9cda7c",
			hazard = "#D99145",
			purple = "#AB92FC",
			lcl = "#5b2b41",
			nerv = "#bf2d2d",
			rei = "#e1d6f8",
		}

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
			n = { bg = colors.magenta, fg = colors.green },
			i = { bg = colors.purple, fg = colors.black },
			v = { bg = colors.green, fg = colors.black },
			[""] = { bg = colors.green, fg = colors.black },
			V = { bg = colors.green, fg = colors.black },
			c = { bg = colors.hazard, fg = colors.black },
			no = { bg = colors.green, fg = colors.black },
			s = { bg = colors.hazard, fg = colors.black },
			S = { bg = colors.hazard, fg = colors.black },
			[""] = { bg = colors.hazard, fg = colors.black },
			ic = { bg = colors.hazard, fg = colors.black },
			R = { bg = colors.hazard, fg = colors.black },
			Rv = { bg = colors.hazard, fg = colors.black },
			cv = { bg = colors.hazard, fg = colors.black },
			ce = { bg = colors.hazard, fg = colors.black },
			r = { bg = colors.blood, fg = colors.black },
			rm = { bg = colors.blood, fg = colors.black },
			["r?"] = { bg = colors.lcl, fg = colors.black },
			["!"] = { bg = colors.lcl, fg = colors.black },
			t = { bg = colors.green, fg = colors.black },
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
			color = { bg = colors.selee, fg = colors.rei },
			padding = { left = 0, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		-- inactive left section
		inactive_left({
			function()
				return ""
			end,
			cond = conditions.buffer_not_empty,
			color = { bg = colors.black, fg = colors.lost },
			padding = { left = 1, right = 1 },
		})
		inactive_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { bg = colors.black, fg = colors.lost },
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
			color = { bg = colors.mint, fg = colors.black },
			padding = { left = 1, right = 1 },
			cond = conditions.hide_in_width_first,
			separator = { right = "▓▒░", left = "░▒▓" },
		})

		active_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				error = { fg = colors.black },
				info = { fg = colors.black },
				warn = { fg = colors.black },
			},
			colounit01 = false,
			color = { bg = colors.hazard, fg = colors.black },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})
		active_right({
			"searchcount",
			color = { bg = colors.purple, fg = colors.rei },
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░", left = "░▒▓" },
		})
		active_right({
			"location",
			color = { bg = colors.unit01, fg = colors.rei },
			padding = { left = 1, right = 0 },
			separator = { left = "░▒▓" },
		})
		active_right({
			function()
				local cur = vim.fn.line(".")
				local total = vim.fn.line("$")
				return string.format("%2d%%%%", math.floor(cur / total * 100))
			end,
			color = { bg = colors.unit01, fg = colors.rei },
			padding = { left = 1, right = 1 },
			cond = conditions.hide_in_width,
			separator = { right = "▓▒░" },
		})
		active_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			color = { bg = colors.selee, fg = colors.black },
		})
		active_right({
			"fileformat",
			fmt = string.lower,
			icons_enabled = false,
			cond = conditions.hide_in_width,
			color = { bg = colors.selee, fg = colors.black },
			separator = { right = "▓▒░" },
			padding = { left = 0, right = 1 },
		})

		-- inactive right section
		inactive_right({
			"location",
			color = { bg = colors.black, fg = colors.lost },
			padding = { left = 1, right = 0 },
			separator = { left = "░▒▓" },
		})
		inactive_right({
			"progress",
			color = { bg = colors.black, fg = colors.lost },
			cond = conditions.hide_in_width,
			padding = { left = 1, right = 1 },
			separator = { right = "▓▒░" },
		})
		inactive_right({
			"fileformat",
			fmt = string.lower,
			icons_enabled = false,
			cond = conditions.hide_in_width,
			color = { bg = colors.black, fg = colors.lost },
			separator = { right = "▓▒░" },
			padding = { left = 0, right = 1 },
		})
		--
		return config
	end,
}
