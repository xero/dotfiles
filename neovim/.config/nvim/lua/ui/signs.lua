return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add          = { text = '▐' },
				change       = { text = '▐' },
				delete       = { text = '▐' },
				topdelete    = { text = '▐' },
				changedelete = { text = '▐' },
				untracked    = { text = '▐' },
			},
			signcolumn     = true,  -- toggle with `:Gitsigns toggle_signs`
			linehl         = false, -- toggle with `:Gitsigns toggle_linehl`
			numhl          = false, -- toggle with `:Gitsigns toggle_nunhl`
			word_diff      = false, -- toggle with `:Gitsigns toggle_word_diff`
			sign_priority  = 9,
			watch_gitdir   = {
				interval     = 1000,
			},
			attach_to_untracked = false,
		})
	end,
	event = { "BufReadPre", "BufNewFile" },
}
