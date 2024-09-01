return {
	"xero/miasma.nvim",
	-- dev = true,
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
}
