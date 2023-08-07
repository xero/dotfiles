return {
	"nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		-- no overrides necessary on mac
		require("nvim-web-devicons").setup({})
	end,
}
