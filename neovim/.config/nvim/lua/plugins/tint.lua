return {
	"levouh/tint.nvim",
	event = "VeryLazy",
	config = function()
		local tint = require("tint")
		local transforms = require("tint.transforms")
		tint.setup({
			transforms = {
				transforms.tint_with_threshold(-10, "#1a1a1a", 7),
				transforms.saturate(0.65),
			},
			tint_background_colors = true,
			highlight_ignore_patterns = {
				"SignColumn",
				"LineNr",
				"CursorLine",
				"WinSeparator",
				"VertSplit",
				"StatusLineNC",
			},
		})
		vim.api.nvim_create_autocmd("FocusGained", {
			callback = function()
				tint.untint(vim.api.nvim_get_current_win())
			end,
		})
		vim.api.nvim_create_autocmd("FocusLost", {
			callback = function()
				tint.tint(vim.api.nvim_get_current_win())
			end,
		})
	end,
}
