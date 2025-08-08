return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			modes = {
				diagnostics = {
					auto_open = false,
					auto_close = true,
				},
			},
			warn_no_results = false,
			icons = require("utils.icons").trouble,
		})
		require("utils.remaps").map_virtual({
			{ "<leader>t", group = "trouble", icon = { icon = " ", hl = "Constant" } },
			{ "<leader>ts", group = "symbols", icon = { icon = " ", hl = "Constant" } },
		})
	end,
	keys = {{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "trouble diagnostics",
		},{
			"<leader>tT",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "project diagnostics",
		},{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=true<cr>",
			desc = "symbols",
		},
	},
}
