return {
	"xero/evangelion.nvim",
	-- dev = true,
	-- branch = "dev",
	lazy = false,
	priority = 1000,
	cmd = "Evangelion",
	config = function()
		vim.cmd.colorscheme("evangelion")
		require("utils.functions").cmd("Evangelion", function()
			print("GET IN THE FUKKEN ROBOT SHINJI!!!")
			vim.cmd.colorscheme("evangelion")
		end, { desc = "enable evangelion colorscheme" })
	end,
}
