return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = {
		"nmac427/guess-indent.nvim",
	},
	main = "ibl",
	event = "VeryLazy",
	config = function()
		require("ibl").setup({
			scope = {
				show_start = false,
			},
			indent = {
				char = "┊",
				tab_char = "┊",
				smart_indent_cap = true,
			},
			whitespace = {
				remove_blankline_trail = true,
			},
		})
		require("guess-indent").setup({})
	end,
}
