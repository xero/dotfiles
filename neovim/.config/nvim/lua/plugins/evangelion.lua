return {
	"xero/evangelion.nvim",
	dev = true,
	branch = "dev",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("evangelion")
	end,
}
