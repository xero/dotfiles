return {
	"folke/which-key.nvim",
	keys = { "<leader>" },
	config = function()
		local which_key = require("which-key")

		which_key.setup({
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
			window = {
				border = "shadow",
				position = "bottom",
				margin = { 0, 1, 1, 5 },
				padding = { 1, 2, 1, 2 },
			},
			triggers_nowait = {
				"`",
				"'",
				"g`",
				"g'",
				'"',
				"<c-r>",
				"z=",
			},
		})

		local opts = {
			prefix = "<leader>",
		}

		local groups = {
			b = { name = "buffer" },
			s = { name = "search" },
			-- g = { name = "git" },
			r = { name = "refactor" },
			l = { name = "lsp" },
			d = { name = "debug" },
			m = { name = "macro/markdown" },
			n = { name = "notifications" },
			["<tab>"] = { name = "tabs" },
			[";"] = { name = "test" },
			["'"] = { name = "marks" },
			["/"] = { name = "search" },
			["/g"] = { name = "git" },
			["/gd"] = { name = "diff" },
			["["] = { name = "previous" },
			["]"] = { name = "next" },
		}

		which_key.register(groups, opts)
	end,
}
