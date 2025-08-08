return {
	"Wansmer/treesj",
	keys = { "<space>m", "<space>j", "<space>s" },
	config = function()
		require("treesj").setup({
			notify = true,
			check_syntax_error = true,
		})
	end,
}
