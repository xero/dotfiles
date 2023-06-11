return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add          = { text = '│' },
				change       = { text = '┆' },
				delete       = { text = '-' },
				topdelete    = { text = '-' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signcolumn     = true,  -- Toggle with `:Gitsigns toggle_signs`
			linehl         = false, -- Toggle with `:Gitsigns toggle_linehl`
			numhl          = false, -- Toggle with `:Gitsigns toggle_nunhl`
			word_diff      = false, -- Toggle with `:Gitsigns toggle_word_diff`
			sign_priority  = 9,
			watch_gitdir   = {
				interval     = 1000,
			},
		})
		local present_scrollbar = pcall(require, "scrollbar")
		if present_scrollbar then
			require("scrollbar.handlers.gitsigns").setup()
		end
	end,
	event = { "BufReadPre", "BufNewFile" },
}
