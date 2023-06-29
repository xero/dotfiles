return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			ui = {
				border = "shadow",
				icons = require("utils.icons").mason,
				zindex = 99,
			},
		})
	end,
}
