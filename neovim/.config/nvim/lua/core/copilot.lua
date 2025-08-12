return {
	"CopilotC-Nvim/CopilotChat.nvim",
	lazy = true,
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	cmd = { "CopilotChat" },

	init = function()
		vim.g.copilot_chat_disable_defaults = true

		local r = require("utils.remaps")
		local f = require("utils.functions")
		f.cmd("CC", ":CopilotChat", { desc = "Copilot Chat" })
		r.noremap("n", "<leader>C", ":CC<cr>", "copilot chat")
		r.map_virtual({ "<leader>C", group = "Copilot", icon = { icon = "", hl = "Constant" } })
	end,
	opts = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
		local token_file = vim.fn.expand("~/.config/nvim/gh_token")
		local token = ""
		local f = io.open(token_file, "r")
		if f then
			token = f:read("*l")
			f:close()
		end
		return {
			headers = {
				user = "   ",
				assistant = "   ",
				tool = "   ",
			},
			github_token = token,
			temperature = 0.2,
			remember_as_sticky = true,
			window = {
				layout = "vertical",
			},
			mappings = {
				reset = {
					normal = "<nop>",
					insert = "<nop>",
				},
				show_diff = {
					full_diff = true,
				},
			},
		}
	end,
}
