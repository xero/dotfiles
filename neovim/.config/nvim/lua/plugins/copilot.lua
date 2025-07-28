return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
		{ "zbirenbaum/copilot-cmp" },
	},
	cmd = { "CopilotChat" },
	init = function()
		vim.g.copilot_chat_disable_defaults = true

		local r = require("utils.remaps")
		local f = require("utils.functions")
		f.cmd("CC", ":CopilotChat", { desc = "Copilot Chat" })
		r.noremap("n", "<leader>m", ":CC<cr>", "copilot chat")
		r.map_virtual({ "<leader>m", group = "Copilot", icon = { icon = "", hl = "Constant" } })
	end,
	opts = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
		require("copilot_cmp").setup()
		local token_file = vim.fn.expand("~/.config/nvim/gh_token")
		local token = ""
		local f = io.open(token_file, "r")
		if f then
			token = f:read("*l")
			f:close()
		end
		return {
			separator = "████▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
			headers = {
				user = ' ',
				assistant = ' ',
				tool = ' ',
			},
			github_token = token,
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
