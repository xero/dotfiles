local f= require("utils.functions")
return {
	"xero/evangelion.nvim",
	-- dev = true,
	-- branch = "dev",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("evangelion")
		f.cmd("Evangelion", function()
			vim.cmd.colorscheme("evangelion")
			print("get in the robot shinji!")
		end, { desc = "enable evangelion colorscheme" })
	end,
-- },{
-- 	"xero/miasma.nvim",
-- 	branch = "lua",
-- 	verylazy = true,
-- 	config = function()
-- 		vim.cmd.colorscheme("miasma")
-- 		f.cmd("Miasma", function()
-- 			vim.cmd.colorscheme("miasma")
-- 			print("a fog descends upon your editor")
-- 		end, { desc = "enable miasma colorscheme" })
-- 	end,
-- },{
-- 	"xero/sourcerer.vim",
-- 	verylazy = true,
-- 	config = function()
-- 		vim.cmd.colorscheme("sourcerer")
-- 		f.cmd("Sourcerer", function()
-- 			vim.cmd.colorscheme("sourcerer")
-- 			print("time to read code like a wizard")
-- 		end, { desc = "enable sourcerer colorscheme" })
-- 	end,
}
