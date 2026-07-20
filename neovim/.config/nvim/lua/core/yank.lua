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
	"ojroques/vim-oscyank",
	event = "VeryLazy",
	dependencies = {
		"ojroques/nvim-osc52",
	},
	config = function()
		vim.api.nvim_set_option("clipboard", "unnamedplus")
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
			callback = function()
				vim.hl.on_yank({ higroup = "IncSearch", timeout = 500 })
				if vim.v.event.operator == "y" and vim.v.event.regname == "" then
					vim.cmd [[OSCYankRegister]]
				end
			end,
		})
	end,
}
