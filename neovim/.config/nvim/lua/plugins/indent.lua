return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	config = function()
		vim.g.indent_blankline_context_char = "┊"
		vim.g.indent_blankline_char_list = { "┊", "┊", "┊", "┊" }
		vim.g.indent_blankline_char_list_blankline = { "┊", "┊", "┊", "┊" }
		require("indent_blankline").setup({
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = false,
		})
	end,
}
