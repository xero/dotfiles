return {
	"xero/miasma.nvim",
	-- dev = true,
	branch = "lua",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("miasma")
	end,
}
