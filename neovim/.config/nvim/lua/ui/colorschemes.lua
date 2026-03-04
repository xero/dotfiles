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
	-- main colorscheme
	"xero/evangelion.nvim",
	-- other themes
	dependencies = {
		"xero/miasma.nvim",
		"xero/sourcerer.vim",
	},
	lazy = false,
	priority = 1000,
	opts = {},
	-- dev = true,
	-- branch = "dev",
	config = function()
		vim.cmd.colorscheme("evangelion")
	end,
}
