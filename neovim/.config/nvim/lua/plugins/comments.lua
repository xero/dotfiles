return {
	"terrortylor/nvim-comment",
	event = "BufReadPost",
	config = function()
		require('nvim_comment').setup()
		require("which-key").register({
			g = {
				name = "go",
				c = {
					name = "comment",
					c = "line",
				}
			}
		})
	end,
}
