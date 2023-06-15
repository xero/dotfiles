return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	lazy = true,
	init = function()
		vim.keymap.set(
			"",
			"<Leader>ll",
			require("lsp_lines").toggle,
			{ desc = "toggle lsp_lines" }
		)
	end,
	config = function()
		 require("lsp_lines").setup()
	end,
}
