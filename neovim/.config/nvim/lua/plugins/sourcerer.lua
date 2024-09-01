return {
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
