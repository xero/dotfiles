return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	init = function()
		vim.keymap.set(
			"",
			"<Leader>ll",
			require("lsp_lines").toggle,
			{ desc = "toggle LSP lines" }
		)
	end,
	config = function()
		local lsp_lines = require("lsp_lines")
		lsp_lines.setup()
	end,
	keys = "<leader>ll",
}
