return {
	"monkoose/matchparen.nvim",
	config = function()
		require('matchparen').setup({
			on_startup = true,
			hl_group = 'MatchParen',
			debounce_time = 100,
		})
	end,
}
