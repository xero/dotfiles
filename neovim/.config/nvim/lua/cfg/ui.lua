--           ██
--          ░░
--  ██    ██ ██ ██████████  ██████  █████
-- ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
-- ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
--  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
--   ░░██   ░██ ███ ░██ ░██░███   ░░█████
--    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ xero <x@xero.style>
-- ░▓ code   ▓ https://code.x-e.ro/dotfiles
-- ░▓ mirror ▓ https://git.io/.files
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░
--
-- show matching brackets/parenthesis
vim.opt.showmatch = true

-- disable startup message
vim.opt.shortmess:append("sI")

-- cmd display (set to zero to autohide)
vim.opt.cmdheight = 1

-- gutter sizing
vim.opt.signcolumn = "auto:2"

-- syntax highlighting
vim.opt.termguicolors = true
vim.opt.synmaxcol = 512

-- show line numbers
vim.opt.number = true

-- default no line wrapping
vim.opt.wrap = false

-- set indents when wrapped
vim.opt.breakindent = true

-- highlight cursor
vim.opt.cursorline = true
-- set cursorcolumn = true

-- show invisibles
vim.opt.listchars = { tab = "  ", trail = "·", extends = "»", precedes = "«", nbsp = "░" }
vim.opt.list = true

-- split style
vim.opt.fillchars = { vert = "▒" }
vim.opt.splitbelow = true
vim.opt.splitright = true

-- custom tabline
local noname = "[unnamed]"

local function extract_filename(win)
	local b = vim.api.nvim_win_get_buf(win)
	local fullname = vim.api.nvim_buf_get_name(b)
  local mod = vim.api.nvim_buf_get_option(b, 'modified') and "◈ " or ""
	if fullname ~= "" then
		local shortname = vim.fn.fnamemodify(fullname, ":~:.:gs%(.?[^/])[^/]*/%\1/%")
		if #shortname > 30 then shortname = vim.fn.fnamemodify(fullname, ":t") end
		return mod..shortname
	end
end

local function get_best_window_filename(tabpage, window)
	local filename = extract_filename(window)
	if filename == nil then
		local wins = vim.api.nvim_tabpage_list_wins(tabpage)
		if #wins > 1 then
			for _, win in ipairs(wins) do
				filename = extract_filename(win)
				break
			end
		end
	end
	if filename == nil then
		return noname
	end
	return filename
end

local function is_float_win(win)
	local config = vim.api.nvim_win_get_config(win)
	return config.zindex and config.zindex > 0
end

local function getname(tabpage)
	-- vim.F.npcall(vim.api.nvim_tabpage_get_var, tabpage, "tab_title")
	local title = vim.t[tabpage].tab_title
	if title ~= nil then
		return title
	end

	local window = vim.api.nvim_tabpage_get_win(tabpage)
	-- don't replace the last filename-buffer w/ floating windows
	if is_float_win(window) then
		return vim.t[tabpage].last_buffer_filename
	end

	local filename = get_best_window_filename(tabpage, window)
	vim.t[tabpage].last_buffer_filename = filename
	return filename
end

function Tabline()
	local tl = {}
	local current = vim.api.nvim_get_current_tabpage()
	for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		local hi = tabpage == current and "%#TabLineSel#" or "%#TabLine#"
		local hiSep = tabpage == current and "%#TabLineSelSep#" or "%#TabLineSep#"
		table.insert(tl, "%" .. i .. "T") -- mouse click target region
		table.insert(tl, hi .. " " .. getname(tabpage) .. " ")
		table.insert(tl, hiSep .. "▓▒░ " .. hi)
	end
	table.insert(tl, "%T") -- end mouse click region(s).
	table.insert(tl, "%#TabLineFill#")
	return table.concat(tl, '')
end

vim.opt.tabline = [[%!v:lua.Tabline()]]
