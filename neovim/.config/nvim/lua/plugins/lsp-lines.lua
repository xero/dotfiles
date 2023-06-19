return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function()
		require("lsp_lines").setup()
		vim.keymap.set(
			"n",
			"<Leader>ll",
			require("lsp_lines").toggle,
			{ desc = "toggle lsp_lines" }
		)
	end,
}
