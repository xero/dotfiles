return {
	"xero/evangelion.nvim",
	-- dev = true,
	-- branch = "dev",
	lazy = false,
	priority = 1000,
	opts = {},
	init = function()
		vim.cmd.colorscheme("evangelion")
	end,
},{
	"xero/miasma.nvim",
	branch = "lua",
	lazy = true,
	cmd = "Miasma",
	config = function()
		vim.cmd.colorscheme("miasma")
		require("utils.functions").cmd("Miasma", function()
			vim.cmd.colorscheme("miasma")
			print("a fog descends upon your editor")
		end, { desc = "enable miasma colorscheme" })
	end,
},{
	"xero/sourcerer.vim",
	lazy = true,
	cmd = "Sourcerer",
	config = function()
		vim.cmd.colorscheme("sourcerer")
		require("utils.functions").cmd("Sourcerer", function()
			vim.cmd.colorscheme("sourcerer")
			print("time to read code like a wizard")
		end, { desc = "enable sourcerer colorscheme" })
	end,
}
