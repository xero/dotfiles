-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		-- disable default "s" map, use for "surround" mnemonic.
		vim.keymap.set({ "n", "v", "o" }, "s", "<Nop>")
		vim.g.nvim_surround_no_normal_mappings = true
		require("nvim-surround").setup({})
		local r = require("utils.remaps")
		-- which key group
		r.map_virtual({ "s", group = "surround", icon = { icon = "󰗅", hl = "Constant" } })
		-- main mappings
		r.noremap("n", "sa", "<Plug>(nvim-surround-normal)", "add surrounding pair")
		r.noremap("n", "sd", "<Plug>(nvim-surround-delete)", "delete surrounding pair")
		r.noremap("n", "sr", "<Plug>(nvim-surround-change)", "change surrounding pair")
		r.noremap("x", "s", "<Plug>(nvim-surround-visual)", "add surrounding pair around a visual selection")
		r.noremap("x", "S", "<Plug>(nvim-surround-visual-line)", "add surrounding pair around a visual selection, on new lines")
		-- convenience
		r.map("n", "sw", "saw", "surround word")
		r.map("n", "sW", "saW", "surround full word")
		r.map("n", "sc", function()
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local current_line = vim.api.nvim_get_current_line()
			local char = current_line:sub(col + 1, col + 1)
			vim.api.nvim_feedkeys("sr" .. char, "m", false)
		end, "change surroundings")
	end,
}
